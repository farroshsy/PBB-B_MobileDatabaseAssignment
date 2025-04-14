import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';import '../entities/home.dart';
import '../repositories/home_repository.dart';

/// Get home use case to retrieve home data
class GetHomeUseCase implements UseCase<Home, NoParams> {
  /// Creates a get home use case
  const GetHomeUseCase(this._repository);

  final HomeRepository _repository;

  @override
  Future<Either<Failure, Home>> call(NoParams params) async {
    // Implementation would call the repository
    return _repository.getById('default-id');
  }
}
