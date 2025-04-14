import 'dart:convert';

import 'package:my_app/core/error/exceptions.dart';
import 'package:my_app/core/storage/storage_service.dart';
import 'package:my_app/core/services/logger_service.dart';
import '../models/home_model.dart'; // Assuming this exists
import '../models/home_data_model.dart'; // Assuming this exists

/// Abstract interface for Home feature local data source
abstract class HomeLocalDataSource {
  Future<void> cacheHomes(List<HomeModel> homes);
  Future<List<HomeModel>> getCachedHomes();
  Future<void> cacheHome(HomeModel home);
  Future<HomeModel> getCachedHomeById(String id);
  Future<void> cacheHomeData(HomeDataModel homeData);
  Future<HomeDataModel> getCachedHomeData();
  Future<void> markNotificationAsRead(String notificationId);
}

/// Implementation using StorageService
class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final StorageService storageService;
  final LoggerService logger;

  static const _homesKey = 'CACHED_HOMES';
  static const _homeDataKey = 'CACHED_HOME_DATA';

  HomeLocalDataSourceImpl({required this.storageService, required this.logger});

  @override
  Future<void> cacheHomes(List<HomeModel> homes) async {
    try {
      final jsonList = homes.map((model) => model.toJson()).toList();
      await storageService.saveValue(_homesKey, jsonEncode(jsonList));
    } catch (e) {
      throw CacheException(message: 'Failed to cache homes: ${e.toString()}');
    }
  }

  @override
  Future<List<HomeModel>> getCachedHomes() async {
    try {
      final jsonString = await storageService.getValue(_homesKey) as String?;
      if (jsonString == null) {
        throw CacheException(message: 'No cached homes found');
      }
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => HomeModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw CacheException(message: 'Failed to get cached homes: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheHome(HomeModel home) async {
    try {
      List<HomeModel> homes;
      try {
        homes = await getCachedHomes();
      } on CacheException {
        homes = [];
      }
      final index = homes.indexWhere((d) => d.id == home.id);
      if (index >= 0) {
        homes[index] = home;
      } else {
        homes.add(home);
      }
      await cacheHomes(homes);
    } catch (e) {
      throw CacheException(message: 'Failed to cache home: ${e.toString()}');
    }
  }

  @override
  Future<HomeModel> getCachedHomeById(String id) async {
    try {
      final homes = await getCachedHomes();
      return homes.firstWhere((d) => d.id == id, 
            orElse: () => throw CacheException(message: 'Home with ID $id not found in cache'));
    } catch (e) {
      // Rethrow specific cache exception or a general one
      if (e is CacheException) rethrow;
      throw CacheException(message: 'Failed to get cached home by ID: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheHomeData(HomeDataModel homeData) async {
    try {
      await storageService.saveValue(_homeDataKey, jsonEncode(homeData.toJson()));
    } catch (e) {
      throw CacheException(message: 'Failed to cache home data: ${e.toString()}');
    }
  }

  @override
  Future<HomeDataModel> getCachedHomeData() async {
    try {
      final jsonString = await storageService.getValue(_homeDataKey) as String?;
      if (jsonString == null) {
        throw CacheException(message: 'No cached home data found');
      }
      final Map<String, dynamic> json = jsonDecode(jsonString);
      return HomeDataModel.fromJson(json);
    } catch (e) {
      throw CacheException(message: 'Failed to get cached home data: ${e.toString()}');
    }
  }

  @override
  Future<void> markNotificationAsRead(String notificationId) async {
    // Implementation depends heavily on HomeDataModel structure
    try {
      // Remove unused variable
      // final currentData = await getCachedHomeData(); 

      // --- Placeholder Implementation --- 
      // Replace print with logger.debug
      logger.debug(
          'Local markNotificationAsRead (ID: $notificationId) - Placeholder: No local state updated.');

    } catch (e) {
      // Replace print with logger.error
      logger.error('Error in local markNotificationAsRead: ${e.toString()}');
      // Optionally rethrow or throw a specific CacheException
    }
  }
}

