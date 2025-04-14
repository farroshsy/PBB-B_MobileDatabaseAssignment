// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// import '../../1_domain/entities/user.dart';
// import '../../1_domain/repositories/auth_repository.dart';
// import '../../1_domain/usecases/get_auth.dart';

// // Create a mock class for the AuthRepository
// class MockAuthRepository extends Mock implements AuthRepository {}

// void main() {
//   late GetAuth usecase;
//   late MockAuthRepository mockRepository;

//   // Setup that runs before each test
//   setUp(() {
//     mockRepository = MockAuthRepository();
//     usecase = GetAuth(mockRepository);
//   });

//   // Test data
//   final tUserId = 'test_id';
//   final tUser = User(
//     id: tUserId,
//     email: 'test@example.com',
//     displayName: 'Test User',
//   );

//   test(
//     'should get user entity from the repository',
//     () async {
//       // arrange
//       when(mockRepository.getAuth(any))
//           .thenAnswer((_) async => Right(tUser));

//       // act
//       final result = await usecase(GetAuthParams(id: tUserId));

//       // assert
//       expect(result, equals(Right(tUser)));
//       // Verify that the method was called with correct parameters
//       verify(mockRepository.getAuth(tUserId));
//       verifyNoMoreInteractions(mockRepository);
//     },
//   );
// }
