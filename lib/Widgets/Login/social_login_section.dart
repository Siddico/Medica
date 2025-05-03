import 'package:flutter/material.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Widgets/Login/social_login_button.dart';

/// A responsive social login section that adapts to different screen sizes
class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;
    
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider(thickness: 2)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.getResponsiveSize(8),
              ),
              child: Text(
                'OR',
                style: rFonts.style22weight700.copyWith(
                  color: const Color(0xff858585),
                ),
              ),
            ),
            const Expanded(child: Divider(thickness: 2)),
          ],
        ),
        SizedBox(height: responsive.getResponsiveSize(30)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialLoginButton(
              imagePath: Imagestyles.appleLogo,
              onPressed: () {
                // Handle Apple login
              },
            ),
            SizedBox(width: responsive.getResponsiveSize(16)),
            SocialLoginButton(
              imagePath: Imagestyles.googleLogo,
              onPressed: () {
                // Handle Google login
              },
            ),
            SizedBox(width: responsive.getResponsiveSize(16)),
            SocialLoginButton(
              imagePath: Imagestyles.facebookLogo,
              onPressed: () {
                // Handle Facebook login
              },
            ),
          ],
        ),
      ],
    );
  }
}
