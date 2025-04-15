import 'package:flutter/material.dart'; // Import Flutter Material library
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod untuk state management
import 'package:my_app/features/7_hive/4_providers/hive_screen_notifier.dart'; // Import provider notifier layar Hive

// Mengubah StatelessWidget/StatefulWidget menjadi ConsumerWidget untuk menggunakan Riverpod.
class HiveExampleScreen extends ConsumerWidget { 
  // Konstruktor default untuk widget.
  const HiveExampleScreen({super.key});

  // Kunci statis yang digunakan untuk data dalam Hive.
  // Bisa juga didapatkan dari parameter atau sumber lain.
  static const String _userKey = 'user_5025201012'; 

  @override
  // Metode build, menerima BuildContext dan WidgetRef (dari Riverpod).
  Widget build(BuildContext context, WidgetRef ref) { 
    // Menggunakan ref.watch untuk memantau state dari hiveScreenNotifierProvider.
    // Widget akan rebuild ketika state ini berubah.
    final dataState = ref.watch(hiveScreenNotifierProvider); 
    // Menggunakan ref.read untuk mendapatkan instance notifier.
    // Digunakan untuk memanggil metode pada notifier (misal: saat tombol ditekan).
    final notifier = ref.read(hiveScreenNotifierProvider.notifier); 

    // Membangun Scaffold sebagai struktur dasar layar.
    return Scaffold(
      appBar: AppBar(
        // Judul AppBar.
        title: const Text('Hive CRUD (Riverpod)'), // Judul diperbarui
      ),
      // Isi utama layar.
      body: Center(
        // Menggunakan Column untuk menata widget secara vertikal.
        child: Column( 
          // Menengahkan children di dalam Column.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Widget untuk menampilkan state data saat ini.
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                // Menampilkan pesan berdasarkan apakah dataState null atau tidak.
                dataState == null 
                  ? 'Tidak ada data di Hive untuk kunci: $_userKey' 
                  : 'Data: ${dataState.toString()}',
                // Meratakan teks ke tengah.
                textAlign: TextAlign.center,
              ),
            ),
            // Memberi jarak vertikal.
            const SizedBox(height: 20),
            // Baris yang berisi tombol-tombol aksi.
            Row(
              // Menata tombol agar tersebar merata.
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Tombol untuk menulis data.
                ElevatedButton(
                  // Aksi yang dijalankan saat tombol ditekan.
                  onPressed: () {
                    // Data yang akan ditulis ke Hive.
                    final dataToWrite = ['Farros', '5025201012', 'ITS']; 
                    // Memanggil metode writeData pada notifier.
                    notifier.writeData(_userKey, dataToWrite);
                    // Menampilkan SnackBar sebagai feedback.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Mencoba menulis data untuk kunci $_userKey')),
                    );
                  },
                  // Teks pada tombol.
                  child: const Text('Write'),
                ),
                // Tombol untuk membaca data.
                ElevatedButton(
                  // Aksi saat tombol ditekan.
                  onPressed: () {
                    // Memanggil metode readData pada notifier.
                    notifier.readData(_userKey);
                    // Menampilkan SnackBar.
                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Mencoba membaca data untuk kunci $_userKey')),
                    );
                  },
                  // Teks pada tombol.
                  child: const Text('Read'),
                ),
                // Tombol untuk menghapus data.
                ElevatedButton(
                  // Aksi saat tombol ditekan.
                  onPressed: () {
                    // Memanggil metode deleteData pada notifier.
                    notifier.deleteData(_userKey);
                    // Menampilkan SnackBar.
                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Mencoba menghapus data untuk kunci $_userKey')),
                    );
                  },
                  // Teks pada tombol.
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 