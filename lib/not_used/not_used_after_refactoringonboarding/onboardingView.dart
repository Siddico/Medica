// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:medical/Constants/fontStyles.dart';
// import 'package:medical/Constants/imageStyles.dart';
// import 'package:medical/Features/personsView/persons_view.dart';
// import 'package:medical/Models/onboardingViewModel.dart';

// class OnboardingView extends StatefulWidget {
//   const OnboardingView({super.key});

//   @override
//   State<OnboardingView> createState() => _OnboardingViewState();
// }

// class _OnboardingViewState extends State<OnboardingView>
//     with TickerProviderStateMixin {
//   late final PageController _pageController;
//   late final List<OnboardingModel> onboardingData;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();

//     onboardingData = [
//       OnboardingModel(
//         image: Imagestyles.image1,
//         title: 'Find Trusted Doctors',
//         description:
//             'Easily search for experienced and verified doctors based on specialty, availability, and patient reviews.',
//         mode: 0,
//       ),
//       OnboardingModel(
//         image: Imagestyles.logo2,
//         title: 'Doctor’s Calendar & Availability Management',
//         description: 'Doctor Schedules & Appointment Slots',
//         mode: 1,
//       ),
//       OnboardingModel(
//         image: Imagestyles.logo3,
//         title: 'Easy Appointments',
//         description:
//             'Schedule doctor visits effortlessly with a user-friendly booking system. Choose your preferred date, time, and doctor with just a few clicks.',
//         mode: 0,
//       ),
//       OnboardingModel(
//         image: Imagestyles.logo4,
//         title: 'Choose Best Doctors',
//         description:
//             'Find highly rated and trusted doctors based on specialty, experience, and patient reviews.',
//         mode: 1,
//       ),
//       OnboardingModel(
//         image: Imagestyles.logo5,
//         title: 'Smart Inpatient',
//         description:
//             'Streamline hospital stays with real-time bed management, patient monitoring, and automated care updates. Ensure a smooth and efficient inpatient experience with digital tracking and seamless communication between medical staff and patients.',
//         mode: 0,
//       ),
//       OnboardingModel(
//         image: Imagestyles.logo6,
//         title: 'Digital Health Records',
//         description:
//             '– Securely store and access medical history, prescriptions, test results, and treatment plans in one place. Patients and doctors can easily retrieve past records for accurate diagnoses and better healthcare decisions.',
//         mode: 1,
//       ),
//       OnboardingModel(
//         image: Imagestyles.logo7,
//         title: 'Fast Billing',
//         description:
//             'implify payments with a quick and hassle-free billing system. Generate invoices instantly, track payments, and process transactions efficiently for a seamless checkout experience.',
//         mode: 0,
//       ),
//       OnboardingModel(
//         image: Imagestyles.logo8,
//         title: 'LabPro',
//         description:
//             'Access reliable medical testing services with ease. Book lab tests online, track your test status, and receive accurate reports digitally.',
//         mode: 1,
//       ),
//       OnboardingModel(
//         image: Imagestyles.logo9,
//         title: 'Patient Portal',
//         description:
//             '– Your personalized healthcare hub. Access medical records, track appointments, communicate with doctors, and manage prescriptions',
//         mode: 0,
//       ),
//       OnboardingModel(
//         image: Imagestyles.logo10,
//         title: 'Queue Manager',
//         description:
//             'Streamline patient flow with an efficient queue management system. Track waiting times, manage appointments in real time, and ensure a smooth and organized experience for both patients and healthcare providers.',
//         mode: 1,
//       ),
//       OnboardingModel(
//         image: Imagestyles.logo11,
//         title: 'Auto Reminders',
//         description:
//             'Never miss an appointment with automated reminders. Patients receive timely notifications via SMS or email for upcoming visits, medication schedules, and follow-ups, ensuring better healthcare management.',
//         mode: 0,
//       ),

//       // Add more items as needed...
//     ];
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: PageView.builder(
//         controller: _pageController,
//         itemCount: onboardingData.length,
//         itemBuilder: (context, index) {
//           return OnboardingPage(
//             model: onboardingData[index],
//             controller: _pageController,
//             currentIndex: index, // Pass index
//             totalPages: onboardingData.length, // Pass total pages
//           );
//         },
//       ),
//     );
//   }
// }

// class OnboardingPage extends StatefulWidget {
//   final int currentIndex;
//   final int totalPages;

//   final OnboardingModel model;
//   final PageController controller;
//   const OnboardingPage({
//     super.key,
//     required this.model,
//     required this.controller,
//     required this.currentIndex,
//     required this.totalPages,
//   });

//   @override
//   State<OnboardingPage> createState() => _OnboardingPageState();
// }

// class _OnboardingPageState extends State<OnboardingPage>
//     with TickerProviderStateMixin {
//   late AnimationController _imageController;
//   late Animation<Offset> _imageAnimation;

//   late AnimationController _textController;
//   late Animation<Offset> _textAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _imageController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );
//     _textController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );

//     _imageAnimation = Tween<Offset>(
//       begin:
//           widget.model.mode == 0 ? const Offset(-1.5, 0) : const Offset(1.5, 0),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _imageController, curve: Curves.easeOut));

//     _textAnimation = Tween<Offset>(
//       begin:
//           widget.model.mode == 0 ? const Offset(0, 1.5) : const Offset(0, -1.5),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

//     _imageController.forward();
//     _textController.forward();
//   }

//   @override
//   void dispose() {
//     _imageController.dispose();
//     _textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mode = widget.model.mode;

//     return SafeArea(
//       child: Stack(
//         children: [
//           // Background SVG circle
//           if (mode == 0)
//             Positioned(top: -100, left: -180, child: buildCircle(context, mode))
//           else
//             Positioned(
//               top: -100,
//               right: -180,
//               child: buildCircle(context, mode),
//             ),

//           // Main image animation
//           Positioned(
//             top: 80,
//             left: mode == 0 ? 55 : null,
//             right: mode == 1 ? 55 : null,
//             child: SlideTransition(
//               position: _imageAnimation,
//               child: Container(
//                 height: 300,
//                 width: 300,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   image: DecorationImage(
//                     image: AssetImage(widget.model.image),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Animated text content
//           //           Align(
//           //             alignment: mode == 0 ? Alignment.bottomCenter : Alignment.topCenter,
//           //             child: Padding(
//           //               padding: const EdgeInsets.symmetric(
//           //                 horizontal: 24.0,
//           //               ).copyWith(bottom: mode == 0 ? 120 : 0, top: mode == 1 ? 120 : 0),
//           //               child: SlideTransition(
//           //                 position: _textAnimation,
//           //                 child: Column(
//           //                   mainAxisSize: MainAxisSize.min,
//           //                   children: [
//           //                     Text(
//           //                       widget.model.title,
//           //                       style: const TextStyle(
//           //                         fontSize: 22,
//           //                         fontWeight: FontWeight.bold,
//           //                         color: Colors.black87,
//           //                       ),
//           //                       textAlign: TextAlign.center,
//           //                     ),
//           //                     const SizedBox(height: 12),
//           //                     Text(
//           //                       widget.model.description,
//           //                       style: const TextStyle(
//           //                         fontSize: 14,
//           //                         color: Colors.black54,
//           //                       ),
//           //                       textAlign: TextAlign.center,
//           //                     ),
//           //                     const SizedBox(height: 24),
//           //                     GestureDetector(
//           //                       onTap: () {
//           //                         widget.controller.nextPage(
//           //                           duration: const Duration(milliseconds: 500),
//           //                           curve: Curves.easeInOut,
//           //                         );
//           //                       },
//           //                       child: Container(
//           //                         width: double.infinity,
//           //                         height: 48,
//           //                         decoration: BoxDecoration(
//           //                           color: const Color(0xFF0B8FAC),
//           //                           borderRadius: BorderRadius.circular(8),
//           //                         ),
//           //                         child: const Center(
//           //                           child: Text(
//           //                             'Next',
//           //                             style: TextStyle(
//           //                               color: Colors.white,
//           //                               fontWeight: FontWeight.bold,
//           //                             ),
//           //                           ),
//           //                         ),
//           //                       ),
//           //                     ),
//           //                     const SizedBox(height: 12),
//           //                     const Text(
//           //                       'Skip',
//           //                       style: TextStyle(color: Colors.black38, fontSize: 14),
//           //                     ),
//           //                   ],
//           //                 ),
//           //               ),
//           //             ),
//           //           ),
//           //         ],
//           //       ),
//           //     );
//           //   }

//           //   Widget _buildCircle() {
//           //     return Container(
//           //       height: 350,
//           //       width: 350,
//           //       decoration: const BoxDecoration(
//           //         color: Color(0xFF0B8FAC),
//           //         shape: BoxShape.circle,
//           //       ),
//           //     );
//           //   }
//           // }
//           // Positioned(
//           //   bottom: 50,
//           //   left: mode == 0 ? 24 : null,
//           //   right: mode == 1 ? 24 : null,
//           //   child: SvgPicture.asset(
//           //     Imagestyles.imageUnderNextButton,
//           //     height: 216, // Adjust as needed
//           //     width: 216,
//           //   ),
//           // ),
//           Positioned(
//             top: 400,
//             left: 24,
//             right: 24,
//             child: SlideTransition(
//               position: _textAnimation,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Center(
//                     child: Text(
//                       widget.model.title,
//                       style: FontStyles.style28wight500.copyWith(
//                         color: Colors.black87,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Center(
//                     child: Text(
//                       widget.model.description,
//                       style: FontStyles.style14wight400.copyWith(
//                         color: Colors.black54,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   GestureDetector(
//                     onTap: () {
//                       if (widget.currentIndex == widget.totalPages - 1) {
//                         // Last page: navigate to another screen
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => PersonsView(),
//                           ),
//                         );
//                       } else {
//                         // Otherwise: go to next page
//                         widget.controller.nextPage(
//                           duration: const Duration(milliseconds: 500),
//                           curve: Curves.easeInOut,
//                         );
//                       }
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       height: 48,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF0B8FAC),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Center(
//                         child: Text(
//                           widget.currentIndex == widget.totalPages - 1
//                               ? 'Get Started'
//                               : 'Next',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => PersonsView()),
//                       );
//                     },
//                     child: const Text(
//                       'Skip',
//                       style: TextStyle(color: Colors.black38, fontSize: 14),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget buildCircle(context, int mode) => Stack(
//   children: [
//     // Circle at the back
//     Container(
//       height: 350,
//       width: 350,
//       decoration: const BoxDecoration(
//         color: Color(0xFF0B8FAC),
//         shape: BoxShape.circle,
//       ),
//     ),

//     // Arrow on top of the circle
//     // Positioned(
//     //   top: 115,
//     //   left: mode == 0 ? 195 : -50, // Adjusted based on mode

//     //   child: GestureDetector(
//     //     onTap: () {
//     //       Navigator.pop(context);
//     //     },
//     //     child: SvgPicture.asset(
//     //       Imagestyles.goBack,
//     //       height: 30, // Optional: set size
//     //       width: 30,
//     //     ),
//     //   ),
//     // ),
//   ],
// );
