import '../../1_domain/entities/home_data.dart';

/// Data model for home data
class HomeDataModel extends HomeData {
  /// Creates a home data model
  const HomeDataModel({
    required super.banners,
    required super.featuredItems,
    super.notifications,
    super.userGreeting,
    this.lastUpdated,
  });

  /// When the data was last updated
  final DateTime? lastUpdated;

  /// Creates home data model from JSON
  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel(
      banners: (json['banners'] as List<dynamic>)
          .map((e) => BannerItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      featuredItems: (json['featuredItems'] as List<dynamic>)
          .map((e) => FeaturedItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      notifications: json['notifications'] != null
          ? (json['notifications'] as List<dynamic>)
              .map((e) => NotificationItemModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      userGreeting: json['userGreeting'] as String?,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'] as String)
          : null,
    );
  }

  /// Converts model to JSON
  Map<String, dynamic> toJson() {
    return {
      'banners': (banners as List<BannerItemModel>)
          .map((e) => e.toJson())
          .toList(),
      'featuredItems': (featuredItems as List<FeaturedItemModel>)
          .map((e) => e.toJson())
          .toList(),
      'notifications': (notifications as List<NotificationItemModel>)
          .map((e) => e.toJson())
          .toList(),
      'userGreeting': userGreeting,
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }
}

/// Data model for banner item
class BannerItemModel extends BannerItem {
  /// Creates a banner item model
  const BannerItemModel({
    required super.id,
    required super.imageUrl,
    required super.title,
    super.subtitle,
    super.actionUrl,
    super.actionLabel,
  });

  /// Creates banner item model from JSON
  factory BannerItemModel.fromJson(Map<String, dynamic> json) {
    return BannerItemModel(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      actionUrl: json['actionUrl'] as String?,
      actionLabel: json['actionLabel'] as String?,
    );
  }

  /// Converts model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'subtitle': subtitle,
      'actionUrl': actionUrl,
      'actionLabel': actionLabel,
    };
  }
}

/// Data model for featured item
class FeaturedItemModel extends FeaturedItem {
  /// Creates a featured item model
  const FeaturedItemModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    super.subtitle,
    super.type,
  });

  /// Creates featured item model from JSON
  factory FeaturedItemModel.fromJson(Map<String, dynamic> json) {
    return FeaturedItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      subtitle: json['subtitle'] as String?,
      type: json['type'] as String?,
    );
  }

  /// Converts model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'subtitle': subtitle,
      'type': type,
    };
  }
}

/// Data model for notification item
class NotificationItemModel extends NotificationItem {
  /// Creates a notification item model
  const NotificationItemModel({
    required super.id,
    required super.title,
    required super.createdAt,
    super.read,
    super.actionUrl,
  });

  /// Creates notification item model from JSON
  factory NotificationItemModel.fromJson(Map<String, dynamic> json) {
    return NotificationItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      read: json['read'] as bool? ?? false,
      actionUrl: json['actionUrl'] as String?,
    );
  }

  /// Converts model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'read': read,
      'actionUrl': actionUrl,
    };
  }
}
