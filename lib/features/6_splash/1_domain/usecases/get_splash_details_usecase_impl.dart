import 'package:dartz/dartz.dart';

import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';
import '../entities/splash_details_data.dart';
import 'get_splash_details_usecase.dart';

/// Concrete implementation of [GetSplashDetailsUseCase].
///
/// In a real application, this would likely depend on a Repository
/// (e.g., `ISplashRepository`) injected via the constructor, which
/// would handle the actual data fetching from an API or local source.
class GetSplashDetailsUseCaseImpl implements GetSplashDetailsUseCase {
  // Example: Inject repository if needed
  // final ISplashRepository repository;
  // GetSplashDetailsUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, SplashDetailsData>> call(NoParams params) async {
    try {
      // Simulate network delay or data fetching process
      await Future.delayed(const Duration(seconds: 1));

      // Simulate successful data retrieval
      // In a real app: final result = await repository.getSplashDetails();
      // return result.fold((failure) => Left(failure), (data) => Right(data));
      const fakeData = SplashDetailsData(welcomeMessage: "Welcome! Details loaded successfully.");
      return const Right(fakeData);

      // Example: Simulate failure
      // return Left(ServerFailure('Could not connect to the details server.'));

    } catch (e) {
      // Catch unexpected errors during the process
      // Log the error: log.severe('Unexpected error in GetSplashDetailsUseCase: $e');
      return Left(CacheFailure(message: 'An unexpected error occurred while fetching details: $e'));
    }
  }
} 