// Kelas abstrak yang mendefinisikan kontrak untuk sumber data Hive.
abstract class HiveDataSource {
  // Metode untuk mengambil data dari Hive berdasarkan kunci.
  Future<List<dynamic>?> getData(String key);
  // Metode untuk menyimpan data ke Hive dengan kunci dan data tertentu.
  Future<void> saveData(String key, List<dynamic> data);
  // Metode untuk menghapus data dari Hive berdasarkan kunci.
  Future<void> deleteData(String key);
}