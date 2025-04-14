import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

/// Get user profile use case
class GetProfileUseCase implements UseCase<Profile, NoParams> {
  /// Creates a get profile use case
  const GetProfileUseCase(this._profileRepository);

  final ProfileRepository _profileRepository;

  @override
  Future<Either<Failure, Profile>> call(NoParams params) {
    return _profileRepository.getProfile();
  }
}
