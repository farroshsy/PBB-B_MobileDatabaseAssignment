/// Environment configuration handler
///
/// Manages different environment configurations (development, staging, production)
/// and provides a unified way to access environment-specific variables.
enum Environment {
  development,
  staging,
  production,
}

class EnvConfig {
  final Environment environment;
  final Map<String, dynamic> _values;

  /// Creates a new environment configuration
  EnvConfig({
    required this.environment,
    required Map<String, dynamic> values,
  }) : _values = values;

  /// Gets a value from the environment configuration
  T getValue<T>(String key) {
    if (!_values.containsKey(key)) {
      throw Exception('Key $key not found in $environment configuration');
    }

    return _values[key] as T;
  }

  /// Development environment configuration
  static EnvConfig development() {
    return EnvConfig(
      environment: Environment.development,
      values: {
        'API_URL': 'https://dev-api.example.com',
        'LOGGING_ENABLED': true,
        'CACHE_TTL_MINUTES': 5,
      },
    );
  }

  /// Staging environment configuration
  static EnvConfig staging() {
    return EnvConfig(
      environment: Environment.staging,
      values: {
        'API_URL': 'https://staging-api.example.com',
        'LOGGING_ENABLED': true,
        'CACHE_TTL_MINUTES': 15,
      },
    );
  }

  /// Production environment configuration
  static EnvConfig production() {
    return EnvConfig(
      environment: Environment.production,
      values: {
        'API_URL': 'https://api.example.com',
        'LOGGING_ENABLED': false,
        'CACHE_TTL_MINUTES': 30,
      },
    );
  }
}
