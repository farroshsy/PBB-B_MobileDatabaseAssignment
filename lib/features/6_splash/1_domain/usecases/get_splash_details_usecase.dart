import 'package:dartz/dartz.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';
import '../entities/splash_details_data.dart';
// Repository import might be needed if the abstract class held a reference, but not needed for just defining the call signature
// import '../repositories/splash_repository.dart'; 

/// Abstract use case for getting splash details asynchronously.
abstract class GetSplashDetailsUseCase implements UseCase<SplashDetailsData, NoParams> {
  // The UseCase interface already defines the call method signature:
  // Future<Either<Failure, Type>> call(Params params);
  // So, we don't strictly need to redefine it here, but it can be good for clarity.
  @override
  Future<Either<Failure, SplashDetailsData>> call(NoParams params);
}

// Removed the previous synchronous class implementation
/*
/// Implementation of the GetSplashDetailsUseCase that synchronously returns splash details
class GetSplashDetailsUseCase {
  /// Creates a new GetSplashDetailsUseCase
  const GetSplashDetailsUseCase(this._repository);
  
  final SplashRepository _repository;
  
  /// Returns the splash details data
  /// This is a synchronous operation as the data is already loaded
  Map<String, dynamic> call(void _) {
    // In a real implementation, this would return structured data from the repository
    return {'welcomeMessage': 'Welcome to the app!'};
  }
}
*/