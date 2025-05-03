import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/ForgetPasswordView/bloc/password_reset_cubit.dart';
import 'package:medical/Features/ForgetPasswordView/bloc/password_reset_state.dart';
import 'package:medical/Features/ForgetPasswordView/success_state_enhanced.dart';
import 'package:medical/Services/auth_service.dart';
import 'package:medical/Utils/toast_utils.dart';

class ResetPasswordEnhanced extends StatefulWidget {
  final String email;
  final String code;
  
  const ResetPasswordEnhanced({
    required this.email,
    required this.code,
    super.key,
  });

  @override
  State<ResetPasswordEnhanced> createState() => _ResetPasswordEnhancedState();
}

class _ResetPasswordEnhancedState extends State<ResetPasswordEnhanced> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  
  String? _passwordError;
  String? _confirmPasswordError;
  
  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  
  // Validate password strength
  bool _validatePassword(String password) {
    if (password.length < 6) {
      setState(() {
        _passwordError = 'Password must be at least 6 characters';
      });
      return false;
    }
    
    setState(() {
      _passwordError = null;
    });
    return true;
  }
  
  // Validate password confirmation
  bool _validateConfirmPassword(String confirmPassword) {
    if (confirmPassword != _passwordController.text) {
      setState(() {
        _confirmPasswordError = 'Passwords do not match';
      });
      return false;
    }
    
    setState(() {
      _confirmPasswordError = null;
    });
    return true;
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
          } else if (state is PasswordChanged) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SuccessStateEnhanced(),
              ),
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
                              'Reset Password',
                              style: rFonts.style26weight700,
                            ),
                            SizedBox(height: verticalSpacing / 2),
                            Text(
                              'Create a new password for your account',
                              style: rFonts.style18weight400,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Right side with password fields and button
                    Expanded(
                      flex: 6,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: verticalSpacing * 2),
                              Text('New Password', style: rFonts.style22weight600),
                              SizedBox(height: verticalSpacing / 2),
                              _buildPasswordField(
                                controller: _passwordController,
                                hintText: 'Enter New Password',
                                isPasswordVisible: _isPasswordVisible,
                                togglePasswordVisibility: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                responsive: responsive,
                                rFonts: rFonts,
                                errorText: _passwordError,
                                onChanged: (value) {
                                  _validatePassword(value);
                                  if (_confirmPasswordController.text.isNotEmpty) {
                                    _validateConfirmPassword(_confirmPasswordController.text);
                                  }
                                },
                              ),
                              SizedBox(height: verticalSpacing),
                              Text('Confirm Password', style: rFonts.style22weight600),
                              SizedBox(height: verticalSpacing / 2),
                              _buildPasswordField(
                                controller: _confirmPasswordController,
                                hintText: 'Confirm New Password',
                                isPasswordVisible: _isConfirmPasswordVisible,
                                togglePasswordVisibility: () {
                                  setState(() {
                                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                  });
                                },
                                responsive: responsive,
                                rFonts: rFonts,
                                errorText: _confirmPasswordError,
                                onChanged: (value) {
                                  _validateConfirmPassword(value);
                                },
                              ),
                              SizedBox(height: verticalSpacing * 2),
                              SizedBox(
                                width: double.infinity,
                                height: buttonHeight,
                                child: ElevatedButton(
                                  onPressed: state is PasswordResetLoading
                                      ? null
                                      : () {
                                          final isPasswordValid = _validatePassword(_passwordController.text);
                                          final isConfirmPasswordValid = _validateConfirmPassword(_confirmPasswordController.text);
                                          
                                          if (isPasswordValid && isConfirmPasswordValid) {
                                            cubit.resetPassword(
                                              _passwordController.text,
                                              _confirmPasswordController.text,
                                            );
                                          }
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
                                          'Reset Password',
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
                        Text(
                          'Reset Password',
                          style: rFonts.style26weight700,
                        ),
                        SizedBox(height: verticalSpacing / 2),
                        Text(
                          'Create a new password for your account',
                          style: rFonts.style18weight400,
                        ),
                        SizedBox(height: verticalSpacing * 2),
                        Text('New Password', style: rFonts.style22weight600),
                        SizedBox(height: verticalSpacing / 2),
                        _buildPasswordField(
                          controller: _passwordController,
                          hintText: 'Enter New Password',
                          isPasswordVisible: _isPasswordVisible,
                          togglePasswordVisibility: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          responsive: responsive,
                          rFonts: rFonts,
                          errorText: _passwordError,
                          onChanged: (value) {
                            _validatePassword(value);
                            if (_confirmPasswordController.text.isNotEmpty) {
                              _validateConfirmPassword(_confirmPasswordController.text);
                            }
                          },
                        ),
                        SizedBox(height: verticalSpacing),
                        Text('Confirm Password', style: rFonts.style22weight600),
                        SizedBox(height: verticalSpacing / 2),
                        _buildPasswordField(
                          controller: _confirmPasswordController,
                          hintText: 'Confirm New Password',
                          isPasswordVisible: _isConfirmPasswordVisible,
                          togglePasswordVisibility: () {
                            setState(() {
                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                            });
                          },
                          responsive: responsive,
                          rFonts: rFonts,
                          errorText: _confirmPasswordError,
                          onChanged: (value) {
                            _validateConfirmPassword(value);
                          },
                        ),
                        SizedBox(height: verticalSpacing * 2),
                        SizedBox(
                          width: double.infinity,
                          height: buttonHeight,
                          child: ElevatedButton(
                            onPressed: state is PasswordResetLoading
                                ? null
                                : () {
                                    final isPasswordValid = _validatePassword(_passwordController.text);
                                    final isConfirmPasswordValid = _validateConfirmPassword(_confirmPasswordController.text);
                                    
                                    if (isPasswordValid && isConfirmPasswordValid) {
                                      cubit.resetPassword(
                                        _passwordController.text,
                                        _confirmPasswordController.text,
                                      );
                                    }
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
                                    'Reset Password',
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
  
  // Helper method to build password fields with consistent styling
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool isPasswordVisible,
    required VoidCallback togglePasswordVisibility,
    required ResponsiveUtils responsive,
    required ResponsiveFontStyles rFonts,
    String? errorText,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: !isPasswordVisible,
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
                color: errorText != null ? Colors.red : Colors.transparent,
                width: errorText != null ? 1.0 : 0,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: responsive.getResponsiveSize(16),
              vertical: responsive.getResponsiveSize(12),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xff858585),
              ),
              onPressed: togglePasswordVisibility,
            ),
          ),
          style: TextStyle(fontSize: responsive.fontSize(16)),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(top: responsive.getResponsiveSize(5), left: 5),
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
