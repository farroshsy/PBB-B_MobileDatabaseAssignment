// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import '../../1_domain/entities/profile.dart';
// import '../../1_domain/repositories/profile_repository.dart';
// import '../../1_domain/usecases/get_profile_use_case.dart';
// import 'package:my_app/core/usecase/usecase.dart';
// // Mock repository
// class MockProfileRepository extends Mock implements ProfileRepository {}

// void main() {
//   late GetProfileUseCase usecase;
//   late MockProfileRepository mockRepository;

//   setUp(() {
//     mockRepository = MockProfileRepository();
//     usecase = GetProfileUseCase(mockRepository);
//   });

//   const testProfile = Profile(
//     id: 'test-id',
//     name: 'Test Profile', email: '',
//   );

//   test(
//     'should get profile from the repository',
//     () async {
//       // arrange
//       when(mockRepository.getById(any))
//           .thenAnswer((_) async => const Right(testProfile));
      
//       // act
//       final result = await usecase(NoParams());
      
//       // assert
//       expect(result, const Right(testProfile));
//       verify(mockRepository.getById('default-id'));
//       verifyNoMoreInteractions(mockRepository);
//     },
//   );
// }
