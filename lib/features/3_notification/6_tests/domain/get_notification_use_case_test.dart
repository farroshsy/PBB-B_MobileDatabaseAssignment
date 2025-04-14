// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import '../../1_domain/entities/notification.dart';
// import '../../1_domain/repositories/notification_repository.dart';
// import '../../1_domain/usecases/get_notification_use_case.dart';
// import 'package:my_app/core/usecase/usecase.dart';
// // Mock repository
// class MockNotificationRepository extends Mock implements NotificationRepository {}

// void main() {
//   late GetNotificationUseCase usecase;
//   late MockNotificationRepository mockRepository;

//   setUp(() {
//     mockRepository = MockNotificationRepository();
//     usecase = GetNotificationUseCase(mockRepository);
//   });

//   const testNotification = Notification(
//     id: 'test-id',
//     name: 'Test Notification',
//   );

//   test(
//     'should get notification from the repository',
//     () async {
//       // arrange
//       when(mockRepository.getById(any))
//           .thenAnswer((_) async => const Right(testNotification));
      
//       // act
//       final result = await usecase(NoParams());
      
//       // assert
//       expect(result, const Right(testNotification));
//       verify(mockRepository.getById('default-id'));
//       verifyNoMoreInteractions(mockRepository);
//     },
//   );
// }
