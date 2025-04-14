import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: Import providers: 
// import '../providers/auth_providers.dart'; // Assuming a provider aggregation file

/// Login screen for authenticating users
class LoginScreen extends ConsumerStatefulWidget {
  /// Creates a login screen
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      
      // TODO: Replace with actual Riverpod call:
      // await ref.read(authStateNotifierProvider.notifier).signIn(
      //   _emailController.text,
      //   _passwordController.text,
      // );
      
      // Simulate network call for now
      await Future.delayed(const Duration(seconds: 1)); 
      print('Simulating login for Email: ${_emailController.text}');

      // Check mounted status before updating state or showing snackbar
      if (!mounted) return; 

      setState(() => _isLoading = false);

      // TODO: Listen to auth state for success/failure instead of just showing snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login attempt finished (check console)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Listen to auth state for error messages:
    // ref.listen<AuthState>(authStateNotifierProvider, (_, state) {
    //   if (state.status == AuthStatus.error && state.errorMessage != null) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text(state.errorMessage!)),
    //     );
    //   }
    // });

    return Scaffold(
      appBar: AppBar(title: const Text('Login')), // Added AppBar
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch buttons
              children: <Widget>[
                const Text('Welcome Back!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8), 
                const Text('Please sign in to continue.', style: TextStyle(fontSize: 16, color: Colors.grey)),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _isLoading ? null : () {
                       // TODO: Navigate using GoRouter
                       // context.push('/auth/forgot-password');
                       print('Forgot Password pressed');
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _isLoading ? null : _login,
                  child: _isLoading 
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
                      : const Text('Login'),
                ),
                const SizedBox(height: 16),
                Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     const Text("Don't have an account?"),
                     TextButton(
                       onPressed: _isLoading ? null : () {
                         // TODO: Navigate using GoRouter
                         // context.push('/auth/register');
                         print('Register pressed');
                       },
                       child: const Text('Register'),
                     ),
                   ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
