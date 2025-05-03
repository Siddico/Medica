import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Features/SplashView/secondSplashView.dart';

class Firstsplashview extends StatefulWidget {
  const Firstsplashview({Key? key}) : super(key: key);

  @override
  State<Firstsplashview> createState() => _FirstsplashviewState();
}

class _FirstsplashviewState extends State<Firstsplashview>
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

    // 1️⃣ أنيميشن التكبير
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
        // بعد ما يكبر يبدأ الدوران
        setState(() {
          showRotating = true;
        });
        _startRotation();
      }
    });
  }

  void _startRotation() {
    // 2️⃣ أنيميشن الدوران
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

        // 3️⃣ تأخير بسيط ثم الانتقال
        Future.delayed(const Duration(milliseconds: 150), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const Secondsplashview()),
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
    return Scaffold(
      backgroundColor: const Color(0xff0B8FAC),
      body: Center(
        child:
            showFinal
                ? AnimatedScale(
                  scale: 1.0,
                  duration: const Duration(milliseconds: 150),
                  child: SvgPicture.asset(
                    Imagestyles
                        .MedinovaLogoWhite, // 👈 غيّر المسار للصورة الجديدة
                    height: 135,
                    width: 135,
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
                    height: 135,
                    width: 135,
                  ),
                )
                : AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return SvgPicture.asset(
                      Imagestyles.MedinovaLogo,
                      height: _scaleAnimation.value,
                      width: _scaleAnimation.value,
                    );
                  },
                ),
      ),
    );
  }
}
