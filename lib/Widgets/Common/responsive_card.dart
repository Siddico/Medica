import 'package:flutter/material.dart';
import 'package:medical/Constants/responsive_utils.dart';

/// A responsive card that adapts to different screen sizes
class ResponsiveCard extends StatelessWidget {
  /// The child widget to display inside the card
  final Widget child;
  
  /// The padding inside the card (will be adjusted for responsiveness)
  final double padding;
  
  /// The border radius of the card
  final double borderRadius;
  
  /// The background color of the card
  final Color backgroundColor;
  
  /// The elevation of the card
  final double elevation;
  
  /// The margin around the card
  final EdgeInsetsGeometry? margin;
  
  const ResponsiveCard({
    super.key,
    required this.child,
    this.padding = 16.0,
    this.borderRadius = 12.0,
    this.backgroundColor = Colors.white,
    this.elevation = 1.0,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(responsive.getResponsiveSize(padding)),
      child: child,
    );
  }
}
