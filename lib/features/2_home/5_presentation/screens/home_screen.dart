import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Removed Auth imports, now handled by shell
// import 'package:my_app/features/0_auth/4_providers/auth_providers.dart'; 
import 'package:my_app/shared/widgets/layout/page_container.dart';
import '../../4_providers/home_provider.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/featured_items_grid.dart';
import '../widgets/welcome_header.dart';

/// Home screen showing main content for the app
// Changed back to StatelessWidget as state is handled by ShellRoute/GoRouter
class HomeScreen extends ConsumerStatefulWidget { 
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // Removed _currentIndex and navigation methods, handled by shell
  // Removed _logout, handled by shell AppBar

  @override
  void initState() {
    super.initState();
    // Delay the data loading until after the first frame
    Future.microtask(() => _loadData());
  }
  
  Future<void> _loadData() async {
    if (mounted) { 
      await ref.read(homeProvider.notifier).loadHomeData();
    }
  }

  @override
  Widget build(BuildContext context) {
    // No longer need location or setting _currentIndex
    
    // Return only the body content, Scaffold/AppBar/BottomNav are in MainShell
    return PageContainer( 
      child: ref.watch(homeProvider).isLoading
        ? const Center(child: CircularProgressIndicator())
        : _buildHomeContent(ref.watch(homeProvider)),
    );
    
    // Removed Scaffold and BottomNavigationBar
  }
  
  Widget _buildHomeContent(HomeState state) {
    if (state.errorMessage != null) {
       return Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             const Icon(Icons.error_outline, size: 48, color: Colors.red),
             const SizedBox(height: 16),
             Text(
               state.errorMessage!,
               textAlign: TextAlign.center,
               style: const TextStyle(color: Colors.red),
             ),
             const SizedBox(height: 16),
             ElevatedButton(
               onPressed: _loadData, // Keep retry button
               child: const Text('Retry'),
             ),
           ],
         ),
       );
     }
     
     if (state.homeData == null) {
       return const Center(
         child: Text('No home data available'),
       );
     }
     
     return RefreshIndicator(
       onRefresh: _loadData,
       child: SingleChildScrollView(
         physics: const AlwaysScrollableScrollPhysics(),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             WelcomeHeader(greeting: state.userGreeting ?? 'Welcome!'),
             const SizedBox(height: 16),
             Center(
               child: ElevatedButton(
                 onPressed: () => context.push('/hive_example'),
                 child: const Text('Go to Simple Hive Example'),
               ),
             ),
             const SizedBox(height: 16),
             if (state.banners.isNotEmpty) ...[
               BannerCarousel(banners: state.banners),
               const SizedBox(height: 24),
             ],
             if (state.featuredItems.isNotEmpty) ...[
               Text(
                 'Featured Items',
                 style: Theme.of(context).textTheme.titleLarge,
               ),
               const SizedBox(height: 8),
               FeaturedItemsGrid(items: state.featuredItems),
             ],
           ],
         ),
       ),
     );
  }
}