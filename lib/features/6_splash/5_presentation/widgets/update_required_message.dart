import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Message to display when an update is required
class UpdateRequiredMessage extends StatelessWidget {
  /// Creates an update required message
  const UpdateRequiredMessage({
    super.key,
    required this.currentVersion,
    required this.requiredVersion,
    this.updateUrl,
  });

  /// Current app version
  final String currentVersion;
  
  /// Required minimum version
  final String requiredVersion;
  
  /// URL to update app
  final String? updateUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.system_update,
          size: 64,
          color: Colors.white,
        ),
        const SizedBox(height: 24),
        Text(
          'Update Required',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'You\'re using version $currentVersion. '
            'Please update to version $requiredVersion or later.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white70,
            ),
          ),
        ),
        const SizedBox(height: 32),
        if (updateUrl != null)
          ElevatedButton(
            onPressed: () => _launchUpdateUrl(updateUrl!),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 12,
              ),
            ),
            child: const Text('Update Now'),
          ),
      ],
    );
  }
  
  Future<void> _launchUpdateUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
