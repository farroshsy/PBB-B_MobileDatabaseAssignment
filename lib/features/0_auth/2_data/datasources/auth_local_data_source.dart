import 'package:my_app/core/error/exceptions.dart';
import 'package:my_app/core/services/storage_service.dart'; // Updated import
import '../models/user_model.dart';

/// Authentication local data source interface
abstract class AuthLocalDataSource {
  /// Cache the user data
  ///
  /// Throws a [CacheException] if caching fails
  Future<void> cacheUser(UserModel user);

  /// Get the cached user data
  ///
  /// Throws a [CacheException] if no cached data is present
  Future<UserModel> getCachedUser();

  /// Clear the cached user data
  ///
  /// Throws a [CacheException] if clearing fails
  Future<void> clearUser();

  /// Check if a user is cached
  Future<bool> hasUser();
}

/// Implementation of [AuthLocalDataSource] using storage service
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  /// Creates an auth local data source
  AuthLocalDataSourceImpl({
    // Removed const
    required this.storageService,
  });

  /// The storage service
  final StorageService storageService;

  /// Key for storing the user in the storage service
  static const userKey = 'CACHED_USER';

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      await storageService.setString(userKey, user.toJson().toString());
    } catch (e) {
      throw CacheException(message: 'Failed to cache user');
    }
  }

  @override
  Future<UserModel> getCachedUser() async {
    try {
      final jsonString = await storageService.getString(userKey);
      if (jsonString == null) {
        throw CacheException(message: 'No cached user found');
      }

      final Map<String, dynamic> userData =
          Map<String, dynamic>.from(jsonString as Map<dynamic, dynamic>);

      return UserModel.fromJson(userData);
    } catch (e) {
      throw CacheException(
          message: 'Failed to get cached user: ${e.toString()}');
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      await storageService.remove(userKey);
    } catch (e) {
      throw CacheException(message: 'Failed to clear cached user');
    }
  }

  @override
  Future<bool> hasUser() async {
    try {
      final jsonString = await storageService.getString(userKey);
      return jsonString != null;
    } catch (e) {
      return false;
    }
  }
}
