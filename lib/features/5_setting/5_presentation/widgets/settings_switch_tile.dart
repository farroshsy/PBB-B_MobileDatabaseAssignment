import 'package:flutter/material.dart';

/// Widget for displaying a settings switch item
class SettingsSwitchTile extends StatelessWidget {
  /// Creates a settings switch tile
  const SettingsSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.enabled = true,
  });

  /// Title of the settings item
  final String title;
  
  /// Subtitle/description of the settings item
  final String? subtitle;
  
  /// Current value of the switch
  final bool value;
  
  /// Callback when switch value changes
  final ValueChanged<bool> onChanged;
  
  /// Whether the switch is enabled
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      value: value,
      onChanged: enabled ? onChanged : null,
      activeColor: Theme.of(context).colorScheme.primary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}