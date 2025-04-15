import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/features/7_hive/1_domain/repositories/hive_repository.dart';
import 'package:my_app/features/7_hive/2_data/datasources/hive_datasource.dart';
import 'package:my_app/features/7_hive/2_data/datasources/hive_datasource_impl.dart';
import 'package:my_app/features/7_hive/2_data/repositories/hive_repository_impl.dart';

// Provider Riverpod untuk menyediakan instance HiveDataSource.
final hiveDataSourceProvider = Provider<HiveDataSource>((ref) {
  // Membuat dan mengembalikan instance dari HiveDataSourceImpl.
  // Tidak ada dependensi yang diperlukan untuk implementasi dasar ini.
  return HiveDataSourceImpl();
});

// Provider Riverpod untuk menyediakan instance HiveRepository.
final hiveRepositoryProvider = Provider<HiveRepository>((ref) {
  // Provider ini bergantung pada hiveDataSourceProvider.
  // Menggunakan ref.watch untuk mendapatkan instance HiveDataSource.
  final dataSource = ref.watch(hiveDataSourceProvider);
  // Membuat dan mengembalikan instance HiveRepositoryImpl, menyuntikkan dataSource.
  return HiveRepositoryImpl(hiveDataSource: dataSource);
}); 