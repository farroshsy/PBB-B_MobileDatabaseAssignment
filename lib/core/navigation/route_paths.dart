/// Route path constants for the application
/// 
/// This class provides centralized access to route paths and names
/// to ensure consistent navigation throughout the app.
class RoutePaths {
  // Private constructor to prevent instantiation
  RoutePaths._();
  
  // Splash route
  static const String splash = '/splash';
  static const String splashName = 'splash';
  
  // Auth routes
  static const String login = '/login';
  static const String loginName = 'login';
  static const String register = '/register';
  static const String registerName = 'register';
  
  // Main app routes
  static const String home = '/home';
  static const String homeName = 'home';
  static const String profile = '/profile';
  static const String profileName = 'profile';
  static const String settings = '/settings';
  static const String settingsName = 'settings';
  
  // Dynamic routes
  static String homeDetails(String id) => '$home/details/$id';
  static String profileEdit() => '$profile/edit';
}
