import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical/Constants/constants.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/ForgetPasswordView/bloc/password_reset_cubit.dart';
import 'package:medical/Features/ForgetPasswordView/bloc/password_reset_state.dart';
import 'package:medical/Services/auth_service.dart';
import 'package:medical/Utils/toast_utils.dart';

class ForgetPasswordViewEnhanced extends StatefulWidget {
  const ForgetPasswordViewEnhanced({super.key});

  @override
  State<ForgetPasswordViewEnhanced> createState() =>
      _ForgetPasswordViewEnhancedState();
}

class _ForgetPasswordViewEnhancedState
    extends State<ForgetPasswordViewEnhanced> {
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

    // Create the password reset cubit
    return BlocProvider(
      create: (context) => PasswordResetCubit(AuthService()),
      child: BlocConsumer<PasswordResetCubit, PasswordResetState>(
        listener: (context, state) {
          if (state is PasswordResetFailure) {
            ToastUtils.showErrorToast(context, state.error);
          } else if (state is EmailSent) {
            ToastUtils.showSuccessToast(
              context,
              'Password reset link sent to ${state.email}',
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<PasswordResetCubit>();

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
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                        ),
                        child: Form(
                          key: _formKey,
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
                                controller: _emailController,
                                hintText: 'Enter Your Email',
                                keyboardType: TextInputType.emailAddress,
                                responsive: responsive,
                                rFonts: rFonts,
                                onChanged: (value) {
                                  setState(() {
                                    _isEmailValid = _validateEmail(value);
                                    _emailErrorText =
                                        _isEmailValid
                                            ? ''
                                            : 'Please enter a valid email';
                                  });
                                },
                                errorText: _emailErrorText,
                              ),
                              SizedBox(height: verticalSpacing * 1.5),
                              SizedBox(
                                width: double.infinity,
                                height: buttonHeight,
                                child: ElevatedButton(
                                  onPressed:
                                      state is PasswordResetLoading
                                          ? null
                                          : () {
                                            if (_emailController.text.isEmpty) {
                                              setState(() {
                                                _isEmailValid = false;
                                                _emailErrorText =
                                                    'Email is required';
                                              });
                                              return;
                                            }

                                            if (!_validateEmail(
                                              _emailController.text,
                                            )) {
                                              setState(() {
                                                _isEmailValid = false;
                                                _emailErrorText =
                                                    'Please enter a valid email';
                                              });
                                              return;
                                            }

                                            cubit.sendPasswordResetEmail(
                                              _emailController.text,
                                            );
                                          },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff0B8FAC),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    disabledBackgroundColor: Colors.grey,
                                  ),
                                  child:
                                      state is PasswordResetLoading
                                          ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                          : Text(
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
                  child: Form(
                    key: _formKey,
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
                          controller: _emailController,
                          hintText: 'Enter Your Email',
                          keyboardType: TextInputType.emailAddress,
                          responsive: responsive,
                          rFonts: rFonts,
                          onChanged: (value) {
                            setState(() {
                              _isEmailValid = _validateEmail(value);
                              _emailErrorText =
                                  _isEmailValid
                                      ? ''
                                      : 'Please enter a valid email';
                            });
                          },
                          errorText: _emailErrorText,
                        ),
                        SizedBox(height: verticalSpacing * 1.5),
                        SizedBox(
                          width: double.infinity,
                          height: buttonHeight,
                          child: ElevatedButton(
                            onPressed:
                                state is PasswordResetLoading
                                    ? null
                                    : () {
                                      if (_emailController.text.isEmpty) {
                                        setState(() {
                                          _isEmailValid = false;
                                          _emailErrorText = 'Email is required';
                                        });
                                        return;
                                      }

                                      if (!_validateEmail(
                                        _emailController.text,
                                      )) {
                                        setState(() {
                                          _isEmailValid = false;
                                          _emailErrorText =
                                              'Please enter a valid email';
                                        });
                                        return;
                                      }

                                      cubit.sendPasswordResetEmail(
                                        _emailController.text,
                                      );
                                    },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff0B8FAC),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              disabledBackgroundColor: Colors.grey,
                            ),
                            child:
                                state is PasswordResetLoading
                                    ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                    : Text(
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
              ),
            );
          }
        },
      ),
    );
  }

  // Helper method to build text fields with consistent styling
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required ResponsiveUtils responsive,
    required ResponsiveFontStyles rFonts,
    TextInputType keyboardType = TextInputType.text,
    Function(String)? onChanged,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
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
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color:
                    errorText != null && errorText.isNotEmpty
                        ? Colors.red
                        : Colors.transparent,
                width: errorText != null && errorText.isNotEmpty ? 1.0 : 0,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: responsive.getResponsiveSize(16),
              vertical: responsive.getResponsiveSize(12),
            ),
          ),
          style: TextStyle(fontSize: responsive.fontSize(16)),
        ),
        if (errorText != null && errorText.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(
              top: responsive.getResponsiveSize(5),
              left: 5,
            ),
            child: Text(
              errorText,
              style: TextStyle(
                color: Colors.red,
                fontSize: responsive.fontSize(12),
              ),
            ),
          ),
      ],
    );
  }
}
