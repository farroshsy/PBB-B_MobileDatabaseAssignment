import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/exceptions.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/network/network_info.dart';
import '../../1_domain/entities/home.dart';
import '../../1_domain/entities/home_data.dart';
import '../../1_domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';
import '../datasources/home_local_data_source.dart';

/// Implementation of home repository
class HomeRepositoryImpl implements HomeRepository {
  /// Creates a home repository implementation
  const HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  /// Remote data source
  final HomeRemoteDataSource remoteDataSource;
  
  /// Local data source
  final HomeLocalDataSource localDataSource;
  
  /// Network connectivity checker
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<Home>>> getAll() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteHomes = await remoteDataSource.getHomes();
        await localDataSource.cacheHomes(remoteHomes);
        return Right(remoteHomes);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localHomes = await localDataSource.getCachedHomes();
        return Right(localHomes);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Home>> getById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteHome = await remoteDataSource.getHomeById(id);
        await localDataSource.cacheHome(remoteHome);
        return Right(remoteHome);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localHome = await localDataSource.getCachedHomeById(id);
        return Right(localHome);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }
  
  @override
  Future<Either<Failure, HomeData>> getHomeData() async {
    // --- MOCK IMPLEMENTATION START ---
    print("Repository: Returning Mock Home Data");
    await Future.delayed(const Duration(milliseconds: 700)); // Simulate delay

    // Create mock data based on HomeData entity
    final mockData = HomeData(
      userGreeting: "Welcome back, Farros!",
      banners: [
        BannerItem(
          id: 'banner-1',
          imageUrl: 'https://picsum.photos/seed/banner1/600/300', // Placeholder image
          title: 'Special Offer!',
          subtitle: 'Limited time only',
          actionLabel: 'Learn More',
          actionUrl: '/offers/1',
        ),
        BannerItem(
          id: 'banner-2',
          imageUrl: 'https://picsum.photos/seed/banner2/600/300',
          title: 'New Feature Available',
        ),
      ],
      featuredItems: [
        FeaturedItem(
          id: 'item-1',
          title: 'Featured Product A',
          imageUrl: 'https://picsum.photos/seed/item1/300/200',
          subtitle: 'High demand item',
        ),
        FeaturedItem(
          id: 'item-2',
          title: 'Featured Service B',
          imageUrl: 'https://picsum.photos/seed/item2/300/200',
        ),
         FeaturedItem(
          id: 'item-3',
          title: 'Featured Article C',
          imageUrl: 'https://picsum.photos/seed/item3/300/200',
        ),
      ],
      notifications: [
        NotificationItem(
          id: 'notif-1',
          title: 'Your order has shipped!',
          createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        ),
         NotificationItem(
          id: 'notif-2',
          title: 'New message received',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          read: true,
        ),
      ]
    );

    return Right(mockData); 
    // --- MOCK IMPLEMENTATION END ---
    
    /* // Original Implementation commented out
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getHomeData();
        await localDataSource.cacheHomeData(remoteData);
        return Right(remoteData);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localData = await localDataSource.getCachedHomeData();
        return Right(localData);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
    */
  }
  
  @override
  Future<Either<Failure, bool>> markNotificationAsRead(String notificationId) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(
        message: 'No internet connection',
      ));
    }

    try {
      final success = await remoteDataSource.markNotificationAsRead(notificationId);
      if (success) {
        try {
          // Update local cache too
          await localDataSource.markNotificationAsRead(notificationId);
        } on CacheException {
          // Ignore cache exceptions when updating notification status
        }
      }
      return Right(success);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
