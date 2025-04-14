import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/exceptions.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/network/network_info.dart';
import '../../1_domain/entities/setting.dart';
import '../../1_domain/repositories/setting_repository.dart';
import '../datasources/setting_remote_data_source.dart';

/// Implementation of [SettingRepository] (Renamed)
class SettingRepoImpl implements SettingRepository {
  /// Creates a setting repository implementation
  const SettingRepoImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  /// The remote data source
  final SettingRemoteDataSource remoteDataSource;
  
  /// Network connectivity checker
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<Setting>>> getAll() async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(
        message: 'No internet connection',
      ));
    }

    try {
      final remoteData = await remoteDataSource.getAll();
      return Right(remoteData);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Setting>> getById(String id) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(
        message: 'No internet connection',
      ));
    }

    try {
      final remoteData = await remoteDataSource.getById(id);
      return Right(remoteData);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
