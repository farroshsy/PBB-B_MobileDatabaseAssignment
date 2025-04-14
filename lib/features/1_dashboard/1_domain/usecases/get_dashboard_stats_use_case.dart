import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';
import '../entities/dashboard_stats.dart';
import '../repositories/dashboard_repository.dart';

/// Get dashboard statistics use case
class GetDashboardStatsUseCase implements UseCase<DashboardStats, NoParams> {
  /// Creates a get dashboard stats use case
  const GetDashboardStatsUseCase(this._dashboardRepository);

  final DashboardRepository _dashboardRepository;

  @override
  Future<Either<Failure, DashboardStats>> call(NoParams params) {
    return _dashboardRepository.getDashboardStats();
  }
}
