/// Validation utilities for the application
///
/// Provides methods for validating different types of data
class ValidationUtils {
  /// Validate if a string is not null and not empty
  bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Validate if a string is a valid email
  bool isValidEmail(String? value) {
    if (value == null || value.isEmpty) return false;

    // Regular expression pattern for validating an Email
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regExp = RegExp(pattern);

    return regExp.hasMatch(value);
  }

  /// Validate if a string is a valid password
  /// Password must be at least 8 characters long, contain at least one uppercase
  /// letter, one lowercase letter, one number and one special character
  bool isValidPassword(String? value) {
    if (value == null || value.isEmpty) return false;

    // Check minimum length
    if (value.length < 8) return false;

    // Check for uppercase letters
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(value);

    // Check for lowercase letters
    final hasLowercase = RegExp(r'[a-z]').hasMatch(value);

    // Check for numbers
    final hasNumber = RegExp(r'[0-9]').hasMatch(value);

    // Check for special characters
    final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);

    return hasUppercase && hasLowercase && hasNumber && hasSpecialChar;
  }

  /// Validate if a string is a valid phone number
  bool isValidPhoneNumber(String? value) {
    if (value == null || value.isEmpty) return false;

    // Basic regex for international phone number format
    const pattern = r'^\+?[0-9]{10,15}$';
    final regExp = RegExp(pattern);

    return regExp.hasMatch(value);
  }

  /// Validate if a string is a valid URL
  bool isValidUrl(String? value) {
    if (value == null || value.isEmpty) return false;

    // Regular expression for URL validation
    const pattern =
        r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$';
    final regExp = RegExp(pattern);

    return regExp.hasMatch(value);
  }

  /// Validate if a string is a valid credit card number
  bool isValidCreditCardNumber(String? value) {
    if (value == null || value.isEmpty) return false;

    // Remove any non-digit characters
    final cleanValue = value.replaceAll(RegExp(r'\D'), '');

    // Check if the length is valid
    if (cleanValue.length < 13 || cleanValue.length > 19) return false;

    // Luhn algorithm for credit card validation
    int sum = 0;
    bool alternate = false;

    for (int i = cleanValue.length - 1; i >= 0; i--) {
      int digit = int.parse(cleanValue[i]);

      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit = digit - 9;
        }
      }

      sum += digit;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }

  /// Validate if a string is a valid date in the format dd/MM/yyyy
  bool isValidDate(String? value) {
    if (value == null || value.isEmpty) return false;

    // Check format
    final regExp = RegExp(r'^(\d{2})/(\d{2})/(\d{4})$');
    final match = regExp.firstMatch(value);

    if (match == null) return false;

    final day = int.parse(match.group(1)!);
    final month = int.parse(match.group(2)!);
    final year = int.parse(match.group(3)!);

    // Check valid month
    if (month < 1 || month > 12) return false;

    // Check valid day based on month
    final daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    // Adjust February for leap years
    if (month == 2 && _isLeapYear(year)) {
      if (day < 1 || day > 29) return false;
    } else if (day < 1 || day > daysInMonth[month - 1]) {
      return false;
    }

    return true;
  }

  /// Check if a year is a leap year
  bool _isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  /// Validate if a value is a valid hex color code
  bool isValidHexColor(String? value) {
    if (value == null || value.isEmpty) return false;

    // Check if it starts with a hash
    if (!value.startsWith('#')) return false;

    // Check if it's a 3, 6, or 8 digit hex code
    final hexValue = value.substring(1);
    final validLengths = [3, 6, 8];

    if (!validLengths.contains(hexValue.length)) return false;

    // Check if all characters are valid hex digits
    final regExp = RegExp(r'^[0-9A-Fa-f]+$');

    return regExp.hasMatch(hexValue);
  }
}
