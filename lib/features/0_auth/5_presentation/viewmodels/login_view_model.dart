import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:my_app/core/error/failures.dart';
import '../../1_domain/entities/user.dart';
import '../../1_domain/usecases/login_use_case.dart';

/// View model for login screen
class LoginViewModel {
  /// Creates a login view model
  LoginViewModel({LoginUseCase? loginUseCase})
      : _loginUseCase = loginUseCase ?? GetIt.instance<LoginUseCase>();

  final LoginUseCase _loginUseCase;

  /// Attempt to log in with email and password
  ///
  /// Returns a [User] on success or a [Failure] on error
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    // Input validation could also happen here
    return _loginUseCase(LoginParams(
      email: email,
      password: password,
    ));
  }
}
