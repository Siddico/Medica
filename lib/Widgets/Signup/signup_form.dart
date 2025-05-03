import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/LoginView/login_view_refactored.dart';
import 'package:medical/Features/SignupView/bloc/bloc.dart';
import 'package:medical/Features/SignupView/bloc/states_doctor.dart';
import 'package:medical/Widgets/Common/responsive_button.dart';
import 'package:medical/Widgets/Common/responsive_password_field.dart';
import 'package:medical/Widgets/Common/responsive_text_field.dart';

/// A responsive signup form that adapts to different screen sizes
class SignupForm extends StatefulWidget {
  /// Function to call when navigation to login is requested
  final VoidCallback onNavigateToLogin;

  const SignupForm({super.key, required this.onNavigateToLogin});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _experienceYearsController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
      _passwordError =
          _passwordController.text.isEmpty ||
          _passwordController.text.length < 6;
      _confirmPasswordError = _confirmPasswordController.text.isEmpty;
      _passwordsMatch =
          _passwordController.text == _confirmPasswordController.text;
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

      widget.onNavigateToLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;

    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
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
          Fluttertoast.showToast(
            msg: state.error,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      },
      builder: (context, state) {
        bool isLoading = state is SignupLoading;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Full Name', style: rFonts.style22weight600),
            SizedBox(height: responsive.getResponsiveSize(8)),
            ResponsiveTextField(
              controller: _fullNameController,
              hintText: 'Enter Your Full Name',
              hasError: _fullNameError,
              errorText: 'Full name is required',
              enabled: !isLoading,
            ),
            SizedBox(height: responsive.getResponsiveSize(20)),
            Text('Email', style: rFonts.style22weight600),
            SizedBox(height: responsive.getResponsiveSize(8)),
            ResponsiveTextField(
              controller: _emailController,
              hintText: 'Enter Your Email',
              keyboardType: TextInputType.emailAddress,
              hasError: _emailError,
              errorText: 'Email is required',
              enabled: !isLoading,
            ),
            SizedBox(height: responsive.getResponsiveSize(20)),
            Text('Specialization', style: rFonts.style22weight600),
            SizedBox(height: responsive.getResponsiveSize(8)),
            ResponsiveTextField(
              controller: _specializationController,
              hintText: 'Enter Your Specialization',
              hasError: _specializationError,
              errorText: 'Specialization is required',
              enabled: !isLoading,
            ),
            SizedBox(height: responsive.getResponsiveSize(20)),
            Text('Experience Years', style: rFonts.style22weight600),
            SizedBox(height: responsive.getResponsiveSize(8)),
            ResponsiveTextField(
              controller: _experienceYearsController,
              hintText: 'e.g., 5',
              keyboardType: TextInputType.number,
              hasError: _experienceYearsError,
              errorText: 'Experience years is required',
              enabled: !isLoading,
            ),
            SizedBox(height: responsive.getResponsiveSize(20)),
            Text('Password', style: rFonts.style22weight600),
            SizedBox(height: responsive.getResponsiveSize(8)),
            ResponsivePasswordField(
              controller: _passwordController,
              hintText: 'Enter Your Password',
              hasError: _passwordError,
              errorText: 'Password must be at least 6 characters',
              enabled: !isLoading,
            ),
            SizedBox(height: responsive.getResponsiveSize(20)),
            Text('Confirm Password', style: rFonts.style22weight600),
            SizedBox(height: responsive.getResponsiveSize(8)),
            ResponsivePasswordField(
              controller: _confirmPasswordController,
              hintText: 'Confirm Your Password',
              hasError:
                  _confirmPasswordError ||
                  (!_passwordsMatch &&
                      !_confirmPasswordError &&
                      !_passwordError),
              errorText:
                  _confirmPasswordError
                      ? 'Confirm password is required'
                      : (!_passwordsMatch ? 'Passwords do not match' : null),
              enabled: !isLoading,
            ),
            SizedBox(height: responsive.getResponsiveSize(20)),
            ResponsiveButton(
              text: 'Sign Up',
              isLoading: isLoading,
              onPressed: () {
                if (_validateFields()) {
                  if (_passwordController.text !=
                      _confirmPasswordController.text) {
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
            ),
            SizedBox(height: responsive.getResponsiveSize(30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: rFonts.style16weight700,
                ),
                GestureDetector(
                  onTap:
                      isLoading
                          ? null
                          : () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginView(),
                              ),
                            );
                          },
                  child: Text(
                    'Login',
                    style: rFonts.style16weight700.copyWith(
                      color: const Color(0xff0B8FAC),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
