// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import '../../1_domain/entities/auth_credentials.dart';
// import '../../1_domain/entities/user.dart';
// import '../../1_domain/repositories/auth_repository.dart';
// import '../../1_domain/usecases/sign_in_use_case.dart';

// // Mock repository
// class MockAuthRepository extends Mock implements AuthRepository {}

// void main() {
//   late SignInUseCase usecase;
//   late MockAuthRepository mockAuthRepository;

//   setUp(() {
//     mockAuthRepository = MockAuthRepository();
//     usecase = SignInUseCase(mockAuthRepository);
//   });

//   const tCredentials = AuthCredentials(
//     email: 'test@example.com',
//     password: 'password123',
//   );

//   const tUser = User(
//     id: '1',
//     email: 'test@example.com',
//     name: 'Test User',
//   );

//   test(
//     'should sign in user with the provided credentials',
//     () async {
//       // arrange
//       when(mockAuthRepository.signInWithEmailAndPassword(tCredentials))
//           .thenAnswer((_) async => const Right(tUser));
      
//       // act
//       final result = await usecase(tCredentials);
      
//       // assert
//       expect(result, const Right(tUser));
//       verify(mockAuthRepository.signInWithEmailAndPassword(tCredentials));
//       verifyNoMoreInteractions(mockAuthRepository);
//     },
//   );
// }
