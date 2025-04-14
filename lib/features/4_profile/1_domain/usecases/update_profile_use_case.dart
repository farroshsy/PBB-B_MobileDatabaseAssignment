import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

/// Update profile use case parameters
class UpdateProfileParams {
  /// Creates update profile parameters
  const UpdateProfileParams({required this.profile});
  
  /// Profile to update
  final Profile profile;
}

/// Update user profile use case
class UpdateProfileUseCase implements UseCase<Profile, UpdateProfileParams> {
  /// Creates an update profile use case
  const UpdateProfileUseCase(this._profileRepository);

  final ProfileRepository _profileRepository;

  @override
  Future<Either<Failure, Profile>> call(UpdateProfileParams params) {
    return _profileRepository.updateProfile(params.profile);
  }
}
