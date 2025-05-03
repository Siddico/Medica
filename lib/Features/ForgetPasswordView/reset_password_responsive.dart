import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical/Constants/constants.dart';
import 'package:medical/Constants/fontStyles.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/ForgetPasswordView/success_state_responsive.dart';

class ResetPasswordResponsive extends StatefulWidget {
  const ResetPasswordResponsive({super.key});

  @override
  State<ResetPasswordResponsive> createState() => _ResetPasswordResponsiveState();
}

class _ResetPasswordResponsiveState extends State<ResetPasswordResponsive> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  
  // Validation state
  bool _passwordError = false;
  bool _confirmPasswordError = false;
  bool _passwordsMatch = true;
  
  // Validate fields
  bool _validateFields() {
    setState(() {
      _passwordError = _passwordController.text.isEmpty || _passwordController.text.length < 6;
      _confirmPasswordError = _confirmPasswordController.text.isEmpty;
      _passwordsMatch = _passwordController.text == _confirmPasswordController.text;
    });
    
    return !_passwordError && !_confirmPasswordError && _passwordsMatch;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('New Password', style: rFonts.style22weight600),
                      SizedBox(height: verticalSpacing / 2),
                      _buildPasswordField(
                        controller: _passwordController,
                        hintText: 'Enter New Password',
                        obscureText: _obscurePassword,
                        onToggleVisibility: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        hasError: _passwordError,
                        errorText: 'Password must be at least 6 characters',
                        responsive: responsive,
                        rFonts: rFonts,
                      ),
                      SizedBox(height: verticalSpacing),
                      Text('Confirm Password', style: rFonts.style22weight600),
                      SizedBox(height: verticalSpacing / 2),
                      _buildPasswordField(
                        controller: _confirmPasswordController,
                        hintText: 'Confirm New Password',
                        obscureText: _obscureConfirmPassword,
                        onToggleVisibility: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                        hasError: _confirmPasswordError || (!_passwordsMatch && !_confirmPasswordError),
                        errorText: _confirmPasswordError 
                            ? 'Confirm password is required' 
                            : (!_passwordsMatch ? 'Passwords do not match' : ''),
                        responsive: responsive,
                        rFonts: rFonts,
                      ),
                      SizedBox(height: verticalSpacing * 1.5),
                      SizedBox(
                        width: double.infinity,
                        height: buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_validateFields()) {
                              NavigateTo(context, const SuccessStateResponsive());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff0B8FAC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Reset Password',
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
                  'Reset Password',
                  style: rFonts.style26weight700,
                ),
                SizedBox(height: verticalSpacing / 2),
                Text(
                  'Create a new password for your account',
                  style: rFonts.style18weight400,
                ),
                SizedBox(height: verticalSpacing * 1.5),
                Text('New Password', style: rFonts.style22weight600),
                SizedBox(height: verticalSpacing / 2),
                _buildPasswordField(
                  controller: _passwordController,
                  hintText: 'Enter New Password',
                  obscureText: _obscurePassword,
                  onToggleVisibility: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  hasError: _passwordError,
                  errorText: 'Password must be at least 6 characters',
                  responsive: responsive,
                  rFonts: rFonts,
                ),
                SizedBox(height: verticalSpacing),
                Text('Confirm Password', style: rFonts.style22weight600),
                SizedBox(height: verticalSpacing / 2),
                _buildPasswordField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm New Password',
                  obscureText: _obscureConfirmPassword,
                  onToggleVisibility: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                  hasError: _confirmPasswordError || (!_passwordsMatch && !_confirmPasswordError),
                  errorText: _confirmPasswordError 
                      ? 'Confirm password is required' 
                      : (!_passwordsMatch ? 'Passwords do not match' : ''),
                  responsive: responsive,
                  rFonts: rFonts,
                ),
                SizedBox(height: verticalSpacing * 2),
                SizedBox(
                  width: double.infinity,
                  height: buttonHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_validateFields()) {
                        NavigateTo(context, const SuccessStateResponsive());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0B8FAC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Reset Password',
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
  }
  
  // Helper method to build password fields with visibility toggle
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    required ResponsiveUtils responsive,
    required ResponsiveFontStyles rFonts,
    bool hasError = false,
    String errorText = '',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: obscureText,
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
                color: hasError ? Colors.red : Colors.transparent,
                width: hasError ? 1.0 : 0,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: responsive.getResponsiveSize(16),
              vertical: responsive.getResponsiveSize(12),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xff0B8FAC),
                size: responsive.getResponsiveSize(22),
              ),
              onPressed: onToggleVisibility,
            ),
          ),
          style: TextStyle(fontSize: responsive.fontSize(16)),
        ),
        if (hasError)
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
