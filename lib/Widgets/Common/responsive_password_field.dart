import 'package:flutter/material.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';

/// A responsive password field that adapts to different screen sizes
class ResponsivePasswordField extends StatefulWidget {
  /// The controller for the password field
  final TextEditingController controller;
  
  /// The hint text to display when the field is empty
  final String hintText;
  
  /// Whether the password field has an error
  final bool hasError;
  
  /// The error text to display when hasError is true
  final String? errorText;
  
  /// Whether the password field is enabled
  final bool enabled;
  
  /// The background color of the password field
  final Color fillColor;
  
  /// The text color of the password field
  final Color textColor;
  
  /// The hint text color of the password field
  final Color hintColor;
  
  /// The border radius of the password field
  final double borderRadius;
  
  /// The initial state of password visibility
  final bool initialObscureText;
  
  const ResponsivePasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    this.hasError = false,
    this.errorText,
    this.enabled = true,
    this.fillColor = const Color(0xffD9D9D9),
    this.textColor = Colors.black,
    this.hintColor = const Color(0xff858585),
    this.borderRadius = 10.0,
    this.initialObscureText = true,
  });

  @override
  State<ResponsivePasswordField> createState() => _ResponsivePasswordFieldState();
}

class _ResponsivePasswordFieldState extends State<ResponsivePasswordField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.initialObscureText;
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          obscureText: _obscureText,
          enabled: widget.enabled,
          style: TextStyle(
            fontSize: responsive.fontSize(16),
            color: widget.textColor,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: rFonts.style18weight400.copyWith(
              color: widget.hintColor,
            ),
            filled: true,
            fillColor: widget.fillColor.withAlpha(77), // 30% opacity
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: widget.hasError ? Colors.red : Colors.transparent,
                width: widget.hasError ? 1.0 : 0,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: responsive.getResponsiveSize(16),
              vertical: responsive.getResponsiveSize(12),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xff0B8FAC),
                size: responsive.getResponsiveSize(22),
              ),
              onPressed: _toggleVisibility,
            ),
          ),
        ),
        if (widget.hasError && widget.errorText != null)
          Padding(
            padding: EdgeInsets.only(
              top: responsive.getResponsiveSize(5),
              left: responsive.getResponsiveSize(5),
            ),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                color: Colors.red,
                fontSize: responsive.fontSize(12),
              ),
            ),
          ),
      ],
    );
  }
}
