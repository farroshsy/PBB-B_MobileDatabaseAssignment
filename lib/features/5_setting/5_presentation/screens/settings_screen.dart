import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter/material.dart' as material show ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/features/common/data/models/user_model.dart';
import 'package:my_app/shared/widgets/layout/page_container.dart';
import 'package:my_app/shared/widgets/typography/page_title.dart';
import '../../4_providers/settings_provider.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_switch_tile.dart';
import '../../1_domain/entities/app_settings.dart';

/// Settings screen showing app settings
class SettingsScreen extends ConsumerStatefulWidget {
  /// Creates a settings screen
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _userBoxName = 'users';
  late Box<User> _userBox;

  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  String _statusMessage = 'Open the box to start.';
  User? _retrievedUser;

  @override
  void initState() {
    super.initState();
    _openUserBox();
  }

  Future<void> _openUserBox() async {
    if (!Hive.isBoxOpen(_userBoxName)) {
      _userBox = await Hive.openBox<User>(_userBoxName);
      setState(() {
        _statusMessage = 'User box opened.';
      });
    } else {
      _userBox = Hive.box<User>(_userBoxName);
      setState(() {
        _statusMessage = 'User box already open.';
      });
    }
  }

  Future<void> _addUser() async {
    if (!_userBox.isOpen) {
      setState(() => _statusMessage = 'Box is not open!');
      return;
    }
    final id = _idController.text;
    final name = _nameController.text;
    final age = int.tryParse(_ageController.text);

    if (id.isNotEmpty && name.isNotEmpty && age != null) {
      final user = User(id: id, name: name, age: age);
      await _userBox.put(id, user);
      setState(() {
        _statusMessage = 'User Added/Updated: $id';
        _idController.clear();
        _nameController.clear();
        _ageController.clear();
        _retrievedUser = null;
      });
    } else {
      setState(() => _statusMessage = 'Invalid input.');
    }
  }

  void _getUser() {
    if (!_userBox.isOpen) {
      setState(() => _statusMessage = 'Box is not open!');
      return;
    }
    final id = _idController.text;
    if (id.isNotEmpty) {
      final user = _userBox.get(id);
      setState(() {
        if (user != null) {
          _retrievedUser = user;
          _nameController.text = user.name;
          _ageController.text = user.age.toString();
          _statusMessage = 'User Retrieved: ${user.id}';
        } else {
          _retrievedUser = null;
          _nameController.clear();
          _ageController.clear();
          _statusMessage = 'User not found: $id';
        }
      });
    } else {
      setState(() => _statusMessage = 'Enter an ID to retrieve.');
    }
  }

  Future<void> _deleteUser() async {
    if (!_userBox.isOpen) {
      setState(() => _statusMessage = 'Box is not open!');
      return;
    }
    final id = _idController.text;
    if (id.isNotEmpty) {
      if (_userBox.containsKey(id)) {
        await _userBox.delete(id);
        setState(() {
          _statusMessage = 'User Deleted: $id';
          _idController.clear();
          _nameController.clear();
          _ageController.clear();
          _retrievedUser = null;
        });
      } else {
        setState(() => _statusMessage = 'User not found for deletion: $id');
      }
    } else {
      setState(() => _statusMessage = 'Enter an ID to delete.');
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  material.ThemeMode _toMaterialThemeMode(ThemeMode localMode) {
    switch (localMode) {
      case ThemeMode.light:
        return material.ThemeMode.light;
      case ThemeMode.dark:
        return material.ThemeMode.dark;
      case ThemeMode.system:
      default:
        return material.ThemeMode.system;
    }
  }

  ThemeMode _fromMaterialThemeMode(material.ThemeMode materialMode) {
     switch (materialMode) {
      case material.ThemeMode.light:
        return ThemeMode.light;
      case material.ThemeMode.dark:
        return ThemeMode.dark;
      case material.ThemeMode.system:
      default:
        return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsProvider);
    final currentThemeMode = ref.watch(themeModeProvider);
    
    final settings = settingsState.settings;
    final isLoading = settingsState.isLoading;
    final errorMessage = settingsState.errorMessage;

    return PageContainer(
      scrollable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle(title: 'Settings', subtitle: 'Manage your preferences'),
          if (isLoading && settings == null)
            const Center(child: CircularProgressIndicator())
          else if (errorMessage != null)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 40),
                  const SizedBox(height: 8),
                  Text(errorMessage, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref.read(settingsProvider.notifier).loadSettings(),
                    child: const Text('Retry'),
                  )
                ],
              )
            )
          else if (settings == null)
            const Center(child: Text('Could not load settings.'))
          else ...[
            SettingsSection(
              title: 'Appearance',
              children: [
                ListTile(
                  title: const Text('Theme Mode'), 
                  subtitle: Text('Current: ${settings.themeMode.name}'),
                  trailing: DropdownButton<material.ThemeMode>(
                    value: _toMaterialThemeMode(settings.themeMode),
                    items: material.ThemeMode.values
                      .map((mode) => DropdownMenuItem(
                          value: mode, 
                          child: Text(mode.name), 
                      ))
                      .toList(),
                    onChanged: (material.ThemeMode? value) {
                      if (value != null) {
                        ref.read(settingsProvider.notifier).updateThemeMode(_fromMaterialThemeMode(value));
                      }
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Font Scale'), 
                  subtitle: Text('Current: ${settings.fontScale.toStringAsFixed(1)}'),
                  trailing: const Text('Adjust'),
                  onTap: () { /* TODO: Show font scale dialog */ },
                ),
              ],
            ),
            SettingsSection(
              title: 'Language',
              children: [
                ListTile(
                  title: const Text('Language'), 
                  subtitle: Text('Current: ${settings.locale}'),
                  trailing: const Text('Change'),
                  onTap: () { /* TODO: Show language picker */ },
                ),
              ],
            ),
            SettingsSection(
              title: 'Notifications',
              children: [
                SettingsSwitchTile(
                  title: 'Enable Notifications',
                  subtitle: 'Receive push and email notifications',
                  value: settings.notificationsEnabled,
                  onChanged: ref.read(settingsProvider.notifier).toggleNotifications,
                ),
                SettingsSwitchTile(
                  title: 'Push Notifications',
                  subtitle: 'Receive notifications on this device',
                  value: settings.pushNotificationsEnabled,
                  onChanged: ref.read(settingsProvider.notifier).togglePushNotifications,
                  enabled: settings.notificationsEnabled,
                ),
                SettingsSwitchTile(
                  title: 'Email Notifications',
                  subtitle: 'Receive notifications by email',
                  value: settings.emailNotificationsEnabled,
                  onChanged: ref.read(settingsProvider.notifier).toggleEmailNotifications,
                  enabled: settings.notificationsEnabled,
                ),
              ],
            ),
            SettingsSection(
              title: 'Data & Media',
              children: [
                SettingsSwitchTile(
                  title: 'Auto-play Videos',
                  subtitle: 'Automatically play videos in your feed',
                  value: settings.autoPlayVideos,
                  onChanged: (value) {
                    final updated = settings.copyWith(autoPlayVideos: value);
                    ref.read(settingsProvider.notifier).updateSettings(updated);
                  },
                ),
                SettingsSwitchTile(
                  title: 'Download on Wi-Fi Only',
                  subtitle: 'Prevent downloading content on cellular data',
                  value: settings.downloadOnWifiOnly,
                  onChanged: (value) {
                    final updated = settings.copyWith(downloadOnWifiOnly: value);
                    ref.read(settingsProvider.notifier).updateSettings(updated);
                  },
                ),
              ],
            ),
            SettingsSection(
              title: 'Privacy',
              children: [
                SettingsSwitchTile(
                  title: 'Usage Analytics',
                  subtitle: 'Share anonymous usage data',
                  value: settings.analyticsEnabled,
                  onChanged: (value) {
                    final updated = settings.copyWith(analyticsEnabled: value);
                    ref.read(settingsProvider.notifier).updateSettings(updated);
                  },
                ),
              ],
            ),
            SettingsSection(
              title: 'Hive CRUD Example (Users)',
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_statusMessage),
                ),
                if (_retrievedUser != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Currently Showing: ${_retrievedUser?.toString() ?? "None"}'),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: TextField(
                    controller: _idController,
                    decoration: const InputDecoration(labelText: 'User ID (Key)'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: TextField(
                    controller: _ageController,
                    decoration: const InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: <Widget>[
                      ElevatedButton(onPressed: _addUser, child: const Text('Add/Update User')),
                      ElevatedButton(onPressed: _getUser, child: const Text('Get User')),
                      ElevatedButton(onPressed: _deleteUser, child: const Text('Delete User')),
                    ],
                  ),
                )
              ],
            ),
          ],
        ],
      ),
    );
  }
}