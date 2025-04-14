import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/config/app_config.dart';
import 'package:my_app/core/di/injection_container.dart' as di;
import 'package:my_app/core/navigation/app_router.dart' as router;

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get instances from GetIt service locator
    final appConfig = di.sl<AppConfig>();
    final appRouter = di.sl<router.AppRouter>();
    
    return MaterialApp.router(
      title: 'My App Boilerplate',
      
      // Router configuration from AppRouter
      routerConfig: appRouter.router, 
      
      // Theme (basic for now, replace with AppTheme later)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // TODO: Add darkTheme and themeMode
      
      // TODO: Add localization delegates and supported locales
      
      // Show debug banner based on config
      debugShowCheckedModeBanner: appConfig.isDevMode, 
    );
  }
} 