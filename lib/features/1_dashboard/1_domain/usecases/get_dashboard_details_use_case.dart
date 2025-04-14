import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';
import '../entities/dashboard.dart';
import '../repositories/dashboard_repository.dart';

/// Parameters for getting dashboard details
class GetDashboardDetailsParams {
  /// Creates parameters for get dashboard details use case
  const GetDashboardDetailsParams({required this.id});
  
  /// ID of the dashboard to get
  final String id;
}

/// Get detailed dashboard information
class GetDashboardDetailsUseCase implements UseCase<Dashboard, GetDashboardDetailsParams> {
  /// Creates a get dashboard details use case
  const GetDashboardDetailsUseCase(this._repository);

  final DashboardRepository _repository;

  @override
  Future<Either<Failure, Dashboard>> call(GetDashboardDetailsParams params) async {
    return _repository.getById(params.id);
  }
}
