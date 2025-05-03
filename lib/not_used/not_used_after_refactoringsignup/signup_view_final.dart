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
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
                            child: SvgPicture.asset(Imagestyles.goBack),
                          ),
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
                                  color: _fullNameError ? Colors.red : Colors.transparent,
                                  width: _fullNameError ? 1.0 : 0,
                                ),
                              ),
                            ),
                            enabled: !isLoading,
                          ),
                          if (_fullNameError)
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                'Full name is required',
                                style: TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                          const SizedBox(height: 20),
                          Text('Email', style: FontStyles.style22weight600),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Enter Your Email',
                              hintStyle: FontStyles.style18weight400.copyWith(
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
                                  color: _emailError ? Colors.red : Colors.transparent,
                                  width: _emailError ? 1.0 : 0,
                                ),
                              ),
                            ),
                            enabled: !isLoading,
                          ),
                          if (_emailError)
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                'Email is required',
                                style: TextStyle(color: Colors.red, fontSize: 12),
                              ),
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
                                  color: _specializationError ? Colors.red : Colors.transparent,
                                  width: _specializationError ? 1.0 : 0,
                                ),
                              ),
                            ),
                            enabled: !isLoading,
                          ),
                          if (_specializationError)
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                'Specialization is required',
                                style: TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                          const SizedBox(height: 20),
                          Text(
                            'Experience Years',
                            style: FontStyles.style22weight600,
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _experienceYearsController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'e.g., 5',
                              hintStyle: FontStyles.style18weight400.copyWith(
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
                                  color: _experienceYearsError ? Colors.red : Colors.transparent,
                                  width: _experienceYearsError ? 1.0 : 0,
                                ),
                              ),
                            ),
                            enabled: !isLoading,
                          ),
                          if (_experienceYearsError)
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                'Experience years is required',
                                style: TextStyle(color: Colors.red, fontSize: 12),
                              ),
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
                                  color: _passwordError ? Colors.red : Colors.transparent,
                                  width: _passwordError ? 1.0 : 0,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: const Color(0xff0B8FAC),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            enabled: !isLoading,
                          ),
                          if (_passwordError)
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                'Password must be at least 6 characters',
                                style: TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                          const SizedBox(height: 20),
                          Text('Confirm Password', style: FontStyles.style22weight600),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _confirmPasswordController,
                            obscureText: _obscureConfirmPassword,
                            decoration: InputDecoration(
                              hintText: 'Confirm Your Password',
                              hintStyle: FontStyles.style18weight400.copyWith(
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
                                  color: (_confirmPasswordError || !_passwordsMatch && !_confirmPasswordError && !_passwordError) 
                                      ? Colors.red 
                                      : Colors.transparent,
                                  width: (_confirmPasswordError || !_passwordsMatch && !_confirmPasswordError && !_passwordError) ? 1.0 : 0,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: const Color(0xff0B8FAC),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword = !_obscureConfirmPassword;
                                  });
                                },
                              ),
                            ),
                            enabled: !isLoading,
                          ),
                          if (_confirmPasswordError)
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                'Confirm password is required',
                                style: TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                          if (!_passwordsMatch && !_confirmPasswordError && !_passwordError)
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                'Passwords do not match',
                                style: TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
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
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : Text(
                                      'Sign Up',
                                      style: FontStyles.style22weight700.copyWith(color: const Color(0xffffffff)),
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
                                onTap: isLoading ? null : () => NavigateTo(context, LoginView()),
                                child: Text(
                                  'Login',
                                  style: FontStyles.style16weight700.copyWith(
                                    color: const Color(0xff0B8FAC),
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
