import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/exceptions.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/network/network_info.dart';
import '../../1_domain/entities/profile.dart';
import '../../1_domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';
import '../datasources/profile_local_data_source.dart';

/// Implementation of [ProfileRepository]
class ProfileRepositoryImpl implements ProfileRepository {
  /// Creates a profile repository implementation
  const ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  /// The remote data source
  final ProfileRemoteDataSource remoteDataSource;
  
  /// The local data source
  final ProfileLocalDataSource localDataSource;
  
  /// Network connectivity checker
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    // --- MOCK IMPLEMENTATION START ---
    print("Repository: Returning Mock Profile Data");
    await Future.delayed(const Duration(milliseconds: 550)); // Simulate delay

    // Create mock Profile data
    final mockProfile = Profile(
      id: 'mock-user-123',
      name: 'Mock User',
      email: 'mock.user@example.com',
      photoUrl: 'https://picsum.photos/seed/profilepic/200', // Placeholder image
      bio: 'Flutter developer passionate about creating beautiful apps.',
      phoneNumber: '555-123-4567',
      address: '123 Mock Street, Flutter City, FC 12345',
      preferences: {
        'theme': 'dark',
        'language': 'en',
        'notifications': true,
      },
    );

    return Right(mockProfile);
    // --- MOCK IMPLEMENTATION END ---

    /* // Original Implementation commented out
    const currentUserId = 'me';
    if (await networkInfo.isConnected) {
      try {
        final remoteProfile = await remoteDataSource.getById(currentUserId);
        await localDataSource.cacheProfile(remoteProfile);
        return Right(remoteProfile);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localProfile = await localDataSource.getCachedProfile();
        return Right(localProfile);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
    */
  }

  @override
  Future<Either<Failure, Profile>> updateProfile(Profile profile) async {
    print("Repository: Mock updateProfile called");
    await Future.delayed(const Duration(milliseconds: 300));
    // Simulate success by returning the updated profile
    return Right(profile);
  }

  @override
  Future<Either<Failure, String>> updateProfilePhoto(String filePath) async {
     print("Repository: Mock updateProfilePhoto called for path: $filePath");
     await Future.delayed(const Duration(milliseconds: 900));
     // Simulate success by returning a mock URL
     return const Right('https://picsum.photos/seed/newprofilepic/200');
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updatePreferences(Map<String, dynamic> preferences) async {
    print("Repository: Mock updatePreferences called");
    await Future.delayed(const Duration(milliseconds: 150));
    // Simulate success by returning the updated preferences
    return Right(preferences);
  }
}
