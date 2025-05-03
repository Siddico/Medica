import 'package:flutter/material.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';

/// A responsive button that adapts to different screen sizes
class ResponsiveButton extends StatelessWidget {
  /// The text to display on the button
  final String text;
  
  /// The function to call when the button is pressed
  final VoidCallback onPressed;
  
  /// Whether the button is in a loading state
  final bool isLoading;
  
  /// The background color of the button
  final Color backgroundColor;
  
  /// The text color of the button
  final Color textColor;
  
  /// The height of the button (will be adjusted for responsiveness)
  final double height;
  
  /// The border radius of the button
  final double borderRadius;
  
  const ResponsiveButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor = const Color(0xff0B8FAC),
    this.textColor = Colors.white,
    this.height = 50.0,
    this.borderRadius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;
    
    // Calculate responsive height
    final buttonHeight = responsive.getResponsiveSize(height);
    
    return SizedBox(
      width: double.infinity,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.symmetric(
            vertical: responsive.getResponsiveSize(12),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: responsive.getResponsiveSize(24),
                height: responsive.getResponsiveSize(24),
                child: CircularProgressIndicator(color: textColor),
              )
            : Text(
                text,
                style: rFonts.style22weight700.copyWith(
                  color: textColor,
                ),
              ),
      ),
    );
  }
}
