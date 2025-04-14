import 'package:flutter/material.dart';

/// Profile avatar with optional edit capability
class ProfileAvatar extends StatelessWidget {
  /// Creates a profile avatar
  const ProfileAvatar({
    super.key,
    this.photoUrl,
    required this.name,
    this.size = 64,
    this.onTap,
    this.showEditIcon = true,
  });

  /// URL to user's photo (optional)
  final String? photoUrl;
  
  /// User's name (used for fallback)
  final String name;
  
  /// Avatar size
  final double size;
  
  /// Optional tap callback
  final VoidCallback? onTap;
  
  /// Whether to show edit icon
  final bool showEditIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primary.withAlpha(26),
              border: Border.all(
                color: theme.colorScheme.primary.withAlpha(128),
                width: 2,
              ),
            ),
            child: photoUrl != null && photoUrl!.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      photoUrl!,
                      width: size,
                      height: size,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => _buildFallbackAvatar(),
                    ),
                  )
                : _buildFallbackAvatar(),
          ),
        ),
        if (showEditIcon && onTap != null)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.colorScheme.surface,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.edit,
                size: size * 0.2,
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
      ],
    );
  }
  
  Widget _buildFallbackAvatar() {
    return Center(
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : '?',
        style: TextStyle(
          fontSize: size * 0.5,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
