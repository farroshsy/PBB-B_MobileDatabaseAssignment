import 'package:flutter/material.dart';
import 'text_input_field.dart';

/// A specialized input field for passwords with a visibility toggle.
///
/// This component extends [TextInputField] with password-specific features.
class PasswordInputField extends StatefulWidget {
  /// Creates a password input field.
  ///
  /// [controller] is the controller for the text field.
  /// [label] is the field label.
  /// [hint] is an optional hint text.
  /// [onChanged] is called when the text changes.
  /// [onSubmitted] is called when the user submits the field.
  /// [validator] provides validation logic.
  /// [isRequired] adds a required indicator when true.
  /// [autofocus] focuses the field automatically when true.
  /// [enabled] enables/disables the field.
  /// [errorText] displays an error message.
  /// [helperText] displays helper text below the field.
  /// [showPasswordRequirements] displays password requirements when true.
  /// [fillColor] sets the background color of the field.
  /// [prefixIcon] adds an optional icon at the start.
  /// [borderRadius] customizes the field's corner radius.
  /// [passwordStrengthIndicator] shows password strength when true.
  const PasswordInputField({
    this.controller,
    this.label = 'Password',
    this.hint = 'Enter your password',
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.isRequired = true,
    this.autofocus = false,
    this.enabled = true,
    this.errorText,
    this.helperText,
    this.showPasswordRequirements = false,
    this.fillColor,
    this.prefixIcon,
    this.borderRadius,
    this.passwordStrengthIndicator = false,
    super.key,
  });

  /// Text editing controller
  final TextEditingController? controller;
  
  /// Field label
  final String? label;
  
  /// Hint text
  final String? hint;
  
  /// Called when text changes
  final ValueChanged<String>? onChanged;
  
  /// Called when field is submitted
  final ValueChanged<String>? onSubmitted;
  
  /// Validation function
  final String? Function(String?)? validator;
  
  /// Whether the field is required
  final bool isRequired;
  
  /// Whether to focus automatically
  final bool autofocus;
  
  /// Whether the field is enabled
  final bool enabled;
  
  /// Error message text
  final String? errorText;
  
  /// Helper text
  final String? helperText;
  
  /// Whether to show password requirements
  final bool showPasswordRequirements;
  
  /// Background color
  final Color? fillColor;
  
  /// Icon at the start of the field
  final Widget? prefixIcon;
  
  /// Corner radius
  final BorderRadius? borderRadius;
  
  /// Whether to show password strength
  final bool passwordStrengthIndicator;

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscureText = true;
  double _passwordStrength = 0.0;
  String _password = '';
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Toggle visibility button
    final suffixIcon = IconButton(
      icon: Icon(
        _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        color: theme.hintColor,
      ),
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );
    
    // Handle password strength calculation
    void handleOnChanged(String value) {
      if (widget.passwordStrengthIndicator) {
        setState(() {
          _password = value;
          _passwordStrength = _calculatePasswordStrength(value);
        });
      }
      
      if (widget.onChanged != null) {
        widget.onChanged!(value);
      }
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInputField(
          controller: widget.controller,
          label: widget.label,
          hint: widget.hint,
          prefixIcon: widget.prefixIcon ?? const Icon(Icons.lock_outline),
          suffixIcon: suffixIcon,
          onChanged: handleOnChanged,
          onSubmitted: widget.onSubmitted,
          validator: widget.validator,
          isRequired: widget.isRequired,
          autofocus: widget.autofocus,
          enabled: widget.enabled,
          obscureText: _obscureText,
          errorText: widget.errorText,
          helperText: widget.helperText,
          fillColor: widget.fillColor,
          borderRadius: widget.borderRadius,
          autofillHints: const [AutofillHints.password],
        ),
        
        // Password strength indicator
        if (widget.passwordStrengthIndicator && _password.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(
                  value: _passwordStrength,
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  color: _getPasswordStrengthColor(theme, _passwordStrength),
                ),
                const SizedBox(height: 4),
                Text(
                  _getPasswordStrengthLabel(_passwordStrength),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: _getPasswordStrengthColor(theme, _passwordStrength),
                  ),
                ),
              ],
            ),
          ),
        
        // Password requirements
        if (widget.showPasswordRequirements)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: _buildPasswordRequirements(theme),
          ),
      ],
    );
  }
  
  Widget _buildPasswordRequirements(ThemeData theme) {
    final requirements = [
      _buildRequirement(
        theme,
        'At least 8 characters',
        _password.length >= 8,
      ),
      _buildRequirement(
        theme, 
        'Contains uppercase letter',
        _password.contains(RegExp(r'[A-Z]')),
      ),
      _buildRequirement(
        theme,
        'Contains lowercase letter',
        _password.contains(RegExp(r'[a-z]')),
      ),
      _buildRequirement(
        theme,
        'Contains number',
        _password.contains(RegExp(r'[0-9]')),
      ),
      _buildRequirement(
        theme,
        'Contains special character',
        _password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
      ),
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password requirements:',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        ...requirements,
      ],
    );
  }
  
  Widget _buildRequirement(ThemeData theme, String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isMet ? Icons.check_circle_outline : Icons.circle_outlined,
            size: 14,
            color: isMet ? theme.colorScheme.primary : theme.hintColor,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: isMet ? theme.colorScheme.primary : theme.hintColor,
            ),
          ),
        ],
      ),
    );
  }
  
  double _calculatePasswordStrength(String password) {
    if (password.isEmpty) return 0.0;
    
    double strength = 0.0;
    
    // Length check
    if (password.length >= 8) strength += 0.2;
    if (password.length >= 12) strength += 0.1;
    
    // Complexity checks
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.2;
    if (password.contains(RegExp(r'[a-z]'))) strength += 0.2;
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.2;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.2;
    
    // Cap at 1.0
    return strength > 1.0 ? 1.0 : strength;
  }
  
  String _getPasswordStrengthLabel(double strength) {
    if (strength < 0.3) return 'Weak';
    if (strength < 0.6) return 'Medium';
    if (strength < 0.8) return 'Strong';
    return 'Very Strong';
  }
  
  Color _getPasswordStrengthColor(ThemeData theme, double strength) {
    if (strength < 0.3) return theme.colorScheme.error;
    if (strength < 0.6) return Colors.orange;
    if (strength < 0.8) return Colors.yellow.shade700;
    return Colors.green;
  }
}
