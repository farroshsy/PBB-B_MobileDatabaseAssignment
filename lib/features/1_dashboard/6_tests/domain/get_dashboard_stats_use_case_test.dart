import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_app/core/usecase/usecase.dart';import '../../../1_dashboard/1_domain/entities/dashboard_stats.dart';
import '../../../1_dashboard/1_domain/repositories/dashboard_repository.dart';
import '../../../1_dashboard/1_domain/usecases/get_dashboard_stats_use_case.dart';

// Mock repository
class MockDashboardRepository extends Mock implements DashboardRepository {}

void main() {
  late GetDashboardStatsUseCase usecase;
  late MockDashboardRepository mockRepository;

  setUp(() {
    mockRepository = MockDashboardRepository();
    usecase = GetDashboardStatsUseCase(mockRepository);
  });

  const tDashboardStats = DashboardStats(
    totalUsers: 1200,
    activeUsers: 850,
    totalRevenue: 25000.50,
    period: 'monthly',
    growthRate: 5.7,
  );

  test(
    'should get dashboard stats from the repository',
    () async {
      // arrange
      when(mockRepository.getDashboardStats())
          .thenAnswer((_) async => const Right(tDashboardStats));
      
      // act
      final result = await usecase(NoParams());
      
      // assert
      expect(result, const Right(tDashboardStats));
      verify(mockRepository.getDashboardStats());
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
