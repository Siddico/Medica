import 'package:flutter/material.dart';
import 'package:medical/Constants/responsive_utils.dart';

/// A social login button that adapts to different screen sizes
class SocialLoginButton extends StatelessWidget {
  /// The image path for the social login icon
  final String imagePath;
  
  /// The function to call when the button is pressed
  final VoidCallback? onPressed;
  
  /// The size of the button (will be adjusted for responsiveness)
  final double size;
  
  /// The padding inside the button (will be adjusted for responsiveness)
  final double padding;
  
  /// The border color of the button
  final Color borderColor;
  
  const SocialLoginButton({
    super.key,
    required this.imagePath,
    this.onPressed,
    this.size = 50.0,
    this.padding = 8.0,
    this.borderColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: responsive.getResponsiveSize(size),
        height: responsive.getResponsiveSize(size),
        padding: EdgeInsets.all(responsive.getResponsiveSize(padding)),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor.withOpacity(0.3)),
        ),
        child: Image.asset(imagePath, fit: BoxFit.fill),
      ),
    );
  }
}
