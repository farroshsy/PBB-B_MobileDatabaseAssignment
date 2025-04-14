import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/core/usecase/usecase.dart';
import '../1_domain/entities/home.dart';
import '../1_domain/entities/home_data.dart';
import '../1_domain/usecases/get_home_data_use_case.dart';
import '../3_di/home_injection_container.dart';

/// Home state class containing all state information
class HomeState {
  /// Creates a home state
  const HomeState({
    this.homeData,
    this.home,
    this.isLoading = false,
    this.errorMessage,
  });

  /// Home screen data
  final HomeData? homeData;
  
  /// Home details data
  final Home? home;
  
  /// Whether the home screen is loading
  final bool isLoading;
  
  /// Error message, if any
  final String? errorMessage;

  /// Creates a copy of the state with specified fields updated
  HomeState copyWith({
    HomeData? homeData,
    Home? home,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return HomeState(
      homeData: homeData ?? this.homeData,
      home: home ?? this.home,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
  
  /// Get banners from home data
  List<BannerItem> get banners => homeData?.banners ?? [];
  
  /// Get featured items from home data
  List<FeaturedItem> get featuredItems => homeData?.featuredItems ?? [];
  
  /// Get notifications from home data
  List<NotificationItem> get notifications => homeData?.notifications ?? [];
  
  /// Get user greeting from home data
  String? get userGreeting => homeData?.userGreeting;
}

/// Home State Notifier that manages the home state
class HomeStateNotifier extends StateNotifier<HomeState> {
  /// Creates a home state notifier
  HomeStateNotifier({
    required GetHomeDataUseCase getHomeDataUseCase,
  }) : _getHomeDataUseCase = getHomeDataUseCase,
       super(const HomeState());

  final GetHomeDataUseCase _getHomeDataUseCase;

  /// Load home screen data
  Future<bool> loadHomeData() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _getHomeDataUseCase(NoParams());

    return result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: failure.message,
          isLoading: false,
        );
        return false;
      },
      (data) {
        state = state.copyWith(
          homeData: data,
          isLoading: false,
        );
        return true;
      },
    );
  }
}

/// Provider for the home state notifier
final homeProvider = StateNotifierProvider<HomeStateNotifier, HomeState>((ref) {
  return HomeStateNotifier(
    getHomeDataUseCase: homeInjection<GetHomeDataUseCase>(),
  );
});

/// Provider to access home data for simpler consumption
final homeDataProvider = Provider<HomeData?>((ref) {
  return ref.watch(homeProvider).homeData;
});

/// Provider to access banners for simpler consumption
final bannersProvider = Provider<List<BannerItem>>((ref) {
  return ref.watch(homeProvider).banners;
});

/// Provider to access featured items for simpler consumption
final featuredItemsProvider = Provider<List<FeaturedItem>>((ref) {
  return ref.watch(homeProvider).featuredItems;
});

/// Provider to access notifications for simpler consumption
final notificationsProvider = Provider<List<NotificationItem>>((ref) {
  return ref.watch(homeProvider).notifications;
});

/// Provider to access user greeting for simpler consumption
final userGreetingProvider = Provider<String?>((ref) {
  return ref.watch(homeProvider).userGreeting;
});