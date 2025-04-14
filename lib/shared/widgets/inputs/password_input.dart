import 'package:flutter/material.dart';
import 'text_input.dart';

/// Password input field with show/hide functionality
class PasswordInput extends StatefulWidget {
  /// Creates a password input field
  const PasswordInput({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.onFieldSubmitted,
    this.textInputAction = TextInputAction.done,
    this.enabled = true,
  });

  /// Text editing controller
  final TextEditingController controller;
  
  /// Optional label text
  final String? labelText;
  
  /// Optional hint text
  final String? hintText;
  
  /// Optional prefix icon
  final Widget? prefixIcon;
  
  /// Optional validator function
  final String? Function(String?)? validator;
  
  /// Optional callback when field is submitted
  final void Function(String)? onFieldSubmitted;
  
  /// Action to take when submitting
  final TextInputAction textInputAction;
  
  /// Whether input is enabled
  final bool enabled;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextInput(
      controller: widget.controller,
      labelText: widget.labelText,
      hintText: widget.hintText,
      prefixIcon: widget.prefixIcon,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
        onPressed: _togglePasswordVisibility,
      ),
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      enabled: widget.enabled,
    );
  }
}
