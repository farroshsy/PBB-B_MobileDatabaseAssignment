/// String constants used throughout the application
///
/// Centralizes all string literals to make maintenance, translation,
/// and updates easier. All user-facing strings should be defined here
/// and referenced elsewhere in the app.
class AppStrings {
  // General
  static const String appName = 'My Flutter App';
  static const String ok = 'OK';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  
  // Authentication
  static const String login = 'Login';
  static const String logout = 'Logout';
  static const String register = 'Register';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String forgotPassword = 'Forgot Password?';
  static const String resetPassword = 'Reset Password';
  
  // Error Messages
  static const String genericError = 'Something went wrong. Please try again.';
  static const String networkError = 'Network connection error. Please check your internet connection.';
  static const String authenticationError = 'Authentication failed. Please check your credentials.';
  static const String validationError = 'Please check the input fields for errors.';
  static const String serverError = 'Server error. Please try again later.';
  
  // Success Messages
  static const String loginSuccess = 'Successfully logged in.';
  static const String logoutSuccess = 'Successfully logged out.';
  static const String saveSuccess = 'Successfully saved.';
  static const String updateSuccess = 'Successfully updated.';
  static const String deleteSuccess = 'Successfully deleted.';
  
  // Do not allow instantiation
  const AppStrings._();
}
