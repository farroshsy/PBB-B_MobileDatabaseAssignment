// import 'package:flutter_test/flutter_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:mockito/mockito.dart';
// import 'package:my_app/core/error/failures.dart';
// import 'package:my_app/core/usecase/usecase.dart';
// import '../../../1_domain/entities/auth_credentials.dart';
// import '../../../1_domain/entities/user.dart';
// import '../../../1_domain/usecases/get_current_user_use_case.dart';
// import '../../../1_domain/usecases/sign_in_use_case.dart';
// import '../../../1_domain/usecases/sign_out_use_case.dart';
// import '../../../1_domain/usecases/sign_up_use_case.dart';
// import '../../../5_presentation/viewmodels/auth_view_model.dart';

// // Mocks
// class MockSignInUseCase extends Mock implements SignInUseCase {}
// class MockSignUpUseCase extends Mock implements SignUpUseCase {}
// class MockSignOutUseCase extends Mock implements SignOutUseCase {}
// class MockGetCurrentUserUseCase extends Mock implements GetCurrentUserUseCase {}

// void main() {
//   late AuthViewModel viewModel;
//   late MockSignInUseCase mockSignInUseCase;
//   late MockSignUpUseCase mockSignUpUseCase;
//   late MockSignOutUseCase mockSignOutUseCase;
//   late MockGetCurrentUserUseCase mockGetCurrentUserUseCase;

//   setUp(() {
//     mockSignInUseCase = MockSignInUseCase();
//     mockSignUpUseCase = MockSignUpUseCase();
//     mockSignOutUseCase = MockSignOutUseCase();
//     mockGetCurrentUserUseCase = MockGetCurrentUserUseCase();
    
//     viewModel = AuthViewModel(
//       signInUseCase: mockSignInUseCase,
//       signUpUseCase: mockSignUpUseCase,
//       signOutUseCase: mockSignOutUseCase,
//       getCurrentUserUseCase: mockGetCurrentUserUseCase,
//     );
//   });

//   const tEmail = 'test@example.com';
//   const tPassword = 'password123';
//   const tCredentials = AuthCredentials(
//     email: tEmail,
//     password: tPassword,
//   );
  
//   const tUser = User(
//     id: '1',
//     email: tEmail,
//     name: 'Test User',
//   );

//   test('initial state should be correct', () {
//     expect(viewModel.user, isNull);
//     expect(viewModel.isLoading, isFalse);
//     expect(viewModel.errorMessage, isNull);
//     expect(viewModel.isAuthenticated, isFalse);
//   });

//   group('signIn', () {
//     test(
//       'should update state correctly when sign in is successful',
//       () async {
//         // arrange
//         when(mockSignInUseCase.call(tCredentials))
//             .thenAnswer((_) async => const Right(tUser));
        
//         // act
//         final result = await viewModel.signIn(tEmail, tPassword);
        
//         // assert
//         expect(result, true);
//         expect(viewModel.user, equals(tUser));
//         expect(viewModel.isLoading, isFalse);
//         expect(viewModel.errorMessage, isNull);
//         expect(viewModel.isAuthenticated, isTrue);
//         verify(mockSignInUseCase.call(tCredentials));
//       },
//     );

//     test(
//       'should update state correctly when sign in fails',
//       () async {
//         // arrange
//         const failure = ServerFailure(message: 'Invalid credentials');
//         when(mockSignInUseCase.call(tCredentials))
//             .thenAnswer((_) async => const Left(failure));
        
//         // act
//         final result = await viewModel.signIn(tEmail, tPassword);
        
//         // assert
//         expect(result, false);
//         expect(viewModel.user, isNull);
//         expect(viewModel.isLoading, isFalse);
//         expect(viewModel.errorMessage, equals(failure.message));
//         expect(viewModel.isAuthenticated, isFalse);
//         verify(mockSignInUseCase.call(tCredentials));
//       },
//     );
//   });

//   group('signOut', () {
//     test(
//       'should update state correctly when sign out is successful',
//       () async {
//         // Set initial authenticated state
//         when(mockGetCurrentUserUseCase.call(NoParams()))
//             .thenAnswer((_) async => const Right(tUser));
//         await viewModel.getCurrentUser();
//         expect(viewModel.isAuthenticated, isTrue);
        
//         // arrange for sign out
//         when(mockSignOutUseCase.call(NoParams()))
//             .thenAnswer((_) async => const Right(unit));
        
//         // act
//         final result = await viewModel.signOut();
        
//         // assert
//         expect(result, true);
//         expect(viewModel.user, isNull);
//         expect(viewModel.isLoading, isFalse);
//         expect(viewModel.errorMessage, isNull);
//         expect(viewModel.isAuthenticated, isFalse);
//         verify(mockSignOutUseCase.call(NoParams()));
//       },
//     );
//   });
// }
