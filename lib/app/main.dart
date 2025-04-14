// This file is kept for backward compatibility
// The actual main entry point is in lib/main.dart
// This ensures that code referencing this file still works while gradually
// moving to the new structure.

import '../main.dart' as main_app;
export '../app.dart';

// Re-export the main function to be called by any entry points still using this file
void main() {
  main_app.main();
}

// Export the main app for any references
// export '../app.dart';
