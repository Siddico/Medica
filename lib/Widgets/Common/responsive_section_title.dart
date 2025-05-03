import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/Constants/responsive_utils.dart';

/// A responsive section title that adapts to different screen sizes
class ResponsiveSectionTitle extends StatelessWidget {
  /// The title text to display
  final String title;
  
  /// An optional action widget to display on the right side
  final Widget? action;
  
  /// The text color of the title
  final Color titleColor;
  
  /// The text color of the action text (if action is null)
  final Color actionColor;
  
  /// The font weight of the title
  final FontWeight fontWeight;
  
  /// The font size of the title (will be adjusted for responsiveness)
  final double fontSize;
  
  const ResponsiveSectionTitle({
    super.key,
    required this.title,
    this.action,
    this.titleColor = const Color(0xff333333),
    this.actionColor = const Color(0xff858585),
    this.fontWeight = FontWeight.w600,
    this.fontSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    
    final titleStyle = GoogleFonts.openSans(
      fontSize: responsive.fontSize(fontSize),
      fontWeight: fontWeight,
      color: titleColor,
    );
    
    final actionStyle = GoogleFonts.openSans(
      fontSize: responsive.fontSize(fontSize),
      color: actionColor,
    );
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: titleStyle),
        action ?? Text('See All', style: actionStyle),
      ],
    );
  }
}
