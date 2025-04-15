import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/features/7_hive/1_domain/repositories/hive_repository.dart';
import 'hive_providers.dart'; // Import the repository provider

// Mendefinisikan StateNotifier untuk layar Hive.
// StateNotifier ini mengelola state berupa List<dynamic>? (data yang dibaca).
class HiveScreenNotifier extends StateNotifier<List<dynamic>?> {
  // Dependensi ke HiveRepository.
  final HiveRepository _hiveRepository;
  
  // Konstruktor: menginisialisasi state awal menjadi null (belum ada data).
  // Menerima instance repository saat pembuatan.
  HiveScreenNotifier(this._hiveRepository) : super(null);

  // Metode untuk membaca data dari repository.
  Future<void> readData(String key) async {
    // Di aplikasi nyata, tambahkan penanganan state loading/error di sini.
    try {
      // Memanggil metode getUserData dari repository.
      final data = await _hiveRepository.getUserData(key);
      // Memperbarui state notifier dengan data yang didapat (atau null).
      state = data; 
    } catch (e) {
      // Tangani error, mungkin dengan mengatur state error.
      print("Error membaca data: $e");
      // Secara opsional, bersihkan state jika terjadi error.
      state = null; 
    }
  }

  // Metode untuk menulis data melalui repository.
  Future<void> writeData(String key, List<dynamic> data) async {
    try {
      // Memanggil metode saveUserData dari repository.
      await _hiveRepository.saveUserData(key, data);
      // Secara opsional, baca ulang data setelah menulis untuk memperbarui UI.
      await readData(key);
    } catch (e) {
      print("Error menulis data: $e");
      // Tangani error.
    }
  }

  // Metode untuk menghapus data melalui repository.
  Future<void> deleteData(String key) async {
    try {
      // Memanggil metode deleteUserData dari repository.
      await _hiveRepository.deleteUserData(key);
      // Bersihkan state setelah data dihapus.
      state = null; 
    } catch (e) {
      print("Error menghapus data: $e");
      // Tangani error.
    }
  }
}

// Mendefinisikan StateNotifierProvider untuk HiveScreenNotifier.
final hiveScreenNotifierProvider =
    StateNotifierProvider<HiveScreenNotifier, List<dynamic>?>((ref) {
  // Mendapatkan instance repository dari provider-nya (hiveRepositoryProvider).
  final repository = ref.watch(hiveRepositoryProvider);
  // Membuat dan mengembalikan instance Notifier, menyuntikkan repository.
  return HiveScreenNotifier(repository);
}); 