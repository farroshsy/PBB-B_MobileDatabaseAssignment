import 'package:flutter/material.dart';

/// Item for profile info card
class ProfileInfoItem {
  /// Creates a profile info item
  const ProfileInfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });
  
  /// Icon to display
  final IconData icon;
  
  /// Label text
  final String label;
  
  /// Value text
  final String value;
}

/// Card displaying profile information items
class ProfileInfoCard extends StatelessWidget {
  /// Creates a profile info card
  const ProfileInfoCard({
    super.key,
    required this.title,
    required this.items,
  });
  
  /// Card title
  final String title;
  
  /// Information items to display
  final List<ProfileInfoItem> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...items.map((item) => _buildInfoItem(context, item)),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoItem(BuildContext context, ProfileInfoItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            item.icon,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                Text(
                  item.value,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}