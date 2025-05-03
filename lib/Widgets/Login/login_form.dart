import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medical/Constants/constants.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/ForgetPasswordView/forget_password_view_enhanced.dart';
import 'package:medical/Features/HomeView/home_view_refactored.dart';
import 'package:medical/Features/LoginView/bloc/bloc.dart';
import 'package:medical/Features/LoginView/bloc/states.dart';
import 'package:medical/Widgets/Common/responsive_button.dart';
import 'package:medical/Widgets/Common/responsive_password_field.dart';
import 'package:medical/Widgets/Common/responsive_text_field.dart';

/// A responsive login form that adapts to different screen sizes
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Validation state
  bool _emailError = false;
  bool _passwordError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Validate all fields and return true if valid
  bool _validateFields() {
    setState(() {
      _emailError = _emailController.text.trim().isEmpty;
      _passwordError = _passwordController.text.isEmpty;
    });

    return !_emailError && !_passwordError;
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Fluttertoast.showToast(
            msg: "Login successful!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          NavigateTo(context, const HomeViewRefactored());
        } else if (state is LoginFailure) {
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
        final bool isLoading = state is LoginLoading;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Text('Password', style: rFonts.style22weight600),
            SizedBox(height: responsive.getResponsiveSize(8)),
            ResponsivePasswordField(
              controller: _passwordController,
              hintText: 'Enter Your Password',
              hasError: _passwordError,
              errorText: 'Password is required',
              enabled: !isLoading,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed:
                    isLoading
                        ? null
                        : () {
                          NavigateTo(
                            context,
                            const ForgetPasswordViewEnhanced(),
                          );
                        },
                child: Text(
                  'Forgot Password?',
                  style: rFonts.style16weight700.copyWith(
                    color: const Color(0xff0B8FAC),
                  ),
                ),
              ),
            ),
            SizedBox(height: responsive.getResponsiveSize(20)),
            ResponsiveButton(
              text: 'Sign In',
              isLoading: isLoading,
              onPressed: () {
                if (_validateFields()) {
                  context.read<LoginCubit>().login(
                    _emailController.text.trim(),
                    _passwordController.text,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: "Please enter email and password",
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
