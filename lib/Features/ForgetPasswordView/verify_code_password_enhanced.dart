import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/ForgetPasswordView/bloc/password_reset_cubit.dart';
import 'package:medical/Features/ForgetPasswordView/bloc/password_reset_state.dart';
import 'package:medical/Features/ForgetPasswordView/reset_password_enhanced.dart';
import 'package:medical/Services/auth_service.dart';
import 'package:medical/Utils/toast_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCodePasswordEnhanced extends StatefulWidget {
  final String email;
  
  const VerifyCodePasswordEnhanced({required this.email, super.key});

  @override
  State<VerifyCodePasswordEnhanced> createState() => _VerifyCodePasswordEnhancedState();
}

class _VerifyCodePasswordEnhancedState extends State<VerifyCodePasswordEnhanced> {
  final TextEditingController _pinController = TextEditingController();
  bool _isResendEnabled = false;
  int _resendCountdown = 60;
  Timer? _resendTimer;
  
  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }
  
  void _startResendTimer() {
    setState(() {
      _isResendEnabled = false;
      _resendCountdown = 60;
    });
    
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          _isResendEnabled = true;
          timer.cancel();
        }
      });
    });
  }
  
  @override
  void dispose() {
    _pinController.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;
    
    // Determine if we're in landscape mode
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    
    // Responsive spacing
    final verticalSpacing = responsive.getResponsiveSize(20);
    final horizontalPadding = responsive.getResponsiveSize(24);
    final buttonHeight = responsive.getResponsiveSize(50);
    
    return BlocProvider(
      create: (context) => PasswordResetCubit(AuthService()),
      child: BlocConsumer<PasswordResetCubit, PasswordResetState>(
        listener: (context, state) {
          if (state is PasswordResetFailure) {
            ToastUtils.showErrorToast(context, state.error);
          } else if (state is CodeVerified) {
            ToastUtils.showSuccessToast(context, 'Code verified successfully');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResetPasswordEnhanced(
                  email: widget.email,
                  code: state.code,
                ),
              ),
            );
          } else if (state is PasswordResetSuccess) {
            ToastUtils.showSuccessToast(context, state.message);
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
                    // Left side with back button and title
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: SvgPicture.asset(
                                Imagestyles.goBack,
                                width: responsive.getResponsiveSize(24),
                                height: responsive.getResponsiveSize(24),
                              ),
                            ),
                            SizedBox(height: verticalSpacing),
                            Text(
                              'Verification Code',
                              style: rFonts.style26weight700,
                            ),
                            SizedBox(height: verticalSpacing / 2),
                            Text(
                              'We have sent the verification code to ${widget.email}',
                              style: rFonts.style18weight400,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Right side with PIN code and button
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildPinCodeFields(
                              context,
                              responsive,
                              rFonts,
                            ),
                            SizedBox(height: verticalSpacing),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Didn\'t receive code? ',
                                  style: rFonts.style16weight700,
                                ),
                                GestureDetector(
                                  onTap: _isResendEnabled
                                      ? () {
                                          cubit.resendVerificationCode();
                                          _startResendTimer();
                                        }
                                      : null,
                                  child: Text(
                                    _isResendEnabled
                                        ? 'Resend'
                                        : 'Resend in $_resendCountdown s',
                                    style: rFonts.style16weight700.copyWith(
                                      color: _isResendEnabled
                                          ? const Color(0xff0B8FAC)
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: verticalSpacing),
                            SizedBox(
                              width: double.infinity,
                              height: buttonHeight,
                              child: ElevatedButton(
                                onPressed: state is PasswordResetLoading || _pinController.text.length < 4
                                    ? null
                                    : () {
                                        cubit.verifyCode(_pinController.text);
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff0B8FAC),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  disabledBackgroundColor: Colors.grey,
                                ),
                                child: state is PasswordResetLoading
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : Text(
                                        'Verify',
                                        style: rFonts.style22weight700,
                                      ),
                              ),
                            ),
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
                      Text(
                        'Verification Code',
                        style: rFonts.style26weight700,
                      ),
                      SizedBox(height: verticalSpacing / 2),
                      Text(
                        'We have sent the verification code to ${widget.email}',
                        style: rFonts.style18weight400,
                      ),
                      SizedBox(height: verticalSpacing * 2),
                      _buildPinCodeFields(
                        context,
                        responsive,
                        rFonts,
                      ),
                      SizedBox(height: verticalSpacing),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Didn\'t receive code? ',
                            style: rFonts.style16weight700,
                          ),
                          GestureDetector(
                            onTap: _isResendEnabled
                                ? () {
                                    cubit.resendVerificationCode();
                                    _startResendTimer();
                                  }
                                : null,
                            child: Text(
                              _isResendEnabled
                                  ? 'Resend'
                                  : 'Resend in $_resendCountdown s',
                              style: rFonts.style16weight700.copyWith(
                                color: _isResendEnabled
                                    ? const Color(0xff0B8FAC)
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: verticalSpacing * 2),
                      SizedBox(
                        width: double.infinity,
                        height: buttonHeight,
                        child: ElevatedButton(
                          onPressed: state is PasswordResetLoading || _pinController.text.length < 4
                              ? null
                              : () {
                                  cubit.verifyCode(_pinController.text);
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff0B8FAC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            disabledBackgroundColor: Colors.grey,
                          ),
                          child: state is PasswordResetLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  'Verify',
                                  style: rFonts.style22weight700,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
  
  // Helper method to build PIN code fields
  Widget _buildPinCodeFields(
    BuildContext context,
    ResponsiveUtils responsive,
    ResponsiveFontStyles rFonts,
  ) {
    // Adjust PIN field size based on screen size
    final fieldWidth = responsive.getResponsiveSize(50);
    final fieldHeight = responsive.getResponsiveSize(60);
    final fontSize = responsive.fontSize(20);
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive.getResponsiveSize(16)),
      child: PinCodeTextField(
        appContext: context,
        length: 4,
        controller: _pinController,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          fieldHeight: fieldHeight,
          fieldWidth: fieldWidth,
          activeFillColor: Colors.white,
          inactiveFillColor: const Color(0xffD9D9D9).withAlpha(77),
          selectedFillColor: Colors.white,
          activeColor: const Color(0xff0B8FAC),
          inactiveColor: Colors.grey.shade300,
          selectedColor: const Color(0xff0B8FAC),
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        keyboardType: TextInputType.number,
        textStyle: GoogleFonts.openSans(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }
}
