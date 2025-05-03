import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/SplashView/second_splash_view_responsive.dart';

class FirstSplashView extends StatefulWidget {
  const FirstSplashView({Key? key}) : super(key: key);

  @override
  State<FirstSplashView> createState() => _FirstSplashViewState();
}

class _FirstSplashViewState extends State<FirstSplashView>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  late AnimationController _rotateController;
  late Animation<double> _rotateAnimation;

  bool showRotating = false;
  bool showFinal = false;

  @override
  void initState() {
    super.initState();

    // Scale animation
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _scaleAnimation = Tween<double>(
      begin: 56.0,
      end: 135.0,
    ).animate(CurvedAnimation(parent: _scaleController, curve: Curves.easeOut));

    _scaleController.forward();

    _scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // After scaling, start rotation
        setState(() {
          showRotating = true;
        });
        _startRotation();
      }
    });
  }

  void _startRotation() {
    // Rotation animation
    _rotateController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _rotateAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0,
          end: pi / 2,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: pi / 2,
          end: pi,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: pi,
          end: (4 * pi) / 2.666,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
    ]).animate(_rotateController);

    _rotateController.forward();

    _rotateController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showFinal = true;
        });

        // Delay before navigation
        Future.delayed(const Duration(milliseconds: 150), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SecondSplashView()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    
    // Calculate responsive logo size
    final baseLogoSize = 135.0;
    final logoSize = responsive.getResponsiveSize(baseLogoSize);
    
    // Calculate responsive animation values
    final startSize = responsive.getResponsiveSize(56.0);
    final endSize = logoSize;
    
    // Update animation if screen size changes
    if (_scaleAnimation.value == 135.0 && endSize != 135.0) {
      _scaleAnimation = Tween<double>(
        begin: startSize,
        end: endSize,
      ).animate(CurvedAnimation(parent: _scaleController, curve: Curves.easeOut));
    }
    
    return Scaffold(
      backgroundColor: const Color(0xff0B8FAC),
      body: Center(
        child: showFinal
            ? AnimatedScale(
                scale: 1.0,
                duration: const Duration(milliseconds: 150),
                child: SvgPicture.asset(
                  Imagestyles.MedinovaLogoWhite,
                  height: logoSize,
                  width: logoSize,
                ),
              )
            : showRotating
                ? AnimatedBuilder(
                    animation: _rotateAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotateAnimation.value,
                        child: child,
                      );
                    },
                    child: SvgPicture.asset(
                      Imagestyles.MedinovaLogo,
                      height: logoSize,
                      width: logoSize,
                    ),
                  )
                : AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      // Use responsive scaling
                      final currentSize = startSize + (_scaleAnimation.value - 56.0) * (endSize - startSize) / (135.0 - 56.0);
                      return SvgPicture.asset(
                        Imagestyles.MedinovaLogo,
                        height: currentSize,
                        width: currentSize,
                      );
                    },
                  ),
      ),
    );
  }
}
