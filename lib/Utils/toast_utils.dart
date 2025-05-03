import 'package:flutter/material.dart';

class ToastUtils {
  static void showSuccessToast(BuildContext context, String message) {
    _showToast(
      context,
      message,
      const Color(0xFF4CAF50), // Green
      Icons.check_circle,
    );
  }

  static void showErrorToast(BuildContext context, String message) {
    _showToast(
      context,
      message,
      const Color(0xFFF44336), // Red
      Icons.error,
    );
  }

  static void showInfoToast(BuildContext context, String message) {
    _showToast(
      context,
      message,
      const Color(0xFF2196F3), // Blue
      Icons.info,
    );
  }

  static void showWarningToast(BuildContext context, String message) {
    _showToast(
      context,
      message,
      const Color(0xFFFF9800), // Orange
      Icons.warning,
    );
  }

  static void _showToast(
    BuildContext context,
    String message,
    Color backgroundColor,
    IconData icon,
  ) {
    final scaffold = ScaffoldMessenger.of(context);
    final mediaQuery = MediaQuery.of(context);
    
    // Calculate responsive padding
    final horizontalPadding = mediaQuery.size.width * 0.04;
    final verticalPadding = mediaQuery.size.height * 0.01;
    
    // Calculate responsive font size
    final fontSize = mediaQuery.size.width * 0.04;
    
    // Calculate responsive icon size
    final iconSize = mediaQuery.size.width * 0.06;
    
    scaffold.clearSnackBars();
    scaffold.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: iconSize,
            ),
            SizedBox(width: horizontalPadding),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: horizontalPadding * 2,
          vertical: verticalPadding * 2,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding * 1.5,
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
