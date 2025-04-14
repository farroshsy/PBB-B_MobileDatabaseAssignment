import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/shared/widgets/layout/page_container.dart';
import '../../4_providers/profile_provider.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/profile_info_card.dart';
import 'profile_details_screen.dart';

/// Profile screen showing user profile information
class ProfileScreen extends ConsumerStatefulWidget {
  /// Creates a profile screen
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Delay the data loading until after the first frame
    Future.microtask(() => _loadProfile());
  }
  
  Future<void> _loadProfile() async {
    // Check if mounted
    if (mounted) { 
      await ref.read(profileProvider.notifier).loadProfile();
    }
  }
  
  void _navigateToEditProfile() {
    final profile = ref.read(profileProvider).profile;
    if (profile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileDetailsScreen(profile: profile),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: profileState.isProfileLoaded ? _navigateToEditProfile : null,
          ),
        ],
      ),
      body: PageContainer(
        child: profileState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildProfileContent(profileState),
      ),
    );
  }
  
  Widget _buildProfileContent(ProfileState state) {
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
              onPressed: _loadProfile,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    
    if (!state.isProfileLoaded) {
      return const Center(
        child: Text('No profile data available'),
      );
    }
    
    final profile = state.profile!;
    
    return RefreshIndicator(
      onRefresh: _loadProfile,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            ProfileAvatar(
              photoUrl: profile.photoUrl,
              name: profile.name,
              size: 100,
            ),
            const SizedBox(height: 16),
            Text(
              profile.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              profile.email,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (profile.bio != null) ...[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  profile.bio!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
            const SizedBox(height: 32),
            ProfileInfoCard(
              title: 'Contact Information',
              items: [
                if (profile.email.isNotEmpty)
                  ProfileInfoItem(
                    icon: Icons.email,
                    label: 'Email',
                    value: profile.email,
                  ),
                if (profile.phoneNumber != null)
                  ProfileInfoItem(
                    icon: Icons.phone,
                    label: 'Phone',
                    value: profile.phoneNumber!,
                  ),
                if (profile.address != null)
                  ProfileInfoItem(
                    icon: Icons.location_on,
                    label: 'Address',
                    value: profile.address!,
                  ),
              ],
            ),
            const SizedBox(height: 16),
            if (profile.preferences.isNotEmpty)
              ProfileInfoCard(
                title: 'Preferences',
                items: profile.preferences.entries.map((entry) {
                  return ProfileInfoItem(
                    icon: Icons.settings,
                    label: entry.key,
                    value: entry.value.toString(),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}