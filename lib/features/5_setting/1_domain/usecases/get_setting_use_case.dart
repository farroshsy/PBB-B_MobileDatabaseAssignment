import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';import '../entities/setting.dart';
import '../repositories/setting_repository.dart';

/// Get setting use case to retrieve setting data
class GetSettingUseCase implements UseCase<Setting, NoParams> {
  /// Creates a get setting use case
  const GetSettingUseCase(this._repository);

  final SettingRepository _repository;

  @override
  Future<Either<Failure, Setting>> call(NoParams params) async {
    // Implementation would call the repository
    return _repository.getById('default-id');
  }
}
