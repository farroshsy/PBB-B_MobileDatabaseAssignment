/// Home data entity representing content for the home screen
class HomeData {
  /// Creates home data entity
  const HomeData({
    required this.banners,
    required this.featuredItems,
    this.notifications = const [],
    this.userGreeting,
  });

  /// Banner items
  final List<BannerItem> banners;
  
  /// Featured items
  final List<FeaturedItem> featuredItems;
  
  /// Notifications
  final List<NotificationItem> notifications;
  
  /// Personalized greeting
  final String? userGreeting;
}

/// Banner item for carousel or hero section
class BannerItem {
  /// Creates a banner item
  const BannerItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    this.subtitle,
    this.actionUrl,
    this.actionLabel,
  });

  /// Unique ID
  final String id;
  
  /// URL to banner image
  final String imageUrl;
  
  /// Banner title
  final String title;
  
  /// Optional banner subtitle
  final String? subtitle;
  
  /// Optional action URL
  final String? actionUrl;
  
  /// Optional action label
  final String? actionLabel;
}

/// Featured item for a highlighted section
class FeaturedItem {
  /// Creates a featured item
  const FeaturedItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.subtitle,
    this.type,
  });

  /// Unique ID
  final String id;
  
  /// Item title
  final String title;
  
  /// URL to item image
  final String imageUrl;
  
  /// Optional subtitle
  final String? subtitle;
  
  /// Optional type identifier
  final String? type;
}

/// Notification item for the home screen
class NotificationItem {
  /// Creates a notification item
  const NotificationItem({
    required this.id,
    required this.title,
    required this.createdAt,
    this.read = false,
    this.actionUrl,
  });

  /// Unique ID
  final String id;
  
  /// Notification title
  final String title;
  
  /// When notification was created
  final DateTime createdAt;
  
  /// Whether notification has been read
  final bool read;
  
  /// Optional action URL
  final String? actionUrl;
}
