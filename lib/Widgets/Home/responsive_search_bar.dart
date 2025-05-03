import 'package:flutter/material.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';

/// A responsive search bar that adapts to different screen sizes
class ResponsiveSearchBar extends StatelessWidget {
  /// The controller for the search field
  final TextEditingController? controller;

  /// The hint text to display when the field is empty
  final String hintText;

  /// Function to call when the search field changes
  final ValueChanged<String>? onChanged;

  /// Function to call when the search button is pressed
  final VoidCallback? onSearchPressed;

  /// Function to call when the voice button is pressed
  final VoidCallback? onVoicePressed;

  /// The height of the search bar (will be adjusted for responsiveness)
  final double height;

  const ResponsiveSearchBar({
    super.key,
    this.controller,
    this.hintText = 'Search a Doctor',
    this.onChanged,
    this.onSearchPressed,
    this.onVoicePressed,
    this.height = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    // ignore: unused_local_variable
    final rFonts = context.responsiveFontStyles;

    final height = responsive.getResponsiveSize(this.height);
    final iconSize = responsive.getResponsiveSize(20);
    final fontSize = responsive.fontSize(14);

    return Card(
      elevation: 10,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: responsive.getResponsiveSize(12),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: responsive.getResponsiveSize(12),
        ),
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: onSearchPressed,
              child: Icon(Icons.search, color: Colors.grey, size: iconSize),
            ),
            SizedBox(width: responsive.getResponsiveSize(8)),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: fontSize),
                ),
                style: TextStyle(fontSize: fontSize),
              ),
            ),
            GestureDetector(
              onTap: onVoicePressed,
              child: Icon(Icons.mic, color: Colors.grey, size: iconSize),
            ),
          ],
        ),
      ),
    );
  }
}
