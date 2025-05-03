import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/LoginView/auth.dart';
import 'package:medical/Features/LoginView/bloc/bloc.dart';
import 'package:medical/Features/SignupView/signup_view_refactored.dart';
import 'package:medical/Widgets/Common/responsive_wrapper.dart';
import 'package:medical/Widgets/Login/login_form.dart';
import 'package:medical/Widgets/Login/social_login_section.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;

    // Determine if we're in landscape mode
    // ignore: unused_local_variable
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return BlocProvider(
      create: (context) => LoginCubit(authRepository: AuthRepository()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: ResponsiveStack(
              mainContent: Padding(
                padding: responsive.getPadding(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                        Imagestyles.goBack,
                        width: responsive.getResponsiveSize(24),
                        height: responsive.getResponsiveSize(24),
                      ),
                    ),
                    responsive.verticalSpace(10),

                    // Header
                    Center(
                      child: Text('Welcome', style: rFonts.style26weight700),
                    ),
                    responsive.verticalSpace(20),
                    Center(
                      child: Text(
                        'Log In',
                        style: rFonts.style26weight700.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    responsive.verticalSpace(10),
                    Center(
                      child: Text(
                        'Hello Doctor Please Enter Your Correct Data',
                        textAlign: TextAlign.center,
                        style: rFonts.style18weight400,
                      ),
                    ),
                    responsive.verticalSpace(30),

                    // Login form
                    const LoginForm(),

                    responsive.verticalSpace(30),

                    // Social login section
                    const SocialLoginSection(),

                    responsive.verticalSpace(30),

                    // Sign up link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: rFonts.style16weight700,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => const SignupViewRefactored(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: rFonts.style16weight700.copyWith(
                              color: const Color(0xff0B8FAC),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Add extra space at the bottom to ensure the background image doesn't overlap content
                    responsive.verticalSpace(responsive.isTablet ? 100 : 50),
                  ],
                ),
              ),
              backgroundElements: [
                ResponsivePositionedItem(
                  bottom: 0,
                  left: 0,
                  child: Image.asset(
                    Imagestyles.backGroundOfLoginView,
                    width: responsive.responsiveValue(
                      mobile: responsive.widthPercent(60),
                      tablet: responsive.widthPercent(40),
                    ),
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
