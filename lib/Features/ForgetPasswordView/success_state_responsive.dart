import 'package:flutter/material.dart';
import 'package:medical/Constants/fontStyles.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/LoginView/login_view_refactored.dart';
// import 'package:medical/Features/LoginView/login_view_responsive.dart';

class SuccessStateResponsive extends StatelessWidget {
  const SuccessStateResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;

    // Determine if we're in landscape mode
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // Responsive spacing
    final verticalSpacing = responsive.getResponsiveSize(20);
    final horizontalPadding = responsive.getResponsiveSize(24);
    final buttonHeight = responsive.getResponsiveSize(50);
    final imageSize = responsive.getResponsiveSize(200);

    // Layout adjustments for landscape mode
    if (isLandscape) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Row(
            children: [
              // Left side with image
              Expanded(
                flex: 5,
                child: Center(
                  child: Image.asset(
                    Imagestyles.successState,
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Right side with content and button
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Password Reset Successfully',
                        style: rFonts.style26weight700,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: verticalSpacing),
                      Text(
                        'Your password has been reset successfully. You can now login with your new password.',
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
                          child: Text(
                            'Back to Login',
                            style: rFonts.style22weight700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Portrait layout
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Imagestyles.successState,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: verticalSpacing * 1.5),
                Text(
                  'Password Reset Successfully',
                  style: rFonts.style26weight700,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: verticalSpacing),
                Text(
                  'Your password has been reset successfully. You can now login with your new password.',
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
                    child: Text(
                      'Back to Login',
                      style: rFonts.style22weight700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
