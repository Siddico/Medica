// This file is deprecated. Use signup_view_clean.dart instead.
// This file is kept for reference purposes only.

// The implementation has been moved to signup_view_clean.dart to fix syntax errors
// and add the confirm password field with proper validation.

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medical/Constants/constants.dart';
import 'package:medical/Constants/fontStyles.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Features/LoginView/login_view.dart';
import 'package:medical/Features/SignupView/bloc/bloc.dart';
import 'package:medical/Features/SignupView/bloc/states_doctor.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _experienceYearsController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: BlocConsumer<SignupCubit, SignupState>(
                    listener: (context, state) {
                      if (state is SignupSuccess) {
                        log('SignupSuccess state received in UI');
                        Fluttertoast.showToast(
                          msg: "Signup successful!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                        );
                        // Navigate immediately instead of using a delay
                        NavigateTo(context, LoginView());
                      } else if (state is SignupFailure) {
                        log(
                          'SignupFailure state received in UI: ${state.error}',
                        );
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
                          SvgPicture.asset(Imagestyles.goBack),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              'Doctor',
                              style: FontStyles.style26weight700,
                            ),
                          ),
                          Center(
                            child: Text(
                              'Create New Doctor',
                              style: FontStyles.style26weight700,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text('Full Name', style: FontStyles.style22weight600),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _fullNameController,
                            decoration: InputDecoration(
                              hintText: 'Enter Your Full Name',
                              hintStyle: FontStyles.style18weight400.copyWith(
                                color: Color(0xff858585),
                              ),
                              filled: true,
                              fillColor: Color(
                                0xffD9D9D9,
                              ).withAlpha(77), // 30% opacity
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            enabled: !isLoading,
                          ),
                          const SizedBox(height: 20),
                          Text('Email', style: FontStyles.style22weight600),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'Enter Your Email',
                              hintStyle: FontStyles.style18weight400.copyWith(
                                color: Color(0xff858585),
                              ),
                              filled: true,
                              fillColor: Color(0xffD9D9D9).withOpacity(0.30),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            enabled: !isLoading,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Specialization',
                            style: FontStyles.style22weight600,
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _specializationController,
                            decoration: InputDecoration(
                              hintText: 'Enter Your Specialization',
                              hintStyle: FontStyles.style18weight400.copyWith(
                                color: Color(0xff858585),
                              ),
                              filled: true,
                              fillColor: Color(0xffD9D9D9).withOpacity(0.30),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            enabled: !isLoading,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Experience Years',
                            style: FontStyles.style22weight600,
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _experienceYearsController,
                            decoration: InputDecoration(
                              hintText: 'e.g., 5',
                              hintStyle: FontStyles.style18weight400.copyWith(
                                color: Color(0xff858585),
                              ),
                              filled: true,
                              fillColor: Color(0xffD9D9D9).withOpacity(0.30),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            enabled: !isLoading,
                          ),
                          const SizedBox(height: 20),
                          Text('Password', style: FontStyles.style22weight600),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              hintText: 'Enter Your Password',
                              hintStyle: FontStyles.style18weight400.copyWith(
                                color: Color(0xff858585),
                              ),
                              filled: true,
                              fillColor: Color(0xffD9D9D9).withOpacity(0.30),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Color(0xff0B8FAC),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            enabled: !isLoading,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed:
                                  isLoading
                                      ? null
                                      : () {
                                        if (_validateFields()) {
                                          // If passwords don't match, show error toast
                                          if (_passwordController.text !=
                                              _confirmPasswordController.text) {
                                            Fluttertoast.showToast(
                                              msg: "Passwords do not match",
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                            );
                                            return;
                                          }

                                          context
                                              .read<SignupCubit>()
                                              .signupWithEmail(
                                                fullName:
                                                    _fullNameController.text
                                                        .trim(),
                                                email:
                                                    _emailController.text
                                                        .trim(),
                                                specialization:
                                                    _specializationController
                                                        .text
                                                        .trim(),
                                                experienceYears:
                                                    _experienceYearsController
                                                        .text
                                                        .trim(),
                                                password:
                                                    _passwordController.text,
                                              );
                                        } else {
                                          // Show error toast for validation failure
                                          String errorMessage =
                                              "Please fix the following errors:";
                                          if (_fullNameError)
                                            errorMessage +=
                                                "\n- Full name is required";
                                          if (_emailError)
                                            errorMessage +=
                                                "\n- Email is required";
                                          if (_specializationError)
                                            errorMessage +=
                                                "\n- Specialization is required";
                                          if (_experienceYearsError)
                                            errorMessage +=
                                                "\n- Experience years is required";
                                          if (_passwordError)
                                            errorMessage +=
                                                "\n- Password must be at least 6 characters";
                                          if (_confirmPasswordError)
                                            errorMessage +=
                                                "\n- Confirm password is required";
                                          if (!_passwordsMatch)
                                            errorMessage +=
                                                "\n- Passwords do not match";

                                          Fluttertoast.showToast(
                                            msg: errorMessage,
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                          );
                                        }
                                      },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff0B8FAC),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child:
                                  isLoading
                                      ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                      : Text(
                                        'Sign Up',
                                        style: FontStyles.style22weight700
                                            .copyWith(color: Color(0xffffffff)),
                                      ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account? ',
                                style: FontStyles.style16weight700,
                              ),
                              GestureDetector(
                                onTap:
                                    isLoading
                                        ? null
                                        : () =>
                                            NavigateTo(context, LoginView()),
                                child: Text(
                                  'Login',
                                  style: FontStyles.style16weight700.copyWith(
                                    color: Color(0xff0B8FAC),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(Imagestyles.backGroundOfSignUpView),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
