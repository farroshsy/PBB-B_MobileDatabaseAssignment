import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/shared/widgets/buttons/primary_button.dart';
import 'package:my_app/shared/widgets/inputs/text_input_field.dart';
import 'package:my_app/shared/widgets/layout/page_container.dart';
import '../../1_domain/entities/profile.dart';
import '../../4_providers/profile_provider.dart';

/// Profile details screen for editing user profile
class ProfileDetailsScreen extends ConsumerStatefulWidget {
  /// Creates a profile details screen
  const ProfileDetailsScreen({
    super.key,
    required this.profile,
  });

  /// Profile to edit
  final Profile profile;

  @override
  ConsumerState<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends ConsumerState<ProfileDetailsScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _bioController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  
  final _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _emailController = TextEditingController(text: widget.profile.email);
    _bioController = TextEditingController(text: widget.profile.bio ?? '');
    _phoneController = TextEditingController(text: widget.profile.phoneNumber ?? '');
    _addressController = TextEditingController(text: widget.profile.address ?? '');
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
  
  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    final updatedProfile = widget.profile.copyWith(
      name: _nameController.text,
      email: _emailController.text,
      bio: _bioController.text.isEmpty ? null : _bioController.text,
      phoneNumber: _phoneController.text.isEmpty ? null : _phoneController.text,
      address: _addressController.text.isEmpty ? null : _addressController.text,
    );
    
    final success = await ref.read(profileProvider.notifier).updateProfile(updatedProfile);
    
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);
    final isLoading = profileState.isUpdating;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: PageContainer(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Personal Information',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextInputField(
                  controller: _nameController,
                  label: 'Name',
                  prefixIcon: const Icon(Icons.person),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextInputField(
                  controller: _emailController,
                  label: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    // Simple email validation
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextInputField(
                  controller: _bioController,
                  label: 'Bio',
                  prefixIcon: const Icon(Icons.info),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                Text(
                  'Contact Information',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextInputField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  prefixIcon: const Icon(Icons.phone),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                TextInputField(
                  controller: _addressController,
                  label: 'Address',
                  prefixIcon: const Icon(Icons.location_on),
                  maxLines: 2,
                ),
                const SizedBox(height: 32),
                if (profileState.errorMessage != null)
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      profileState.errorMessage!,
                      style: TextStyle(color: Colors.red.shade900),
                    ),
                  ),
                PrimaryButton(
                  onPressed: isLoading ? null : _saveProfile,
                  text: 'Save Changes',
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}