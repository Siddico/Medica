import 'package:flutter/material.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';

/// A responsive text field that adapts to different screen sizes
class ResponsiveTextField extends StatelessWidget {
  /// The controller for the text field
  final TextEditingController controller;
  
  /// The hint text to display when the field is empty
  final String hintText;
  
  /// The keyboard type to use for the text field
  final TextInputType keyboardType;
  
  /// Whether the text field has an error
  final bool hasError;
  
  /// The error text to display when hasError is true
  final String? errorText;
  
  /// Whether the text field is enabled
  final bool enabled;
  
  /// The background color of the text field
  final Color fillColor;
  
  /// The text color of the text field
  final Color textColor;
  
  /// The hint text color of the text field
  final Color hintColor;
  
  /// The border radius of the text field
  final double borderRadius;
  
  const ResponsiveTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.hasError = false,
    this.errorText,
    this.enabled = true,
    this.fillColor = const Color(0xffD9D9D9),
    this.textColor = Colors.black,
    this.hintColor = const Color(0xff858585),
    this.borderRadius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          enabled: enabled,
          style: TextStyle(
            fontSize: responsive.fontSize(16),
            color: textColor,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: rFonts.style18weight400.copyWith(
              color: hintColor,
            ),
            filled: true,
            fillColor: fillColor.withAlpha(77), // 30% opacity
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: hasError ? Colors.red : Colors.transparent,
                width: hasError ? 1.0 : 0,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: responsive.getResponsiveSize(16),
              vertical: responsive.getResponsiveSize(12),
            ),
          ),
        ),
        if (hasError && errorText != null)
          Padding(
            padding: EdgeInsets.only(
              top: responsive.getResponsiveSize(5),
              left: responsive.getResponsiveSize(5),
            ),
            child: Text(
              errorText!,
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
