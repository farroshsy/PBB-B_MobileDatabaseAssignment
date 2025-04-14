// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import '../../1_domain/entities/dashboard.dart';
// import '../../1_domain/repositories/dashboard_repository.dart';
// import '../../1_domain/usecases/get_dashboard_use_case.dart';
// import 'package:my_app/core/usecase/usecase.dart';
// // Mock repository
// class MockDashboardRepository extends Mock implements DashboardRepository {}

// void main() {
//   late GetDashboardUseCase usecase;
//   late MockDashboardRepository mockRepository;

//   setUp(() {
//     mockRepository = MockDashboardRepository();
//     usecase = GetDashboardUseCase(mockRepository);
//   });

//   const testDashboard = Dashboard(
//     id: 'test-id',
//     name: 'Test Dashboard',
//   );

//   test(
//     'should get dashboard from the repository',
//     () async {
//       // arrange
//       when(mockRepository.getById(any))
//           .thenAnswer((_) async => const Right(testDashboard));
      
//       // act
//       final result = await usecase(NoParams());
      
//       // assert
//       expect(result, const Right(testDashboard));
//       verify(mockRepository.getById('default-id'));
//       verifyNoMoreInteractions(mockRepository);
//     },
//   );
// }
