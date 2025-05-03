import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/LoginView/login_view_refactored.dart';
// import 'package:medical/Features/LoginView/login_view_responsive.dart';
import 'package:medical/Features/SignupView/bloc/bloc.dart';
import 'package:medical/Widgets/Common/responsive_wrapper.dart';
import 'package:medical/Widgets/Signup/signup_form.dart';

class SignupViewRefactored extends StatelessWidget {
  const SignupViewRefactored({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;

    return BlocProvider(
      create: (context) => SignupCubit(),
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
                        'Sign Up',
                        style: rFonts.style26weight700.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    responsive.verticalSpace(10),
                    Center(
                      child: Text(
                        'Create an account to continue',
                        textAlign: TextAlign.center,
                        style: rFonts.style18weight400,
                      ),
                    ),
                    responsive.verticalSpace(30),

                    // Signup form
                    SignupForm(
                      onNavigateToLogin: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                          (route) => false,
                        );
                      },
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
