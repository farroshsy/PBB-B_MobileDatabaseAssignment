/// String utility functions for the application
///
/// Provides helper methods for string manipulation, validation, and formatting.
class StringUtils {
  /// Capitalize the first letter of a string
  String capitalize(String str) {
    if (str.isEmpty) return str;
    return str[0].toUpperCase() + str.substring(1);
  }

  /// Capitalize the first letter of each word in a string
  String capitalizeEachWord(String str) {
    if (str.isEmpty) return str;
    return str.split(' ').map((word) => capitalize(word)).join(' ');
  }

  /// Truncate a string to the specified length with ellipsis
  String truncate(String str, int maxLength) {
    if (str.length <= maxLength) return str;
    return '${str.substring(0, maxLength)}...';
  }

  /// Convert a string to camelCase
  String toCamelCase(String str) {
    if (str.isEmpty) return str;

    final words = str.split(RegExp(r'[_\-\s]+'));
    final camelCased = words.map((word) => capitalize(word)).join('');
    return camelCased[0].toLowerCase() + camelCased.substring(1);
  }

  /// Convert a string to snake_case
  String toSnakeCase(String str) {
    if (str.isEmpty) return str;

    return str
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)}')
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9_]'), '')
        .replaceAll(RegExp(r'__+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
  }

  /// Convert a string to kebab-case
  String toKebabCase(String str) {
    if (str.isEmpty) return str;

    return str
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '-${match.group(0)}')
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9-]'), '')
        .replaceAll(RegExp(r'--+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
  }

  /// Remove all special characters from a string
  String removeSpecialCharacters(String str) {
    return str.replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');
  }

  /// Extract all numbers from a string
  String extractNumbers(String str) {
    final regex = RegExp(r'\d+');
    final matches = regex.allMatches(str);
    return matches.map((match) => match.group(0)).join();
  }

  /// Check if a string is a valid email
  bool isValidEmail(String str) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(str);
  }

  /// Check if a string is a valid URL
  bool isValidUrl(String str) {
    return RegExp(
            r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$')
        .hasMatch(str);
  }

  /// Generate a random string of the specified length
  String randomString(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    final result = StringBuffer();

    for (var i = 0; i < length; i++) {
      final index = (random + i) % chars.length;
      result.write(chars[index]);
    }

    return result.toString();
  }
}
