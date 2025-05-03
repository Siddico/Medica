// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:medical/Constants/constants.dart';
// import 'package:medical/Constants/fontStyles.dart';
// import 'package:medical/Constants/imageStyles.dart';
// import 'package:medical/Features/LoginView/login_view.dart';

// class PersonsView extends StatefulWidget {
//   const PersonsView({super.key});

//   @override
//   State<PersonsView> createState() => _PersonsViewState();
// }

// class _PersonsViewState extends State<PersonsView>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 3000),
//     );

//     _scaleAnimation = Tween<double>(
//       begin: 0.5,
//       end: 1.0,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Widget _buildRole(String imagePath, String role) {
//     return Column(
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: Image.asset(
//             imagePath,
//             width: 175,
//             height: 175,
//             fit: BoxFit.cover,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           role,
//           style: FontStyles.style70weight600.copyWith(
//             fontSize: 16,
//             color: Colors.black,
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: ScaleTransition(
//         scale: _scaleAnimation,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 40),
//               Text('You Are', style: FontStyles.style70weight600),
//               const SizedBox(height: 40),
//               Expanded(
//                 child: GridView.count(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 20,
//                   crossAxisSpacing: 20,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         NavigateTo(context, LoginView());
//                       },
//                       child: _buildRole(Imagestyles.DoctorsLogo, 'Doctor'),
//                     ),
//                     _buildRole(Imagestyles.InternDoctorsLogo, 'Intern Doctor'),
//                     _buildRole(Imagestyles.PatientLogo, 'Patient'),
//                     _buildRole(Imagestyles.NurseLogo, 'Nurse'),
//                   ],
//                 ),
//               ),

//               // const SizedBox(height: 20),

//               // GestureDetector(
//               //   onTap: () {
//               //     // Handle Admin Tap
//               //   },
//               //   child: const Text(
//               //     'Iam Admin',
//               //     style: TextStyle(
//               //       fontSize: 18,
//               //       fontWeight: FontWeight.bold,
//               //       color: Colors.lightBlue,
//               //       decoration: TextDecoration.underline,
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
