import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/shared/widgets/cards/app_card.dart';
import 'package:my_app/shared/widgets/layout/page_container.dart';
import 'package:my_app/shared/widgets/typography/page_title.dart';
import '../../1_domain/entities/dashboard_stats.dart';
import '../../4_providers/dashboard_provider.dart';
import '../widgets/stats_card.dart';
import '../widgets/performance_chart.dart';

/// Dashboard screen showing analytics and statistics
class DashboardScreen extends ConsumerStatefulWidget {
  /// Creates a dashboard screen
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Delay the data loading until after the first frame
    Future.microtask(() => _loadData());
  }
  
  Future<void> _loadData() async {
    // Check if the widget is still mounted before modifying state
    if (mounted) {
      // Load dashboard stats using Riverpod
      await ref.read(dashboardProvider.notifier).loadDashboardStats();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardProvider);
    
    return PageContainer( 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle(
            title: 'Dashboard', 
            subtitle: 'Overview of key metrics and performance',
          ),
          dashboardState.isLoading 
            ? const Center(child: CircularProgressIndicator())
            : _buildDashboardContent(dashboardState),
        ],
      ),
    );
  }
  
  Widget _buildDashboardContent(DashboardState state) {
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
              onPressed: _loadData,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    
    final stats = state.dashboardStats;
    if (stats == null) {
      return const Center(
        child: Text('No dashboard data available'),
      );
    }
    
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildStatsRow(stats),
          const SizedBox(height: 24),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Performance Overview',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                const PerformanceChart(),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Top Performers',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          _buildTopPerformers(stats),
        ],
      ),
    );
  }
  
  Widget _buildStatsRow(DashboardStats stats) {
    return Row(
      children: [
        Expanded(
          child: StatsCard(
            title: 'Total Users',
            value: stats.totalUsers.toString(),
            icon: Icons.people,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: StatsCard(
            title: 'Active Users',
            value: stats.activeUsers.toString(),
            icon: Icons.person_outlined,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: StatsCard(
            title: 'Revenue',
            value: '\$${stats.totalRevenue.toStringAsFixed(2)}',
            icon: Icons.attach_money,
            color: Colors.amber,
          ),
        ),
      ],
    );
  }
  
  Widget _buildTopPerformers(DashboardStats stats) {
    if (stats.topPerformers.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text('No top performers data available'),
      );
    }
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.topPerformers.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.star, color: Colors.amber),
          title: Text(stats.topPerformers[index]),
          trailing: const Icon(Icons.chevron_right),
        );
      },
    );
  }
}