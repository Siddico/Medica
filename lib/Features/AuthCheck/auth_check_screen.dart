import 'package:flutter/material.dart';
import 'package:medical/Features/HomeView/home_view_refactored.dart';
import 'package:medical/Features/SplashView/first_splash_view_responsive.dart';
import 'package:medical/Utils/session_manager.dart';

/// A screen that checks if the user is logged in and redirects accordingly
class AuthCheckScreen extends StatefulWidget {
  const AuthCheckScreen({super.key});

  @override
  State<AuthCheckScreen> createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  /// Check if the user is logged in and navigate accordingly
  Future<void> _checkAuthState() async {
    // Add a small delay to ensure splash screen is visible
    await Future.delayed(const Duration(milliseconds: 100));

    if (!mounted) return;

    // If user is logged in, go to home screen, otherwise go to splash screen
    final bool isLoggedIn = await SessionManager.isUserLoggedIn();

    if (!mounted) return;

    if (isLoggedIn) {
      // User is logged in, navigate to home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeViewRefactored()),
      );
    } else {
      // User is not logged in, navigate to splash screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const FirstSplashView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // This is just a loading screen while we check auth state
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
