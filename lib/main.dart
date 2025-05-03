import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical/Features/AuthCheck/auth_check_screen.dart';
import 'package:medical/Features/BooksView/books_view_api_redesigned.dart';
import 'package:medical/Features/ForgetPasswordView/forget_password_view_enhanced.dart';
import 'package:medical/Features/HomeView/home_view_refactored.dart';
import 'package:medical/Features/LoginView/login_view_refactored.dart';
import 'package:medical/Features/SignupView/signup_view_refactored.dart';
import 'package:medical/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations for better responsive behavior
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Medica());
}

class Medica extends StatelessWidget {
  const Medica({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medica',
      theme: ThemeData(
        primaryColor: const Color(0xff0B8FAC),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff0B8FAC)),
        useMaterial3: true,
        // Make text scaling more predictable
        textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.0),
      ),
      builder: (context, child) {
        // Apply a maximum text scaling factor to prevent extremely large text
        final mediaQuery = MediaQuery.of(context);
        final textScaler = mediaQuery.textScaler;

        // Create a constrained text scaler
        final constrainedTextScaler = TextScaler.linear(
          textScaler.scale(1.0).clamp(0.8, 1.3),
        );

        return MediaQuery(
          data: mediaQuery.copyWith(textScaler: constrainedTextScaler),
          child: child!,
        );
      },
      home:
          const AuthCheckScreen(), // Check auth state and redirect accordingly
      routes: {
        '/signup': (context) => const SignupViewRefactored(),
        '/login': (context) => const LoginView(),
        '/home': (context) => const HomeViewRefactored(),
        '/books': (context) => const BooksViewApiRedesigned(),
        '/forgot-password': (context) => const ForgetPasswordViewEnhanced(),
      },
    );
  }
}
