# Penjelasan Implementasi Hive dalam Aplikasi Flutter

**Disusun oleh:**
*   **Nama:** Farros Hilmi Syafei
*   **NRP:** 5025201012
*   **Kelas:** PBB B

---

## Pendahuluan

Presentasi ini menjelaskan implementasi *database* lokal sebagai bagian dari tugas mata kuliah Pemrograman Berbasis Platform (PBB) Kelas B. Berdasarkan NRP 5025201012, hasil `modulo 4` adalah `0`, sehingga *database* yang dipilih adalah **Hive**.

## Apa itu Hive?

*   **Definisi:** Hive adalah sebuah *database* NoSQL *key-value* yang *lightweight* (ringan), cepat, dan ditulis murni menggunakan bahasa Dart. Hive sangat cocok untuk penyimpanan data lokal pada aplikasi Flutter.
*   **Karakteristik Utama:**
    *   ***Key-Value Store:*** Data disimpan sebagai pasangan *key* (unik) dan *value*. *Value* bisa berupa tipe data primitif Dart (String, int, double, bool), List, Map, atau objek Dart *custom*.
    *   **Cepat:** Didesain untuk performa tinggi dalam operasi baca/tulis (*read/write*).
    *   ***Native Dart:*** Tidak memerlukan *binding* ke *library native* platform lain.
    *   **Fleksibel:** Tidak memerlukan skema yang kaku seperti *database* SQL.

## Konsep Inti Hive

*   ***Box:*** Unit penyimpanan utama di Hive, mirip tabel tapi lebih fleksibel.
    *   Setiap *box* disimpan dalam *file* terpisah.
    *   Bisa bersifat *lazy* (memuat *key* saja, *value* diambil saat perlu) atau dimuat sepenuhnya.
    *   Dalam proyek ini:
        *   `Hive.box('mybox')`: *Box* generik (Fitur 7_hive).
        *   `Hive.box<User>('users')`: *Box* dengan tipe `User` (Fitur 5_setting).
*   ***TypeAdapter:*** Jembatan antara objek Dart *custom* dengan format penyimpanan Hive.
    *   Dibutuhkan untuk menyimpan objek *custom* (seperti kelas `User`).
    *   Memberi tahu Hive cara melakukan *serialize* (objek ke biner) dan *deserialize* (biner ke objek).
    *   Dapat di-*generate* otomatis (`hive_generator` dan `build_runner`).

## Langkah Implementasi di Proyek

1.  **Dependensi:** Tambahkan *package* `hive`, `hive_flutter`, `path_provider`, `hive_generator`, `build_runner` ke `pubspec.yaml`.
2.  **Inisialisasi (`lib/main.dart`):**
    *   `WidgetsFlutterBinding.ensureInitialized();`
    *   Dapatkan *path* direktori: `getApplicationDocumentsDirectory()`.
    *   Inisialisasi Hive: `await Hive.initFlutter(appDocumentDir.path);`.
3.  **Definisi Model (Objek Custom):**
    *   Buat *class* Dart (`User` di `lib/features/common/data/models/user_model.dart`).
    *   Anotasi *class* dengan `@HiveType(typeId: ...)` (ID unik per model).
    *   Anotasi *field* dengan `@HiveField(index)` (indeks unik per *field*).
    *   Tambahkan `part 'nama_file.g.dart';`.
4.  ***Generate TypeAdapter*** **(Objek Custom):**
    *   Jalankan: `flutter pub run build_runner build --delete-conflicting-outputs`.
    *   Menghasilkan file `.g.dart` berisi `TypeAdapter`.
5.  **Registrasi** ***TypeAdapter*** **(Objek Custom):**
    *   Di `lib/main.dart`: `Hive.registerAdapter(UserAdapter());`.
6.  **Membuka** ***Box:***
    *   Sebelum digunakan, *box* harus dibuka (`openBox()`):
        *   *Box* generik: `await Hive.openBox('mybox');` (di `main.dart`).
        *   *Box* bertipe: `await Hive.openBox<User>('users');` (di `SettingsScreen`).
7.  **Operasi** ***CRUD:***
    *   ***Create/Update (Write):*** `put(key, value)`. Membuat data baru atau menimpa data lama.
        *   Contoh: `_myBox.put('user_5025201012', ['Farros', '5025201012', 'ITS']);`
        *   Contoh Model: `_userBox.put(user.id, user);`
    *   ***Read:*** `get(key)`. Mengambil *value* berdasarkan *key*.
        *   Contoh: `var data = _myBox.get('user_5025201012');`
    *   ***Delete:*** `delete(key)`. Menghapus *entry* berdasarkan *key*.
        *   Contoh: `_myBox.delete('user_5025201012');`

## Lokasi Penggunaan Hive dalam Proyek

*   **`lib/main.dart`:** Inisialisasi, registrasi `UserAdapter`, buka `mybox`.
*   **`lib/features/7_hive/presentation/screens/hive_example_screen.dart`:** Contoh *CRUD* sederhana pada `mybox`.
*   **`lib/features/common/data/models/user_model.dart`:** Definisi model `User` + anotasi Hive.
*   **`lib/features/common/data/models/user_model.g.dart`:** Hasil *generate* `TypeAdapter` untuk `User`.
*   **`lib/features/5_setting/5_presentation/screens/settings_screen.dart`:** Contoh *CRUD* menggunakan model `User` pada *box* `users`.

## Cara Kerja Internal Hive (Singkat)

*   **Penyimpanan File:** Setiap *box* disimpan sebagai *file* biner terpisah.
*   ***Serialization/Deserialization:*** `TypeAdapter` mengubah objek Dart ke/dari format biner untuk penyimpanan/pembacaan.
*   **Manajemen Memori:** *Box* biasa (`openBox()`) memuat semua isi ke memori. *Lazy box* (`openLazyBox()`) hanya memuat *key* untuk efisiensi memori (tidak digunakan di proyek ini).

## Kelebihan Hive

*   **Performa:** Sangat cepat.
*   **Kemudahan Penggunaan:** API sederhana.
*   ***Native Dart:*** Proses *build* lancar.
*   **Mendukung Tipe Data Dart:** Fleksibel.
*   **Tidak Perlu Skema:** Tidak kaku.
*   **Mendukung Enkripsi:** Ada opsi keamanan tambahan.

## Kesimpulan

Hive adalah solusi *database* lokal *key-value* yang efisien untuk Flutter. Implementasi dalam proyek ini mencakup *setup*, *CRUD* dasar dengan *box* generik, serta *CRUD* dengan objek *custom* menggunakan `TypeAdapter`.

--- 