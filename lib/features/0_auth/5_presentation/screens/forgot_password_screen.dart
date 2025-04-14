import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/shared/widgets/buttons/primary_button.dart';
import 'package:my_app/shared/widgets/inputs/text_input.dart';
import 'package:my_app/shared/widgets/layout/page_container.dart';
import 'package:my_app/shared/widgets/typography/page_title.dart';
import '../../4_providers/auth_provider.dart';

/// Screen for requesting password reset
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  /// Creates a forgot password screen
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetEmail() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final success = await ref.read(authNotifierProvider.notifier).sendPasswordResetEmail(
      _emailController.text,
    );

    setState(() {
      _isSubmitting = false;
      _emailSent = success;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch the auth error message
    final errorMessage = ref.watch(authErrorProvider);
    final isLoading = ref.watch(authLoadingProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: PageContainer(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const PageTitle(
                title: 'Forgot Password',
                subtitle: 'Enter your email to reset your password',
              ),
              const SizedBox(height: 24),
              if (_emailSent) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Password Reset Email Sent',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'We\'ve sent an email to ${_emailController.text} with instructions to reset your password.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: 'Back to Login',
                ),
              ] else ...[
                TextInput(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      errorMessage,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                PrimaryButton(
                  onPressed: (_isSubmitting || isLoading) ? null : _sendResetEmail,
                  text: 'Send Reset Link',
                  isLoading: _isSubmitting || isLoading,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Remember your password?'),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/auth/login');
                      },
                      child: const Text('Sign In'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
