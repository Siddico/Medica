import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical/Constants/fontStyles.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Features/OnboardingView/onboardingView.dart';

class Secondsplashview extends StatefulWidget {
  const Secondsplashview({super.key});

  @override
  State<Secondsplashview> createState() => _SecondsplashviewState();
}

class _SecondsplashviewState extends State<Secondsplashview>
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
      _text1Controller.forward();
    });
    Future.delayed(const Duration(milliseconds: 1400), () {
      _text2Controller.forward();
    });

    // Navigate to next screen after all animations finish
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnboardingView()),
      );
    });
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildAnimatedItem(
              _logoController,
              SvgPicture.asset(Imagestyles.MedinovaLogoWhite),
            ),
            const SizedBox(height: 15),
            buildAnimatedItem(
              _text1Controller,
              Text('University', style: FontStyles.style70weight600),
            ),
            const SizedBox(height: 5),
            buildAnimatedItem(
              _text2Controller,
              Text('Care', style: FontStyles.style70weight600),
            ),
          ],
        ),
      ),
    );
  }
}
