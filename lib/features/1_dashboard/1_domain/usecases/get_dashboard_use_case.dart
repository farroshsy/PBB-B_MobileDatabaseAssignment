import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';import '../entities/dashboard.dart';
import '../repositories/dashboard_repository.dart';

/// Get dashboard use case to retrieve dashboard data
class GetDashboardUseCase implements UseCase<Dashboard, NoParams> {
  /// Creates a get dashboard use case
  const GetDashboardUseCase(this._repository);

  final DashboardRepository _repository;

  @override
  Future<Either<Failure, Dashboard>> call(NoParams params) async {
    // Implementation would call the repository
    return _repository.getById('default-id');
  }
}
