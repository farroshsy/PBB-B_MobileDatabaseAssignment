// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import '../../1_domain/entities/home.dart';
// import '../../1_domain/repositories/home_repository.dart';
// import '../../1_domain/usecases/get_home_use_case.dart';
// import 'package:my_app/core/usecase/usecase.dart';
// // Mock repository
// class MockHomeRepository extends Mock implements HomeRepository {}

// void main() {
//   late GetHomeUseCase usecase;
//   late MockHomeRepository mockRepository;

//   setUp(() {
//     mockRepository = MockHomeRepository();
//     usecase = GetHomeUseCase(mockRepository);
//   });

//   const testHome = Home(
//     id: 'test-id',
//     name: 'Test Home',
//   );

//   test(
//     'should get home from the repository',
//     () async {
//       // arrange
//       when(mockRepository.getById(any))
//           .thenAnswer((_) async => const Right(testHome));
      
//       // act
//       final result = await usecase(NoParams());
      
//       // assert
//       expect(result, const Right(testHome));
//       verify(mockRepository.getById('default-id'));
//       verifyNoMoreInteractions(mockRepository);
//     },
//   );
// }
