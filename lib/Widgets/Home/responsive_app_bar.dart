import 'package:flutter/material.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/AuthCheck/auth_check_screen.dart';
import 'package:medical/Utils/session_manager.dart';

/// A responsive app bar that adapts to different screen sizes
class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The height of the app bar (will be adjusted for responsiveness)
  final double height;
  
  const ResponsiveAppBar({
    super.key,
    this.height = 60.0,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final iconSize = responsive.getResponsiveSize(24);
    final avatarRadius = responsive.getResponsiveSize(22);
    
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: responsive.getResponsiveSize(height),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu, color: Colors.black, size: iconSize),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_none,
            color: Colors.black,
            size: iconSize,
          ),
        ),
        // Add logout button
        IconButton(
          onPressed: () => _showLogoutDialog(context, responsive),
          icon: Icon(
            Icons.logout,
            color: Colors.red.shade300,
            size: iconSize,
          ),
          tooltip: 'Logout',
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(right: responsive.getResponsiveSize(12)),
          child: CircleAvatar(
            radius: avatarRadius,
            backgroundImage: const AssetImage(Imagestyles.DoctorsLogo),
          ),
        ),
      ],
    );
  }
  
  // Show logout confirmation dialog
  void _showLogoutDialog(BuildContext context, ResponsiveUtils responsive) {
    final dialogTitleStyle = TextStyle(
      fontSize: responsive.fontSize(18),
      fontWeight: FontWeight.bold,
    );
    
    final dialogContentStyle = TextStyle(
      fontSize: responsive.fontSize(16),
    );
    
    final buttonTextStyle = TextStyle(
      fontSize: responsive.fontSize(16),
      fontWeight: FontWeight.bold,
    );
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout', style: dialogTitleStyle),
        content: Text(
          'Are you sure you want to logout?',
          style: dialogContentStyle,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: buttonTextStyle.copyWith(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () async {
              // Close the dialog
              Navigator.pop(context);
              
              // Clear user login state
              await SessionManager.clearUserLoginState();
              
              // Navigate to auth check screen
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const AuthCheckScreen()),
                  (route) => false,
                );
              }
            },
            child: Text(
              'Logout',
              style: buttonTextStyle.copyWith(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(height);
}
