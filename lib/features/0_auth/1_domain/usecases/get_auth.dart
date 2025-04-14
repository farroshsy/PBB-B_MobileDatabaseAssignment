import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Use case to get a specific user by ID
class GetAuth implements UseCase<User, GetAuthParams> {
  /// Repository for auth data
  final AuthRepository repository;

  /// Create a new [GetAuth] use case
  const GetAuth(this.repository);

  /// Execute the use case with the given parameters
  @override
  Future<Either<Failure, User>> call(GetAuthParams params) async {
    return repository.getAuth(params.id);
  }
}

/// Parameters for [GetAuth] use case
class GetAuthParams extends Equatable {
  /// ID of the auth to retrieve
  final String id;

  /// Create new parameters
  const GetAuthParams({required this.id});

  @override
  List<Object> get props => [id];
}
