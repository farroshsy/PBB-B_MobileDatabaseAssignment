import 'package:logger/logger.dart';

/// Simple logger service interface for the application
abstract class LoggerService {
  /// Logs an info message
  void info(String message);

  /// Logs an error message
  void error(String message, [Object? error, StackTrace? stackTrace]);

  /// Logs a debug message
  void debug(String message);

  /// Logs a warning message
  void warning(String message);
}

/// Default implementation of LoggerService using the logger package
class LoggerServiceImpl implements LoggerService {
  /// Creates a logger service implementation
  LoggerServiceImpl()
      : _logger = Logger(
          printer: PrettyPrinter(
            methodCount: 0,
            errorMethodCount: 8,
            lineLength: 120,
            colors: true,
            printEmojis: true,
            dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
          ),
        );

  final Logger _logger;

  @override
  void info(String message) {
    _logger.i(message);
  }

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  @override
  void debug(String message) {
    _logger.d(message);
  }

  @override
  void warning(String message) {
    _logger.w(message);
  }
}
