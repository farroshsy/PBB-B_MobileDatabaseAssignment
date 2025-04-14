import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';import '../entities/home_data.dart';
import '../repositories/home_repository.dart';

/// Get home screen data use case
class GetHomeDataUseCase implements UseCase<HomeData, NoParams> {
  /// Creates a get home data use case
  const GetHomeDataUseCase(this._homeRepository);

  final HomeRepository _homeRepository;

  @override
  Future<Either<Failure, HomeData>> call(NoParams params) {
    return _homeRepository.getHomeData();
  }
}
