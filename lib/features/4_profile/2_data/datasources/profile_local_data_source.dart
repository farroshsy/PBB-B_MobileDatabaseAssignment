import 'dart:convert';

import 'package:my_app/core/error/exceptions.dart';
import 'package:my_app/core/storage/storage_service.dart';
import 'package:my_app/core/services/logger_service.dart';
import '../models/profile_model.dart'; // Assuming this exists

/// Abstract interface for Profile feature local data source
abstract class ProfileLocalDataSource {
  Future<void> cacheProfile(ProfileModel profile);
  Future<ProfileModel> getCachedProfile();
  Future<void> clearProfile();
}

/// Implementation using StorageService
class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final StorageService storageService;
  final LoggerService logger;

  static const _profileKey = 'CACHED_PROFILE';

  ProfileLocalDataSourceImpl({
    required this.storageService,
    required this.logger,
  });

  @override
  Future<void> cacheProfile(ProfileModel profile) async {
    try {
      await storageService.saveValue(_profileKey, jsonEncode(profile.toJson()));
    } catch (e) {
      throw CacheException(message: 'Failed to cache profile: ${e.toString()}');
    }
  }

  @override
  Future<ProfileModel> getCachedProfile() async {
    try {
      final jsonString = await storageService.getValue(_profileKey) as String?;
      if (jsonString == null) {
        throw CacheException(message: 'No cached profile found');
      }
      final Map<String, dynamic> json = jsonDecode(jsonString);
      return ProfileModel.fromJson(json);
    } catch (e) {
      throw CacheException(message: 'Failed to get cached profile: ${e.toString()}');
    }
  }

  @override
  Future<void> clearProfile() async {
     try {
      await storageService.removeValue(_profileKey);
    } catch (e) {
      logger.error('Failed to clear profile cache: $e');
      // Decide if CacheException should be thrown or if failure is acceptable
      // throw CacheException(message: 'Failed to clear profile cache: ${e.toString()}');
    }
  }
}
