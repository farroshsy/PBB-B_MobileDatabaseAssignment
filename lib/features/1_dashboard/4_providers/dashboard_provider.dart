import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/usecase/usecase.dart';
import '../1_domain/entities/dashboard.dart';
import '../1_domain/entities/dashboard_stats.dart';
import '../1_domain/usecases/get_dashboard_details_use_case.dart';
import '../1_domain/usecases/get_dashboard_stats_use_case.dart';
import '../3_di/dashboard_injection_container.dart';

/// Dashboard state class containing all state information
class DashboardState {
  /// Creates a dashboard state
  const DashboardState({
    this.dashboardStats,
    this.dashboard,
    this.isLoading = false,
    this.errorMessage,
  });

  /// Dashboard statistics data
  final DashboardStats? dashboardStats;
  
  /// Dashboard details data
  final Dashboard? dashboard;
  
  /// Whether the dashboard is loading
  final bool isLoading;
  
  /// Error message, if any
  final String? errorMessage;

  /// Creates a copy of the state with specified fields updated
  DashboardState copyWith({
    DashboardStats? dashboardStats,
    Dashboard? dashboard,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return DashboardState(
      dashboardStats: dashboardStats ?? this.dashboardStats,
      dashboard: dashboard ?? this.dashboard,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// Dashboard State Notifier that manages the dashboard state
class DashboardStateNotifier extends StateNotifier<DashboardState> {
  /// Creates a dashboard state notifier
  DashboardStateNotifier({
    required GetDashboardStatsUseCase getDashboardStatsUseCase,
    required GetDashboardDetailsUseCase getDashboardDetailsUseCase,
  }) : _getDashboardStatsUseCase = getDashboardStatsUseCase,
       _getDashboardDetailsUseCase = getDashboardDetailsUseCase,
       super(const DashboardState());

  final GetDashboardStatsUseCase _getDashboardStatsUseCase;
  final GetDashboardDetailsUseCase _getDashboardDetailsUseCase;

  /// Load dashboard statistics
  Future<bool> loadDashboardStats() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _getDashboardStatsUseCase(NoParams());

    return result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: failure.message,
          isLoading: false,
        );
        return false;
      },
      (stats) {
        state = state.copyWith(
          dashboardStats: stats,
          isLoading: false,
        );
        return true;
      },
    );
  }

  /// Load dashboard details by ID
  Future<bool> loadDashboardDetails(String id) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final params = GetDashboardDetailsParams(id: id);
    final result = await _getDashboardDetailsUseCase(params);

    return result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: failure.message,
          isLoading: false,
        );
        return false;
      },
      (dashboard) {
        state = state.copyWith(
          dashboard: dashboard,
          isLoading: false,
        );
        return true;
      },
    );
  }
}

/// Provider for the dashboard state notifier
final dashboardProvider = StateNotifierProvider<DashboardStateNotifier, DashboardState>((ref) {
  return DashboardStateNotifier(
    getDashboardStatsUseCase: dashboardInjection<GetDashboardStatsUseCase>(),
    getDashboardDetailsUseCase: dashboardInjection<GetDashboardDetailsUseCase>(),
  );
});

/// Provider to access dashboard stats for simpler consumption
final dashboardStatsProvider = Provider<DashboardStats?>((ref) {
  return ref.watch(dashboardProvider).dashboardStats;
});

/// Provider to access dashboard details for simpler consumption
final dashboardDetailsProvider = Provider.family<Dashboard?, String>((ref, id) {
  final state = ref.watch(dashboardProvider);
  // Check if we already have the dashboard with matching id
  if (state.dashboard?.id == id) {
    return state.dashboard;
  }
  // Otherwise trigger the loading of the dashboard
  ref.read(dashboardProvider.notifier).loadDashboardDetails(id);
  return null;
});