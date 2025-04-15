import 'package:hive_flutter/hive_flutter.dart';

import 'hive_datasource.dart';

// Implementasi konkret dari HiveDataSource.
class HiveDataSourceImpl implements HiveDataSource {
  // Mendapatkan instance box Hive yang sudah dibuka sebelumnya.
  final Box _myBox = Hive.box('mybox');

  @override
  // Mengambil data dari box Hive berdasarkan kunci.
  Future<List<dynamic>?> getData(String key) async {
    // Operasi get Hive sebenarnya sinkron, tapi signature Future dipertahankan.
    final data = _myBox.get(key); // Mengambil data dari box.
    // Memeriksa apakah data yang diambil adalah List.
    if (data is List) {
      // Memastikan tipe data adalah List<dynamic>.
      return List<dynamic>.from(data);
    }
    // Mengembalikan null jika data tidak ditemukan atau bukan List.
    return null; 
  }

  @override
  // Menyimpan data ke dalam box Hive.
  Future<void> saveData(String key, List<dynamic> data) async {
    // Menggunakan put untuk menyimpan atau memperbarui data.
    await _myBox.put(key, data);
  }

  @override
  // Menghapus data dari box Hive berdasarkan kunci.
  Future<void> deleteData(String key) async {
    // Menggunakan delete untuk menghapus data.
    await _myBox.delete(key);
  }
} 