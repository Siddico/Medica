import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/LoginView/login_view_refactored.dart';

class SuccessStateEnhanced extends StatefulWidget {
  const SuccessStateEnhanced({super.key});

  @override
  State<SuccessStateEnhanced> createState() => _SuccessStateEnhancedState();
}

class _SuccessStateEnhancedState extends State<SuccessStateEnhanced>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animationController.forward();

    // Auto-navigate to login screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
          (route) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;

    // Responsive spacing
    final verticalSpacing = responsive.getResponsiveSize(20);
    final buttonHeight = responsive.getResponsiveSize(50);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: responsive.getResponsiveSize(24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Success animation
                Lottie.asset(
                  'assets/animations/success_animation.json',
                  controller: _animationController,
                  width: responsive.getResponsiveSize(200),
                  height: responsive.getResponsiveSize(200),
                  fit: BoxFit.contain,
                  onLoaded: (composition) {
                    _animationController.duration = composition.duration;
                    _animationController.forward();
                  },
                ),
                SizedBox(height: verticalSpacing),
                Text(
                  'Password Reset Successful!',
                  style: rFonts.style26weight700,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: verticalSpacing / 2),
                Text(
                  'Your password has been reset successfully. You can now log in with your new password.',
                  style: rFonts.style18weight400,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: verticalSpacing * 2),
                SizedBox(
                  width: double.infinity,
                  height: buttonHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0B8FAC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Login Now', style: rFonts.style22weight700),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
