import 'package:intl/intl.dart';

/// App date utils for handling date formatting and manipulation
class AppDateUtils {
  /// Format a DateTime to a string using the given pattern
  String formatDate(DateTime date, String pattern) {
    return DateFormat(pattern).format(date);
  }

  /// Format a DateTime to a string with the default date pattern
  String formatDefaultDate(DateTime date) {
    return formatDate(date, 'dd/MM/yyyy');
  }

  /// Format a DateTime to a string with the default time pattern
  String formatDefaultTime(DateTime date) {
    return formatDate(date, 'HH:mm');
  }

  /// Format a DateTime to a string with the default date and time pattern
  String formatDefaultDateTime(DateTime date) {
    return formatDate(date, 'dd/MM/yyyy HH:mm');
  }

  /// Parse a date string to a DateTime object
  DateTime? parseDate(String date, String pattern) {
    try {
      return DateFormat(pattern).parse(date);
    } catch (e) {
      return null;
    }
  }

  /// Parse a date string to a DateTime object with the default date pattern
  DateTime? parseDefaultDate(String date) {
    return parseDate(date, 'dd/MM/yyyy');
  }

  /// Get the difference in days between two dates
  int getDaysBetween(DateTime from, DateTime to) {
    final fromDate = DateTime(from.year, from.month, from.day);
    final toDate = DateTime(to.year, to.month, to.day);
    return toDate.difference(fromDate).inDays;
  }

  /// Get the age from a birthdate
  int getAge(DateTime birthDate) {
    final today = DateTime.now();
    var age = today.year - birthDate.year;
    final monthDiff = today.month - birthDate.month;

    if (monthDiff < 0 || (monthDiff == 0 && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  /// Get the start of the day for a given date
  DateTime getStartOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get the end of the day for a given date
  DateTime getEndOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Get the start of the week for a given date
  DateTime getStartOfWeek(DateTime date) {
    final daysToSubtract = date.weekday - 1;
    return getStartOfDay(date.subtract(Duration(days: daysToSubtract)));
  }

  /// Get the end of the week for a given date
  DateTime getEndOfWeek(DateTime date) {
    final daysToAdd = 7 - date.weekday;
    return getEndOfDay(date.add(Duration(days: daysToAdd)));
  }

  /// Check if a date is today
  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if a date is tomorrow
  bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  /// Check if a date is yesterday
  bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }
}
