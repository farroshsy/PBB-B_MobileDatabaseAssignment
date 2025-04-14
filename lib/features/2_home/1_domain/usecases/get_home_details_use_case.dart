import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';import '../entities/home.dart';
import '../repositories/home_repository.dart';

/// Parameters for getting home details
class GetHomeDetailsParams {
  /// Creates parameters for get home details use case
  const GetHomeDetailsParams({required this.id});
  
  /// ID of the home to get
  final String id;
}

/// Get detailed home information
class GetHomeDetailsUseCase implements UseCase<Home, GetHomeDetailsParams> {
  /// Creates a get home details use case
  const GetHomeDetailsUseCase(this._repository);

  final HomeRepository _repository;

  @override
  Future<Either<Failure, Home>> call(GetHomeDetailsParams params) async {
    return _repository.getById(params.id);
  }
}
