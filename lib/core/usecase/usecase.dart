import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Base abstract usecase class
///
/// Generic parameters:
/// * [Type] - the return type of the use case
/// * [Params] - the parameter type of the use case
abstract class UseCase<Type, Params> {
  /// Call method to be called when invoking the use case
  Future<Either<Failure, Type>> call(Params params);
}

/// Base abstract synchronous usecase class
///
/// Generic parameters:
/// * [Type] - the return type of the use case
/// * [Params] - the parameter type of the use case
abstract class SyncUseCase<Type, Params> {
  /// Call method to be called when invoking the use case
  Type call(Params params);
}

/// No parameters class for use cases that don't require parameters
class NoParams {
  /// Creates NoParams
  const NoParams();
}