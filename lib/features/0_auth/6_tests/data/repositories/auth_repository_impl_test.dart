// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:my_app/core/error/failures.dart';
// import 'package:my_app/core/network/network_info.dart';
// import 'package:my_app/core/network/dio_client.dart';
// import 'package:my_app/core/storage/storage_service.dart';
// import '../../../1_domain/entities/auth_credentials.dart';
// import '../../../2_data/models/user_model.dart';
// import '../../../2_data/repositories/auth_repository_impl.dart';

// // Mocks
// class MockDioClient extends Mock implements DioClient {}
// class MockStorageService extends Mock implements StorageService {}
// class MockNetworkInfo extends Mock implements NetworkInfo {}

// void main() {
//   late AuthRepositoryImpl repository;
//   late MockDioClient mockRemote;
//   late MockStorageService mockLocalStorage;
//   late MockNetworkInfo mockNetworkInfo;

//   setUp(() {
//     mockRemote = MockDioClient();
//     mockLocalStorage = MockStorageService();
//     mockNetworkInfo = MockNetworkInfo();
//     repository = AuthRepositoryImpl(
//       remote: mockRemote,
//       localStorage: mockLocalStorage,
//       networkInfo: mockNetworkInfo,
//     );
//   });

//   // Test data
//   const tCredentials = AuthCredentials(
//     email: 'test@example.com',
//     password: 'password123',
//   );

//   const tUserModel = UserModel(
//     id: '1',
//     email: 'test@example.com',
//     displayName: 'Test User',
//   );

//   group('signIn', () {
//     test(
//       'should return remote data when the call to remote data source is successful',
//       () async {
//         // arrange
//         when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
//         // Mock remote API call
        
//         // act
//         final result = await repository.signIn(tCredentials);
        
//         // assert
//         expect(result.isRight(), true);
//       },
//     );

//     test(
//       'should return server failure when the call to remote data source is unsuccessful',
//       () async {
//         // arrange
//         when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
//         // Mock failure
        
//         // act
//         // This test would be implemented when the mock implementation is ready
        
//         // assert
//         // Will assert the expected behavior
//       },
//     );

//     test(
//       'should return network failure when the device is offline',
//       () async {
//         // arrange
//         when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        
//         // act
//         final result = await repository.signIn(tCredentials);
        
//         // assert
//         expect(result, equals(const Left(NetworkFailure(message: 'No internet connection'))));
//       },
//     );
//   });
// }
