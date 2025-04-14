import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/usecase/usecase.dart';
import '../1_domain/entities/notification.dart';
import '../1_domain/usecases/get_notifications_use_case.dart';
import '../1_domain/usecases/get_unread_count_use_case.dart';
import '../1_domain/usecases/mark_as_read_use_case.dart';
import '../3_di/notification_injection_container.dart';

/// Notification state class containing all state information
class NotificationState {
  /// Creates a notification state
  const NotificationState({
    this.notifications = const [],
    this.unreadCount = 0,
    this.isLoading = false,
    this.errorMessage,
    this.selectedNotificationId,
  });

  /// List of notifications
  final List<Notification> notifications;
  
  /// Count of unread notifications
  final int unreadCount;
  
  /// Whether notifications are being loaded
  final bool isLoading;
  
  /// Error message if any
  final String? errorMessage;
  
  /// Currently selected notification ID if any
  final String? selectedNotificationId;

  /// Creates a copy of the state with specified fields updated
  NotificationState copyWith({
    List<Notification>? notifications,
    int? unreadCount,
    bool? isLoading,
    String? errorMessage,
    String? selectedNotificationId,
    bool clearError = false,
    bool clearSelectedNotification = false,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      selectedNotificationId: clearSelectedNotification ? null : 
          (selectedNotificationId ?? this.selectedNotificationId),
    );
  }
  
  /// Gets the currently selected notification if there is one
  Notification? get selectedNotification {
    if (selectedNotificationId == null) return null;
    return notifications.firstWhere(
      (notification) => notification.id == selectedNotificationId,
      orElse: () => Notification(
        id: '', title: '', body: '', createdAt: DateTime.now()
      ),
    );
  }
  
  /// Get all unread notifications
  List<Notification> get unreadNotifications => 
      notifications.where((notification) => !notification.read).toList();
      
  /// Get all read notifications
  List<Notification> get readNotifications =>
      notifications.where((notification) => notification.read).toList();
}

/// Notification State Notifier that manages the notification state
class NotificationStateNotifier extends StateNotifier<NotificationState> {
  /// Creates a notification state notifier
  NotificationStateNotifier({
    required GetNotificationsUseCase getNotificationsUseCase,
    required GetUnreadCountUseCase getUnreadCountUseCase,
    required MarkAsReadUseCase markAsReadUseCase,
  }) : _getNotificationsUseCase = getNotificationsUseCase,
       _getUnreadCountUseCase = getUnreadCountUseCase,
       _markAsReadUseCase = markAsReadUseCase,
       super(const NotificationState());

  final GetNotificationsUseCase _getNotificationsUseCase;
  final GetUnreadCountUseCase _getUnreadCountUseCase;
  final MarkAsReadUseCase _markAsReadUseCase;

  /// Load all notifications
  Future<bool> loadNotifications() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _getNotificationsUseCase(NoParams());

    return result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: failure.message,
          isLoading: false,
        );
        return false;
      },
      (notifications) async {
        // Also update unread count
        final unreadCountResult = await _getUnreadCountUseCase(NoParams());
        
        final unreadCount = unreadCountResult.fold(
          (failure) => 0,
          (count) => count,
        );
        
        state = state.copyWith(
          notifications: notifications,
          unreadCount: unreadCount,
          isLoading: false,
        );
        return true;
      },
    );
  }
  
  /// Mark a notification as read
  Future<bool> markAsRead(String id) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _markAsReadUseCase(MarkAsReadParams(id: id));

    return result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: failure.message,
          isLoading: false,
        );
        return false;
      },
      (updatedNotification) {
        // Update the notification in the list
        final updatedNotifications = state.notifications.map((notification) {
          if (notification.id == updatedNotification.id) {
            return updatedNotification;
          }
          return notification;
        }).toList();
        
        // Update unread count
        final newUnreadCount = state.unreadCount - 1;
        
        state = state.copyWith(
          notifications: updatedNotifications,
          unreadCount: newUnreadCount > 0 ? newUnreadCount : 0,
          isLoading: false,
        );
        return true;
      },
    );
  }
  
  /// Select a notification
  void selectNotification(String id) {
    state = state.copyWith(selectedNotificationId: id);
  }
  
  /// Clear selected notification
  void clearSelectedNotification() {
    state = state.copyWith(clearSelectedNotification: true);
  }
}

/// Provider for the notification state notifier
final notificationProvider = StateNotifierProvider<NotificationStateNotifier, NotificationState>((ref) {
  return NotificationStateNotifier(
    getNotificationsUseCase: notificationInjection<GetNotificationsUseCase>(),
    getUnreadCountUseCase: notificationInjection<GetUnreadCountUseCase>(),
    markAsReadUseCase: notificationInjection<MarkAsReadUseCase>(),
  );
});

/// Provider to access notifications for simpler consumption
final notificationsProvider = Provider<List<Notification>>((ref) {
  return ref.watch(notificationProvider).notifications;
});

/// Provider to access unread count for simpler consumption
final unreadCountProvider = Provider<int>((ref) {
  return ref.watch(notificationProvider).unreadCount;
});

/// Provider to access unread notifications for simpler consumption
final unreadNotificationsProvider = Provider<List<Notification>>((ref) {
  return ref.watch(notificationProvider).unreadNotifications;
});

/// Provider to access read notifications for simpler consumption
final readNotificationsProvider = Provider<List<Notification>>((ref) {
  return ref.watch(notificationProvider).readNotifications;
});

/// Provider to access selected notification for simpler consumption
final selectedNotificationProvider = Provider<Notification?>((ref) {
  return ref.watch(notificationProvider).selectedNotification;
});