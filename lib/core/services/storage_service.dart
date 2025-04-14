import '../storage/storage_service.dart';

// Re-export the consolidated storage service implementation
export '../storage/storage_service.dart';

/// This file is maintained for backward compatibility
/// All implementations are consolidated in core/storage/storage_service.dart

// This adapter class allows existing code to continue working with the old interface
/// Adapter that implements the legacy StorageService interface using the consolidated implementation
class SharedPreferencesStorageService implements StorageService {
  /// Creates a new adapter wrapping the consolidated storage service
  SharedPreferencesStorageService(this._storageService);
  
  final StorageService _storageService;
  
  @override
  Future<bool> setBool(String key, bool value) {
    return _storageService.setBool(key, value);
  }
  
  @override
  Future<bool?> getBool(String key) {
    return _storageService.getBool(key);
  }
  
  @override
  Future<bool> setInt(String key, int value) {
    return _storageService.setInt(key, value);
  }
  
  @override
  Future<int?> getInt(String key) {
    return _storageService.getInt(key);
  }
  
  @override
  Future<bool> setDouble(String key, double value) {
    return _storageService.setDouble(key, value);
  }
  
  @override
  Future<double?> getDouble(String key) {
    return _storageService.getDouble(key);
  }
  
  @override
  Future<bool> setString(String key, String value) {
    return _storageService.setString(key, value);
  }
  
  @override
  Future<String?> getString(String key) {
    return _storageService.getString(key);
  }
  
  @override
  Future<bool> setStringList(String key, List<String> value) {
    return _storageService.setStringList(key, value);
  }
  
  @override
  Future<List<String>?> getStringList(String key) {
    return _storageService.getStringList(key);
  }
  
  @override
  Future<bool> remove(String key) {
    return _storageService.remove(key);
  }
  
  @override
  Future<bool> clear() {
    return _storageService.clear();
  }
  
  @override
  Future<bool> containsKey(String key) {
    return _storageService.containsKey(key);
  }

  @override
  Future<dynamic> getValue(String key) {
    return _storageService.getValue(key);
  }

  @override
  Future<bool> hasKey(String key) {
    return _storageService.hasKey(key);
  }

  @override
  Future<void> removeValue(String key) {
    return _storageService.removeValue(key);
  }

  @override
  Future<void> saveValue(String key, dynamic value) {
    return _storageService.saveValue(key, value);
  }

  @override
  Future<String?> getSecureValue(String key) {
    return _storageService.getSecureValue(key);
  }

  @override
  Future<bool> hasSecureKey(String key) {
    return _storageService.hasSecureKey(key);
  }

  @override
  Future<void> removeSecureValue(String key) {
    return _storageService.removeSecureValue(key);
  }

  @override
  Future<void> saveSecureValue(String key, String value) {
    return _storageService.saveSecureValue(key, value);
  }
}
