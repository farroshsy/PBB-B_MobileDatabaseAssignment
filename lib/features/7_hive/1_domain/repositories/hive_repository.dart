// Mendefinisikan kontrak (interface) untuk operasi data terkait pengguna (atau data Hive secara umum).
abstract class HiveRepository {
  // Metode untuk mendapatkan data pengguna berdasarkan kunci.
  Future<List<dynamic>?> getUserData(String key);
  // Metode untuk menyimpan data pengguna.
  Future<void> saveUserData(String key, List<dynamic> data);
  // Metode untuk menghapus data pengguna berdasarkan kunci.
  Future<void> deleteUserData(String key);
}
