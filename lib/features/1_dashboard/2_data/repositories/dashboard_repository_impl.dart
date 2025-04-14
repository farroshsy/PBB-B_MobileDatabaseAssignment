import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/exceptions.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/network/network_info.dart';
import '../../1_domain/entities/dashboard.dart';
import '../../1_domain/entities/dashboard_stats.dart';
import '../../1_domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_data_source.dart';
import '../datasources/dashboard_local_data_source.dart';

/// Implementation of dashboard repository
class DashboardRepositoryImpl implements DashboardRepository {
  /// Creates a dashboard repository implementation
  const DashboardRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  /// Remote data source for dashboard data
  final DashboardRemoteDataSource remoteDataSource;
  
  /// Local data source for cached dashboard data
  final DashboardLocalDataSource localDataSource;
  
  /// Network connectivity checker
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<Dashboard>>> getAll() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDashboards = await remoteDataSource.getDashboards();
        await localDataSource.cacheDashboards(remoteDashboards);
        return Right(remoteDashboards);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localDashboards = await localDataSource.getCachedDashboards();
        return Right(localDashboards);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Dashboard>> getById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDashboard = await remoteDataSource.getDashboardById(id);
        await localDataSource.cacheDashboard(remoteDashboard);
        return Right(remoteDashboard);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localDashboard = await localDataSource.getCachedDashboardById(id);
        return Right(localDashboard);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }
  
  @override
  Future<Either<Failure, DashboardStats>> getDashboardStats() async {
    // --- MOCK IMPLEMENTATION START ---
    print("Repository: Returning Mock Dashboard Stats");
    await Future.delayed(const Duration(milliseconds: 850)); // Simulate delay

    // Create mock data
    const mockStats = DashboardStats(
      totalUsers: 987,
      activeUsers: 123,
      totalRevenue: 15032.75,
      period: 'monthly',
      growthRate: 15.2,
      topPerformers: ['Product X', 'Service Y', 'Region Z'],
    );

    return const Right(mockStats);
    // --- MOCK IMPLEMENTATION END ---
    
    /* // Original Implementation commented out
    if (await networkInfo.isConnected) {
      try {
        final remoteStats = await remoteDataSource.getDashboardStats();
        await localDataSource.cacheDashboardStats(remoteStats);
        return Right(remoteStats);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localStats = await localDataSource.getCachedDashboardStats();
        return Right(localStats);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
    */
  }
  
  @override
  Future<Either<Failure, Dashboard>> updateLayout(Dashboard dashboard) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(
        message: 'No internet connection',
      ));
    }

    try {
      final updatedDashboard = await remoteDataSource.updateDashboard(dashboard);
      await localDataSource.cacheDashboard(updatedDashboard);
      return Right(updatedDashboard);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
