// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:medical/Constants/constants.dart';
// import 'package:medical/Constants/fontStyles.dart';
// import 'package:medical/Constants/imageStyles.dart';
// import 'package:medical/Constants/responsive_font_styles.dart';
// import 'package:medical/Constants/responsive_utils.dart';
// import 'package:medical/Constants/responsive_wrapper.dart';
// import 'package:medical/Features/ForgetPasswordView/not_used_after_refactoring/forget_password_view.dart';
// // import 'package:medical/Features/ForgetPasswordView/forget_password_view.dart';
// import 'package:medical/Features/HomeView/home_view_refactored.dart';
// import 'package:medical/Features/LoginView/auth.dart';
// import 'package:medical/Features/LoginView/bloc/bloc.dart';
// import 'package:medical/Features/LoginView/bloc/states.dart';
// import 'package:medical/Features/SignupView/not_used_after_refactoring/signup_view.dart';
// // import 'package:medical/Features/SignupView/signup_view_responsive.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({super.key});

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _obscurePassword = true;

//   // Validation state
//   bool _emailError = false;
//   bool _passwordError = false;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   // Validate all fields and return true if valid
//   bool _validateFields() {
//     setState(() {
//       _emailError = _emailController.text.trim().isEmpty;
//       _passwordError = _passwordController.text.isEmpty;
//     });

//     return !_emailError && !_passwordError;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final responsive = ResponsiveUtils(context);
//     final rFonts = context.responsiveFontStyles;

//     return BlocProvider(
//       create: (context) => LoginCubit(authRepository: AuthRepository()),
//       child: BlocConsumer<LoginCubit, LoginState>(
//         listener: (context, state) {
//           if (state is LoginSuccess) {
//             Fluttertoast.showToast(
//               msg: "Login successful!",
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.BOTTOM,
//               backgroundColor: Colors.green,
//               textColor: Colors.white,
//             );
//             NavigateTo(context, const HomeViewRefactored());
//           } else if (state is LoginFailure) {
//             Fluttertoast.showToast(
//               msg: state.error,
//               toastLength: Toast.LENGTH_LONG,
//               gravity: ToastGravity.BOTTOM,
//               backgroundColor: Colors.red,
//               textColor: Colors.white,
//             );
//           }
//         },
//         builder: (context, state) {
//           final bool isLoading = state is LoginLoading;

//           return Scaffold(
//             backgroundColor: Colors.white,
//             body: SafeArea(
//               child: SingleChildScrollView(
//                 child: ResponsiveStack(
//                   mainContent: Padding(
//                     padding: responsive.getPadding(),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         GestureDetector(
//                           onTap:
//                               isLoading ? null : () => Navigator.pop(context),
//                           child: SvgPicture.asset(
//                             Imagestyles.goBack,
//                             width: responsive.getResponsiveSize(24),
//                             height: responsive.getResponsiveSize(24),
//                           ),
//                         ),
//                         responsive.verticalSpace(10),
//                         Center(
//                           child: Text(
//                             'Welcome',
//                             style: rFonts.style26weight700,
//                           ),
//                         ),
//                         responsive.verticalSpace(20),
//                         Center(
//                           child: Text(
//                             'Log In',
//                             style: rFonts.style26weight700.copyWith(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         responsive.verticalSpace(10),
//                         Center(
//                           child: Text(
//                             'Hello Doctor Please Enter Your Correct Data',
//                             textAlign: TextAlign.center,
//                             style: rFonts.style18weight400,
//                           ),
//                         ),
//                         responsive.verticalSpace(30),
//                         Text('Email', style: rFonts.style22weight600),
//                         responsive.verticalSpace(8),
//                         _buildTextField(
//                           controller: _emailController,
//                           hintText: 'Enter Your Email',
//                           keyboardType: TextInputType.emailAddress,
//                           hasError: _emailError,
//                           enabled: !isLoading,
//                         ),
//                         if (_emailError)
//                           Padding(
//                             padding: EdgeInsets.only(
//                               top: responsive.getResponsiveSize(5),
//                             ),
//                             child: Text(
//                               'Email is required',
//                               style: TextStyle(
//                                 color: Colors.red,
//                                 fontSize: responsive.fontSize(12),
//                               ),
//                             ),
//                           ),
//                         responsive.verticalSpace(20),
//                         Text('Password', style: rFonts.style22weight600),
//                         responsive.verticalSpace(8),
//                         _buildPasswordField(
//                           controller: _passwordController,
//                           hintText: 'Enter Your Password',
//                           obscureText: _obscurePassword,
//                           onToggleVisibility: () {
//                             setState(() {
//                               _obscurePassword = !_obscurePassword;
//                             });
//                           },
//                           hasError: _passwordError,
//                           enabled: !isLoading,
//                         ),
//                         if (_passwordError)
//                           Padding(
//                             padding: EdgeInsets.only(
//                               top: responsive.getResponsiveSize(5),
//                             ),
//                             child: Text(
//                               'Password is required',
//                               style: TextStyle(
//                                 color: Colors.red,
//                                 fontSize: responsive.fontSize(12),
//                               ),
//                             ),
//                           ),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: TextButton(
//                             onPressed:
//                                 isLoading
//                                     ? null
//                                     : () {
//                                       NavigateTo(context, ForgetPasswordView());
//                                     },
//                             child: Text(
//                               'Forgot Password?',
//                               style: rFonts.style16weight700.copyWith(
//                                 color: const Color(0xff0B8FAC),
//                               ),
//                             ),
//                           ),
//                         ),
//                         responsive.verticalSpace(20),
//                         SizedBox(
//                           width: double.infinity,
//                           height: responsive.getResponsiveSize(50),
//                           child: ElevatedButton(
//                             onPressed:
//                                 isLoading
//                                     ? null
//                                     : () {
//                                       if (_validateFields()) {
//                                         context.read<LoginCubit>().login(
//                                           _emailController.text.trim(),
//                                           _passwordController.text,
//                                         );
//                                       } else {
//                                         Fluttertoast.showToast(
//                                           msg:
//                                               "Please enter email and password",
//                                           backgroundColor: Colors.red,
//                                           textColor: Colors.white,
//                                         );
//                                       }
//                                     },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xff0B8FAC),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             child:
//                                 isLoading
//                                     ? SizedBox(
//                                       width: responsive.getResponsiveSize(24),
//                                       height: responsive.getResponsiveSize(24),
//                                       child: const CircularProgressIndicator(
//                                         color: Colors.white,
//                                       ),
//                                     )
//                                     : Text(
//                                       'Sign In',
//                                       style: rFonts.style22weight700,
//                                     ),
//                           ),
//                         ),
//                         responsive.verticalSpace(30),
//                         Row(
//                           children: [
//                             const Expanded(child: Divider(thickness: 2)),
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: responsive.getResponsiveSize(8),
//                               ),
//                               child: Text(
//                                 'OR',
//                                 style: rFonts.style22weight700.copyWith(
//                                   color: const Color(0xff858585),
//                                 ),
//                               ),
//                             ),
//                             const Expanded(child: Divider(thickness: 2)),
//                           ],
//                         ),
//                         responsive.verticalSpace(30),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             _socialLoginButton(
//                               Imagestyles.appleLogo,
//                               responsive,
//                             ),
//                             responsive.horizontalSpace(16),
//                             _socialLoginButton(
//                               Imagestyles.googleLogo,
//                               responsive,
//                             ),
//                             responsive.horizontalSpace(16),
//                             _socialLoginButton(
//                               Imagestyles.facebookLogo,
//                               responsive,
//                             ),
//                           ],
//                         ),
//                         responsive.verticalSpace(30),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Don\'t have an account? ',
//                               style: rFonts.style16weight700,
//                             ),
//                             GestureDetector(
//                               onTap:
//                                   isLoading
//                                       ? null
//                                       : () {
//                                         NavigateTo(context, SignupView());
//                                       },
//                               child: Text(
//                                 'Sign Up',
//                                 style: rFonts.style16weight700.copyWith(
//                                   color: const Color(0xff0B8FAC),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         // Add extra space at the bottom to ensure the background image doesn't overlap content
//                         responsive.verticalSpace(
//                           responsive.isTablet ? 100 : 50,
//                         ),
//                       ],
//                     ),
//                   ),
//                   backgroundElements: [
//                     ResponsivePositionedItem(
//                       bottom: 0,
//                       left: 0,
//                       child: Image.asset(
//                         Imagestyles.backGroundOfLoginView,
//                         width: responsive.responsiveValue(
//                           mobile: responsive.widthPercent(60),
//                           tablet: responsive.widthPercent(40),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // Helper method to build text fields with consistent styling
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hintText,
//     TextInputType keyboardType = TextInputType.text,
//     bool hasError = false,
//     bool enabled = true,
//   }) {
//     final responsive = ResponsiveUtils(context);
//     final rFonts = context.responsiveFontStyles;

//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: rFonts.style18weight400.copyWith(
//           color: const Color(0xff858585),
//         ),
//         filled: true,
//         fillColor: const Color(0xffD9D9D9).withAlpha(77), // 30% opacity
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(
//             color: hasError ? Colors.red : Colors.transparent,
//             width: hasError ? 1.0 : 0,
//           ),
//         ),
//         contentPadding: EdgeInsets.symmetric(
//           horizontal: responsive.getResponsiveSize(16),
//           vertical: responsive.getResponsiveSize(12),
//         ),
//       ),
//       style: TextStyle(fontSize: responsive.fontSize(16)),
//       enabled: enabled,
//     );
//   }

//   // Helper method to build password fields with visibility toggle
//   Widget _buildPasswordField({
//     required TextEditingController controller,
//     required String hintText,
//     required bool obscureText,
//     required VoidCallback onToggleVisibility,
//     bool hasError = false,
//     bool enabled = true,
//   }) {
//     final responsive = ResponsiveUtils(context);
//     final rFonts = context.responsiveFontStyles;

//     return TextField(
//       controller: controller,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: rFonts.style18weight400.copyWith(
//           color: const Color(0xff858585),
//         ),
//         filled: true,
//         fillColor: const Color(0xffD9D9D9).withAlpha(77), // 30% opacity
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(
//             color: hasError ? Colors.red : Colors.transparent,
//             width: hasError ? 1.0 : 0,
//           ),
//         ),
//         contentPadding: EdgeInsets.symmetric(
//           horizontal: responsive.getResponsiveSize(16),
//           vertical: responsive.getResponsiveSize(12),
//         ),
//         suffixIcon: IconButton(
//           icon: Icon(
//             obscureText ? Icons.visibility_off : Icons.visibility,
//             color: const Color(0xff0B8FAC),
//             size: responsive.getResponsiveSize(22),
//           ),
//           onPressed: onToggleVisibility,
//         ),
//       ),
//       style: TextStyle(fontSize: responsive.fontSize(16)),
//       enabled: enabled,
//     );
//   }

//   Widget _socialLoginButton(String imagePath, ResponsiveUtils responsive) {
//     return Container(
//       width: responsive.getResponsiveSize(50),
//       height: responsive.getResponsiveSize(50),
//       padding: EdgeInsets.all(responsive.getResponsiveSize(8)),
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Image.asset(imagePath, fit: BoxFit.fill),
//     );
//   }
// }
