import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Comprehensive interface for local storage operations
abstract class StorageService {
  // General storage operations (compatible with core/services/storage_service.dart)
  /// Saves a boolean value
  Future<bool> setBool(String key, bool value);
  
  /// Retrieves a boolean value
  Future<bool?> getBool(String key);
  
  /// Saves an integer value
  Future<bool> setInt(String key, int value);
  
  /// Retrieves an integer value
  Future<int?> getInt(String key);
  
  /// Saves a double value
  Future<bool> setDouble(String key, double value);
  
  /// Retrieves a double value
  Future<double?> getDouble(String key);
  
  /// Saves a string value
  Future<bool> setString(String key, String value);
  
  /// Retrieves a string value
  Future<String?> getString(String key);
  
  /// Saves a list of strings
  Future<bool> setStringList(String key, List<String> value);
  
  /// Retrieves a list of strings
  Future<List<String>?> getStringList(String key);
  
  /// Removes an entry
  Future<bool> remove(String key);
  
  /// Clears all entries
  Future<bool> clear();
  
  /// Checks if a key exists
  Future<bool> containsKey(String key);

  // Dynamic value storage operations (from original StorageService)
  /// Save value to storage (automatically detects type)
  Future<void> saveValue(String key, dynamic value);

  /// Get value from storage
  Future<dynamic> getValue(String key);

  /// Remove value from storage
  Future<void> removeValue(String key);

  /// Check if key exists in storage
  Future<bool> hasKey(String key);

  // Secure storage operations
  /// Save value to secure storage
  Future<void> saveSecureValue(String key, String value);

  /// Get value from secure storage
  Future<String?> getSecureValue(String key);

  /// Remove value from secure storage
  Future<void> removeSecureValue(String key);

  /// Check if key exists in secure storage
  Future<bool> hasSecureKey(String key);
}

/// Comprehensive implementation of StorageService 
/// Combines functionality from both storage service implementations
class StorageServiceImpl implements StorageService {
  /// Create StorageService instance
  StorageServiceImpl({
    required this.sharedPreferences,
    required this.secureStorage,
  });

  /// SharedPreferences instance
  final SharedPreferences sharedPreferences;

  /// Secure storage instance
  final FlutterSecureStorage secureStorage;

  // Type-specific methods (from SharedPreferencesStorageService)
  @override
  Future<bool> setBool(String key, bool value) async {
    return sharedPreferences.setBool(key, value);
  }

  @override
  Future<bool?> getBool(String key) async {
    return sharedPreferences.getBool(key);
  }

  @override
  Future<bool> setInt(String key, int value) async {
    return sharedPreferences.setInt(key, value);
  }

  @override
  Future<int?> getInt(String key) async {
    return sharedPreferences.getInt(key);
  }

  @override
  Future<bool> setDouble(String key, double value) async {
    return sharedPreferences.setDouble(key, value);
  }

  @override
  Future<double?> getDouble(String key) async {
    return sharedPreferences.getDouble(key);
  }

  @override
  Future<bool> setString(String key, String value) async {
    return sharedPreferences.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    return sharedPreferences.getString(key);
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    return sharedPreferences.setStringList(key, value);
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    return sharedPreferences.getStringList(key);
  }

  @override
  Future<bool> remove(String key) async {
    return sharedPreferences.remove(key);
  }

  @override
  Future<bool> clear() async {
    return sharedPreferences.clear();
  }

  @override
  Future<bool> containsKey(String key) async {
    return sharedPreferences.containsKey(key);
  }

  // Dynamic value methods (from original StorageServiceImpl)
  @override
  Future<void> saveValue(String key, dynamic value) async {
    if (value is String) {
      await sharedPreferences.setString(key, value);
    } else if (value is int) {
      await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      await sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      await sharedPreferences.setBool(key, value);
    } else if (value is List<String>) {
      await sharedPreferences.setStringList(key, value);
    } else {
      await sharedPreferences.setString(key, jsonEncode(value));
    }
  }

  @override
  Future<dynamic> getValue(String key) async {
    return sharedPreferences.get(key);
  }

  @override
  Future<void> removeValue(String key) async {
    await sharedPreferences.remove(key);
  }

  @override
  Future<bool> hasKey(String key) async {
    return sharedPreferences.containsKey(key);
  }

  // Secure storage methods
  @override
  Future<void> saveSecureValue(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> getSecureValue(String key) async {
    return await secureStorage.read(key: key);
  }

  @override
  Future<void> removeSecureValue(String key) async {
    await secureStorage.delete(key: key);
  }

  @override
  Future<bool> hasSecureKey(String key) async {
    final value = await secureStorage.read(key: key);
    return value != null;
  }
}
