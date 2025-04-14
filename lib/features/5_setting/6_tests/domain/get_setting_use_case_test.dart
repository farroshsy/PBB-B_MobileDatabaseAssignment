// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import '../../1_domain/entities/setting.dart';
// import '../../1_domain/repositories/setting_repository.dart';
// import '../../1_domain/usecases/get_setting_use_case.dart';
// import 'package:my_app/core/usecase/usecase.dart';
// // Mock repository
// class MockSettingRepository extends Mock implements SettingRepository {}

// void main() {
//   late GetSettingUseCase usecase;
//   late MockSettingRepository mockRepository;

//   setUp(() {
//     mockRepository = MockSettingRepository();
//     usecase = GetSettingUseCase(mockRepository);
//   });

//   const testSetting = Setting(
//     id: 'test-id',
//     name: 'Test Setting',
//   );

//   test(
//     'should get setting from the repository',
//     () async {
//       // arrange
//       when(mockRepository.getById(any))
//           .thenAnswer((_) async => const Right(testSetting));
      
//       // act
//       final result = await usecase(NoParams());
      
//       // assert
//       expect(result, const Right(testSetting));
//       verify(mockRepository.getById('default-id'));
//       verifyNoMoreInteractions(mockRepository);
//     },
//   );
// }
