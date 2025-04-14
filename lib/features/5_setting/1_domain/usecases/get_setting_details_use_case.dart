import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';import '../entities/setting.dart';
import '../repositories/setting_repository.dart';

/// Parameters for getting setting details
class GetSettingDetailsParams {
  /// Creates parameters for get setting details use case
  const GetSettingDetailsParams({required this.id});
  
  /// ID of the setting to get
  final String id;
}

/// Get detailed setting information
class GetSettingDetailsUseCase implements UseCase<Setting, GetSettingDetailsParams> {
  /// Creates a get setting details use case
  const GetSettingDetailsUseCase(this._repository);

  final SettingRepository _repository;

  @override
  Future<Either<Failure, Setting>> call(GetSettingDetailsParams params) async {
    return _repository.getById(params.id);
  }
}
