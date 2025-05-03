import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical/Constants/constants.dart';
import 'package:medical/Constants/fontStyles.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/ForgetPasswordView/bloc/password_reset_cubit.dart';
import 'package:medical/Features/ForgetPasswordView/bloc/password_reset_state.dart';
import 'package:medical/Features/ForgetPasswordView/verify_code_password_responsive.dart';
import 'package:medical/Services/auth_service.dart';
import 'package:medical/Utils/toast_utils.dart';

class ForgetPasswordViewResponsive extends StatefulWidget {
  const ForgetPasswordViewResponsive({super.key});

  @override
  State<ForgetPasswordViewResponsive> createState() =>
      _ForgetPasswordViewResponsiveState();
}

class _ForgetPasswordViewResponsiveState
    extends State<ForgetPasswordViewResponsive> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isEmailValid = true;
  String _emailErrorText = '';

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Validate email format
  bool _validateEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }

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

    // Layout adjustments for landscape mode
    if (isLandscape) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Row(
            children: [
              // Left side with image
              Expanded(
                flex: 4,
                child: Center(
                  child: Image.asset(
                    Imagestyles.forgetPasswordImage,
                    width: responsive.getResponsiveSize(300),
                    height: responsive.getResponsiveSize(300),
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Right side with form
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: verticalSpacing),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(
                          Imagestyles.goBack,
                          width: responsive.getResponsiveSize(24),
                          height: responsive.getResponsiveSize(24),
                        ),
                      ),
                      SizedBox(height: verticalSpacing),
                      Center(
                        child: Text(
                          'Forgot Password',
                          style: rFonts.style26weight700,
                        ),
                      ),
                      SizedBox(height: verticalSpacing / 2),
                      Center(
                        child: Text(
                          'Please enter your email address to receive a verification code',
                          textAlign: TextAlign.center,
                          style: rFonts.style18weight400,
                        ),
                      ),
                      SizedBox(height: verticalSpacing * 1.5),
                      Text('Email', style: rFonts.style22weight600),
                      SizedBox(height: verticalSpacing / 2),
                      _buildTextField(
                        controller: emailController,
                        hintText: 'Enter Your Email',
                        keyboardType: TextInputType.emailAddress,
                        responsive: responsive,
                        rFonts: rFonts,
                      ),
                      SizedBox(height: verticalSpacing * 1.5),
                      SizedBox(
                        width: double.infinity,
                        height: buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {
                            NavigateTo(
                              context,
                              const VerifyCodePasswordResponsive(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff0B8FAC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Send Code',
                            style: rFonts.style22weight700,
                          ),
                        ),
                      ),
                      SizedBox(height: verticalSpacing),
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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: verticalSpacing),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    Imagestyles.goBack,
                    width: responsive.getResponsiveSize(24),
                    height: responsive.getResponsiveSize(24),
                  ),
                ),
                SizedBox(height: verticalSpacing),
                Center(
                  child: Text(
                    'Forgot Password',
                    style: rFonts.style26weight700,
                  ),
                ),
                SizedBox(height: verticalSpacing / 2),
                Center(
                  child: Text(
                    'Please enter your email address to receive a verification code',
                    textAlign: TextAlign.center,
                    style: rFonts.style18weight400,
                  ),
                ),
                SizedBox(height: verticalSpacing),
                Center(
                  child: Image.asset(
                    Imagestyles.forgetPasswordImage,
                    width: responsive.getResponsiveSize(250),
                    height: responsive.getResponsiveSize(250),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: verticalSpacing),
                Text('Email', style: rFonts.style22weight600),
                SizedBox(height: verticalSpacing / 2),
                _buildTextField(
                  controller: emailController,
                  hintText: 'Enter Your Email',
                  keyboardType: TextInputType.emailAddress,
                  responsive: responsive,
                  rFonts: rFonts,
                ),
                SizedBox(height: verticalSpacing * 1.5),
                SizedBox(
                  width: double.infinity,
                  height: buttonHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      NavigateTo(context, const VerifyCodePasswordResponsive());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0B8FAC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Send Code', style: rFonts.style22weight700),
                  ),
                ),
                SizedBox(height: verticalSpacing),
              ],
            ),
          ),
        ),
      );
    }
  }

  // Helper method to build text fields with consistent styling
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required ResponsiveUtils responsive,
    required ResponsiveFontStyles rFonts,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: rFonts.style18weight400.copyWith(
          color: const Color(0xff858585),
        ),
        filled: true,
        fillColor: const Color(0xffD9D9D9).withAlpha(77), // 30% opacity
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: responsive.getResponsiveSize(16),
          vertical: responsive.getResponsiveSize(12),
        ),
      ),
      style: TextStyle(fontSize: responsive.fontSize(16)),
    );
  }
}
