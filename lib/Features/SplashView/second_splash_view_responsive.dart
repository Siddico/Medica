import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical/Constants/fontStyles.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/OnboardingView/onboarding_view_responsive.dart';
import 'package:medical/Features/personsView/persons_view_responsive.dart';
import 'package:medical/Utils/session_manager.dart';

class SecondSplashView extends StatefulWidget {
  const SecondSplashView({super.key});

  @override
  State<SecondSplashView> createState() => _SecondSplashViewState();
}

class _SecondSplashViewState extends State<SecondSplashView>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _text1Controller;
  late AnimationController _text2Controller;

  @override
  void initState() {
    super.initState();

    // Controllers for staggered animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _text1Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _text2Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    // Start animations in order
    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) _text1Controller.forward();
    });
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) _text2Controller.forward();
    });

    // Navigate to next screen after all animations finish
    Future.delayed(const Duration(seconds: 2), () {
      _checkOnboardingStatus();
    });
  }

  /// Check if onboarding has been completed and navigate accordingly
  Future<void> _checkOnboardingStatus() async {
    if (!mounted) return;

    final bool onboardingCompleted =
        await SessionManager.isOnboardingCompleted();

    if (mounted) {
      if (onboardingCompleted) {
        // If onboarding is completed, go directly to the persons view
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const PersonsViewResponsive()),
        );
      } else {
        // If onboarding is not completed, show the onboarding screens
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingViewResponsive()),
        );
      }
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _text1Controller.dispose();
    _text2Controller.dispose();
    super.dispose();
  }

  Widget buildAnimatedItem(AnimationController controller, Widget child) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Opacity(
          opacity: controller.value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - controller.value)),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;

    // Calculate responsive logo size
    final logoSize = responsive.getResponsiveSize(150);
    final spacingBetweenItems = responsive.getResponsiveSize(15);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildAnimatedItem(
              _logoController,
              SvgPicture.asset(
                Imagestyles.MedinovaLogoWhite,
                width: logoSize,
                height: logoSize,
              ),
            ),
            SizedBox(height: spacingBetweenItems),
            buildAnimatedItem(
              _text1Controller,
              Text(
                'University',
                style: rFonts.style70weight600,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: responsive.getResponsiveSize(5)),
            buildAnimatedItem(
              _text2Controller,
              Text(
                'Care',
                style: rFonts.style70weight600,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
