import '../../1_domain/repositories/hive_repository.dart'; // Import interface repository
import '../datasources/hive_datasource.dart'; // Import interface data source

// Implementasi konkret dari HiveRepository.
class HiveRepositoryImpl implements HiveRepository {
  // Dependensi ke HiveDataSource.
  final HiveDataSource hiveDataSource;

  // Konstruktor untuk menginisialisasi repository dengan data source.
  HiveRepositoryImpl({required this.hiveDataSource});

  @override
  // Mendapatkan data pengguna dengan meneruskan panggilan ke data source.
  Future<List<dynamic>?> getUserData(String key) async {
    // Dalam kasus sederhana ini, kita hanya meneruskan panggilan.
    // Di skenario kompleks, di sinilah pemetaan model atau penanganan error bisa terjadi.
    return await hiveDataSource.getData(key);
  }

  @override
  // Menyimpan data pengguna dengan meneruskan panggilan ke data source.
  Future<void> saveUserData(String key, List<dynamic> data) async {
    await hiveDataSource.saveData(key, data);
  }

  @override
  // Menghapus data pengguna dengan meneruskan panggilan ke data source.
  Future<void> deleteUserData(String key) async {
    await hiveDataSource.deleteData(key);
  }
}
