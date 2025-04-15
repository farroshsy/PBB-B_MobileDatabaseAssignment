import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/app.dart';
import 'package:my_app/core/config/app_config.dart';
import 'package:my_app/core/di/injection_container.dart' as di;
import 'package:my_app/features/0_auth/4_providers/auth_state_notifier.dart';
import 'package:path_provider/path_provider.dart';
import 'package:my_app/features/common/data/models/user_model.dart';
import 'package:my_app/features/230325_assignment/presentation/screens/assignment_screen.dart';

Future<void> main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  // Register Adapters
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(AssignmentItemAdapter());

  // Open the generic box used in the example
  await Hive.openBox('mybox');
  await Hive.openBox<AssignmentItem>('assignmentBox');

  // Initialize dependency injection
  await di.init(); 
  
  // Initialize auth state by checking current user
  await di.sl<AuthStateNotifier>().initialize();

  // Initialize AppConfig (using instance from DI)
  // Pass environment variables and potentially other config values
  final appConfig = di.sl<AppConfig>();
  appConfig.init(
    environment: const String.fromEnvironment('ENV', defaultValue: 'development'),
    devMode: const bool.fromEnvironment('DEV_MODE', defaultValue: true), // Default to true for dev
    widgetbookMode: const bool.fromEnvironment('WIDGETBOOK_MODE', defaultValue: false),
    // Provide placeholder/default values for splash config
    appVersion: '1.0.0+1', // Example version
    minimumRequiredVersion: '1.0.0',
    // maintenanceMessage: 'App is undergoing scheduled maintenance until 2 PM.',
    // updateUrl: 'https://yourappstore.com/update',
  );
  
  // Wrap the app with ProviderScope for Riverpod
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}