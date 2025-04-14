import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/shared/widgets/buttons/primary_button.dart';
import 'package:my_app/shared/widgets/layout/page_container.dart';
import 'package:my_app/shared/widgets/typography/page_title.dart';
import '../../4_providers/dashboard_provider.dart';

/// Detailed view screen for dashboard feature
class DashboardDetailsScreen extends ConsumerStatefulWidget {
  /// Creates a dashboard details screen
  const DashboardDetailsScreen({
    super.key,
    required this.id,
  });

  /// ID of the dashboard to display
  final String id;

  @override
  ConsumerState<DashboardDetailsScreen> createState() => _DashboardDetailsScreenState();
}

class _DashboardDetailsScreenState extends ConsumerState<DashboardDetailsScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  
  Future<void> _loadData() async {
    await ref.read(dashboardProvider.notifier).loadDashboardDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    // Watch dashboard state from provider
    final dashboardState = ref.watch(dashboardProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Details'),
      ),
      body: PageContainer(
        child: Builder(
          builder: (context) {
            if (dashboardState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (dashboardState.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dashboardState.errorMessage!,
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    PrimaryButton(
                      onPressed: _loadData,
                      text: 'Retry',
                    ),
                  ],
                ),
              );
            }
            
            final dashboard = dashboardState.dashboard;
            
            if (dashboard == null) {
              return const Center(child: Text('No data available'));
            }
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageTitle(
                  title: dashboard.name,
                  subtitle: 'Detailed information',
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ID: ${dashboard.id}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Name: ${dashboard.name}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}