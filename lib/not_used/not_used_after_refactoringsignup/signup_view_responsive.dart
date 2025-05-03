import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medical/Constants/constants.dart';
import 'package:medical/Constants/fontStyles.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Constants/responsive_wrapper.dart';
import 'package:medical/Features/LoginView/login_view.dart';
import 'package:medical/Features/SignupView/bloc/bloc.dart';
import 'package:medical/Features/SignupView/bloc/states_doctor.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _specializationController = TextEditingController();
  final TextEditingController _experienceYearsController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  
  // Validation state
  bool _fullNameError = false;
  bool _emailError = false;
  bool _specializationError = false;
  bool _experienceYearsError = false;
  bool _passwordError = false;
  bool _confirmPasswordError = false;
  bool _passwordsMatch = true;
  
  // Flag to prevent multiple navigation attempts
  bool _isNavigating = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _specializationController.dispose();
    _experienceYearsController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  
  // Validate all fields and return true if valid
  bool _validateFields() {
    setState(() {
      _fullNameError = _fullNameController.text.trim().isEmpty;
      _emailError = _emailController.text.trim().isEmpty;
      _specializationError = _specializationController.text.trim().isEmpty;
      _experienceYearsError = _experienceYearsController.text.trim().isEmpty;
      _passwordError = _passwordController.text.isEmpty || _passwordController.text.length < 6;
      _confirmPasswordError = _confirmPasswordController.text.isEmpty;
      _passwordsMatch = _passwordController.text == _confirmPasswordController.text;
    });
    
    return !_fullNameError && 
           !_emailError && 
           !_specializationError && 
           !_experienceYearsError && 
           !_passwordError && 
           !_confirmPasswordError && 
           _passwordsMatch;
  }
  
  // Navigate to login screen safely
  void _navigateToLogin() {
    if (!_isNavigating && mounted) {
      setState(() {
        _isNavigating = true;
      });
      
      // Use Navigator.pushAndRemoveUntil to clear the navigation stack
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
        (route) => false,
      );
    }
  }

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
                child: BlocConsumer<SignupCubit, SignupState>(
                  listener: (context, state) {
                    if (state is SignupSuccess) {
                      log('SignupSuccess state received in UI');
                      Fluttertoast.showToast(
                        msg: "Signup successful! Your account has been created.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                      );
                      
                      // Use a simple delay before navigation
                      Future.delayed(const Duration(milliseconds: 1500), _navigateToLogin);
                    } else if (state is SignupFailure) {
                      log('SignupFailure state received in UI: ${state.error}');
                      Fluttertoast.showToast(
                        msg: state.error,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (state is SignupLoading) {
                      log('SignupLoading state received in UI');
                    }
                  },
                  builder: (context, state) {
                    bool isLoading = state is SignupLoading;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: isLoading ? null : () => Navigator.pop(context),
                          child: SvgPicture.asset(
                            Imagestyles.goBack,
                            width: responsive.getResponsiveSize(24),
                            height: responsive.getResponsiveSize(24),
                          ),
                        ),
                        responsive.verticalSpace(10),
                        Center(
                          child: Text(
                            'Doctor',
                            style: rFonts.style26weight700,
                          ),
                        ),
                        Center(
                          child: Text(
                            'Create New Doctor',
                            style: rFonts.style26weight700,
                          ),
                        ),
                        responsive.verticalSpace(15),
                        Text('Full Name', style: rFonts.style22weight600),
                        responsive.verticalSpace(8),
                        _buildTextField(
                          controller: _fullNameController,
                          hintText: 'Enter Your Full Name',
                          hasError: _fullNameError,
                          enabled: !isLoading,
                        ),
                        if (_fullNameError)
                          Padding(
                            padding: EdgeInsets.only(top: responsive.getResponsiveSize(5)),
                            child: Text(
                              'Full name is required',
                              style: TextStyle(
                                color: Colors.red, 
                                fontSize: responsive.fontSize(12),
                              ),
                            ),
                          ),
                        responsive.verticalSpace(20),
                        Text('Email', style: rFonts.style22weight600),
                        responsive.verticalSpace(8),
                        _buildTextField(
                          controller: _emailController,
                          hintText: 'Enter Your Email',
                          keyboardType: TextInputType.emailAddress,
                          hasError: _emailError,
                          enabled: !isLoading,
                        ),
                        if (_emailError)
                          Padding(
                            padding: EdgeInsets.only(top: responsive.getResponsiveSize(5)),
                            child: Text(
                              'Email is required',
                              style: TextStyle(
                                color: Colors.red, 
                                fontSize: responsive.fontSize(12),
                              ),
                            ),
                          ),
                        responsive.verticalSpace(20),
                        Text(
                          'Specialization',
                          style: rFonts.style22weight600,
                        ),
                        responsive.verticalSpace(8),
                        _buildTextField(
                          controller: _specializationController,
                          hintText: 'Enter Your Specialization',
                          hasError: _specializationError,
                          enabled: !isLoading,
                        ),
                        if (_specializationError)
                          Padding(
                            padding: EdgeInsets.only(top: responsive.getResponsiveSize(5)),
                            child: Text(
                              'Specialization is required',
                              style: TextStyle(
                                color: Colors.red, 
                                fontSize: responsive.fontSize(12),
                              ),
                            ),
                          ),
                        responsive.verticalSpace(20),
                        Text(
                          'Experience Years',
                          style: rFonts.style22weight600,
                        ),
                        responsive.verticalSpace(8),
                        _buildTextField(
                          controller: _experienceYearsController,
                          hintText: 'e.g., 5',
                          keyboardType: TextInputType.number,
                          hasError: _experienceYearsError,
                          enabled: !isLoading,
                        ),
                        if (_experienceYearsError)
                          Padding(
                            padding: EdgeInsets.only(top: responsive.getResponsiveSize(5)),
                            child: Text(
                              'Experience years is required',
                              style: TextStyle(
                                color: Colors.red, 
                                fontSize: responsive.fontSize(12),
                              ),
                            ),
                          ),
                        responsive.verticalSpace(20),
                        Text('Password', style: rFonts.style22weight600),
                        responsive.verticalSpace(8),
                        _buildPasswordField(
                          controller: _passwordController,
                          hintText: 'Enter Your Password',
                          obscureText: _obscurePassword,
                          onToggleVisibility: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          hasError: _passwordError,
                          enabled: !isLoading,
                        ),
                        if (_passwordError)
                          Padding(
                            padding: EdgeInsets.only(top: responsive.getResponsiveSize(5)),
                            child: Text(
                              'Password must be at least 6 characters',
                              style: TextStyle(
                                color: Colors.red, 
                                fontSize: responsive.fontSize(12),
                              ),
                            ),
                          ),
                        responsive.verticalSpace(20),
                        Text('Confirm Password', style: rFonts.style22weight600),
                        responsive.verticalSpace(8),
                        _buildPasswordField(
                          controller: _confirmPasswordController,
                          hintText: 'Confirm Your Password',
                          obscureText: _obscureConfirmPassword,
                          onToggleVisibility: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                          hasError: _confirmPasswordError || (!_passwordsMatch && !_confirmPasswordError && !_passwordError),
                          enabled: !isLoading,
                        ),
                        if (_confirmPasswordError)
                          Padding(
                            padding: EdgeInsets.only(top: responsive.getResponsiveSize(5)),
                            child: Text(
                              'Confirm password is required',
                              style: TextStyle(
                                color: Colors.red, 
                                fontSize: responsive.fontSize(12),
                              ),
                            ),
                          ),
                        if (!_passwordsMatch && !_confirmPasswordError && !_passwordError)
                          Padding(
                            padding: EdgeInsets.only(top: responsive.getResponsiveSize(5)),
                            child: Text(
                              'Passwords do not match',
                              style: TextStyle(
                                color: Colors.red, 
                                fontSize: responsive.fontSize(12),
                              ),
                            ),
                          ),
                        responsive.verticalSpace(20),
                        SizedBox(
                          width: double.infinity,
                          height: responsive.getResponsiveSize(50),
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    if (_validateFields()) {
                                      if (_passwordController.text != _confirmPasswordController.text) {
                                        Fluttertoast.showToast(
                                          msg: "Passwords do not match",
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                        );
                                        return;
                                      }
                                      
                                      context.read<SignupCubit>().signupWithEmail(
                                            fullName: _fullNameController.text.trim(),
                                            email: _emailController.text.trim(),
                                            specialization: _specializationController.text.trim(),
                                            experienceYears: _experienceYearsController.text.trim(),
                                            password: _passwordController.text,
                                          );
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "Please fix the validation errors",
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff0B8FAC),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: isLoading
                                ? SizedBox(
                                    width: responsive.getResponsiveSize(24),
                                    height: responsive.getResponsiveSize(24),
                                    child: const CircularProgressIndicator(color: Colors.white),
                                  )
                                : Text(
                                    'Sign Up',
                                    style: rFonts.style22weight700,
                                  ),
                          ),
                        ),
                        responsive.verticalSpace(30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: rFonts.style16weight700,
                            ),
                            GestureDetector(
                              onTap: isLoading ? null : () => NavigateTo(context, LoginView()),
                              child: Text(
                                'Login',
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
                    );
                  },
                ),
              ),
              backgroundElements: [
                ResponsivePositionedItem(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    Imagestyles.backGroundOfSignUpView,
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
  
  // Helper method to build text fields with consistent styling
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool hasError = false,
    bool enabled = true,
  }) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;
    
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
      ),
      style: TextStyle(fontSize: responsive.fontSize(16)),
      enabled: enabled,
    );
  }
  
  // Helper method to build password fields with visibility toggle
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    bool hasError = false,
    bool enabled = true,
  }) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;
    
    return TextField(
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
      enabled: enabled,
    );
  }
}
