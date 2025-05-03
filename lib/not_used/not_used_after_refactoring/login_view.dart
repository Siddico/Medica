import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medical/Constants/constants.dart';
import 'package:medical/Constants/fontStyles.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Features/ForgetPasswordView/forget_password_view.dart';
import 'package:medical/Features/HomeView/home_view_refactored.dart';
import 'package:medical/Features/LoginView/auth.dart';
import 'package:medical/Features/LoginView/bloc/bloc.dart';
import 'package:medical/Features/LoginView/bloc/states.dart';
import 'package:medical/Features/SignupView/signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

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
    return BlocProvider(
      create: (context) => LoginCubit(authRepository: AuthRepository()),
      child: BlocConsumer<LoginCubit, LoginState>(
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

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 24, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(Imagestyles.goBack),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              'Welcome',
                              style: FontStyles.style26weight700,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Text(
                              'Log In',
                              style: FontStyles.style26weight700.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              'Hello Doctor Please Enter Your Correct Data',
                              textAlign: TextAlign.center,
                              style: FontStyles.style18weight400,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text('Email', style: FontStyles.style22weight600),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Enter Your Email',
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
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color:
                                      _emailError
                                          ? Colors.red
                                          : Colors.transparent,
                                  width: _emailError ? 1.0 : 0,
                                ),
                              ),
                            ),
                          ),
                          if (_emailError)
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                'Email is required',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
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
                                color: Color(0xff858585),
                              ),
                              filled: true,
                              fillColor: Color(
                                0xffD9D9D9,
                              ).withAlpha(77), // 30% opacity
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
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color:
                                      _passwordError
                                          ? Colors.red
                                          : Colors.transparent,
                                  width: _passwordError ? 1.0 : 0,
                                ),
                              ),
                            ),
                          ),
                          if (_passwordError)
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                'Password is required',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                NavigateTo(context, ForgetPasswordView());
                              },
                              child: Text(
                                'Did you forget Password?',
                                style: FontStyles.style18weight400.copyWith(
                                  color: Color(0xff10687B),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed:
                                  isLoading
                                      ? null
                                      : () {
                                        if (_validateFields()) {
                                          context.read<LoginCubit>().login(
                                            _emailController.text.trim(),
                                            _passwordController.text,
                                          );
                                        } else {
                                          Fluttertoast.showToast(
                                            msg:
                                                "Please enter email and password",
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
                                        'Sign In',
                                        style: FontStyles.style22weight700
                                            .copyWith(color: Color(0xffffffff)),
                                      ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              const Expanded(child: Divider(thickness: 2)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  'OR',
                                  style: FontStyles.style22weight700.copyWith(
                                    color: Color(0xff858585),
                                  ),
                                ),
                              ),
                              const Expanded(child: Divider(thickness: 2)),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _socialLoginButton(Imagestyles.appleLogo),
                              const SizedBox(width: 16),
                              _socialLoginButton(Imagestyles.googleLogo),
                              const SizedBox(width: 16),
                              _socialLoginButton(Imagestyles.facebookLogo),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don’t have an account? ',
                                style: FontStyles.style16weight700,
                              ),

                              GestureDetector(
                                onTap: () {
                                  NavigateTo(context, SignupView());
                                },
                                child: Text(
                                  'Sign Up',
                                  style: FontStyles.style16weight700.copyWith(
                                    color: Color(0xff0B8FAC),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 58),
                        ],
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Image.asset(Imagestyles.backGroundOfLoginView),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _socialLoginButton(String imagePath) {
    return Container(
      width: 50,
      height: 50,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Image.asset(imagePath, fit: BoxFit.fill),
    );
  }
}
