// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:medical/Constants/fontStyles.dart';
// import 'package:medical/Constants/imageStyles.dart';

// class WorldHeartDayScreen extends StatelessWidget {
//   const WorldHeartDayScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Stack(
//                   children: [
//                     Container(
//                       height: 320,
//                       width: double.infinity,
//                       color: Color(0xff9ECBD4),
//                     ),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12.0,
//                         vertical: 12,
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               IconButton(
//                                 icon: const Icon(Icons.menu),
//                                 onPressed: () {},
//                               ),
//                               Stack(
//                                 children: [
//                                   IconButton(
//                                     icon: const Icon(Icons.notifications),
//                                     onPressed: () {},
//                                   ),
//                                   Positioned(
//                                     right: 8,
//                                     top: 8,
//                                     child: Container(
//                                       width: 8,
//                                       height: 8,
//                                       decoration: const BoxDecoration(
//                                         color: Colors.red,
//                                         shape: BoxShape.circle,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Spacer(),
//                               CircleAvatar(
//                                 backgroundImage: AssetImage(
//                                   Imagestyles.DoctorsLogo,
//                                 ), // ضع صورتك هنا
//                                 radius: 18,
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 25),
//                           const BookHeader(),
//                           const SizedBox(height: 16),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 50),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                   child: Column(
//                     children: [
//                       const AboutBookSection(),
//                       const SizedBox(height: 24),
//                       const NewsSection(),
//                       const SizedBox(height: 24),
//                       const BottomActions(),
//                       SizedBox(height: 75),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             Positioned(left: 85, top: 280, child: AuthorCard()),
//           ],
//         ),
//       ),
//       // bottomNavigationBar: const CustomBottomNavigationBar(),
//     );
//   }
// }

// ///--- Book Header Section ---///
// class BookHeader extends StatelessWidget {
//   const BookHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 16.0, right: 16),
//           child: Image.asset(
//             Imagestyles.DoctorsLogo,
//             width: 95,
//             height: 150,
//             fit: BoxFit.cover,
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'World Heart Day',
//                 style: FontStyles.style18weight800.copyWith(
//                   color: Colors.white,
//                   fontSize: 24,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Padding(
//                 padding: const EdgeInsets.only(right: 12.0),
//                 child: Text(
//                   'The psychology of money is the study of our behavior with money. Success with money isn\'t about knowledge, IQ or how good you are at math. It\'s about behavior, and everyone is prone to certain behaviors over others.',
//                   style: GoogleFonts.hankenGrotesk(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xffDDDDE2),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   Icon(Icons.star, color: Color(0xffE7B53F), size: 16),
//                   Icon(Icons.star, color: Color(0xffE7B53F), size: 16),
//                   Icon(Icons.star, color: Color(0xffE7B53F), size: 16),
//                   Icon(Icons.star, color: Color(0xffE7B53F), size: 16),
//                   Icon(Icons.star, color: Color(0xffE7B53F), size: 16),
//                   SizedBox(width: 4),
//                   Text(
//                     '(5.0)',
//                     style: GoogleFonts.hankenGrotesk(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xffffffff),
//                     ),
//                   ),
//                   Spacer(),
//                   IconButton(
//                     icon: const Icon(Icons.bookmark_border, size: 32),
//                     onPressed: () {},
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// ///--- Author Card Section ---///
// class AuthorCard extends StatelessWidget {
//   const AuthorCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 85,
//       width: 350,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundImage: AssetImage(Imagestyles.DoctorsLogo),
//             radius: 24,
//           ),
//           const SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Author',
//                 style: GoogleFonts.hankenGrotesk(
//                   fontSize: 10,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff9091A0),
//                 ),
//               ),
//               Text(
//                 'Morgan Housel',
//                 style: GoogleFonts.hankenGrotesk(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xff4D506C),
//                 ),
//               ),
//               Text(
//                 'Best Seller of New York Times',
//                 style: GoogleFonts.hankenGrotesk(
//                   fontSize: 8,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff9091a0),
//                 ),
//               ),
//             ],
//           ),
//           const Spacer(),
//           const Icon(Icons.star, size: 16, color: Color(0xffC4C4C4)),
//         ],
//       ),
//     );
//   }
// }

// ///--- About The Book Section ---///
// class AboutBookSection extends StatelessWidget {
//   const AboutBookSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'About The Book',
//           style: GoogleFonts.hankenGrotesk(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: Color(0xff4D506C),
//           ),
//         ),
//         SizedBox(height: 8),
//         Text(
//           '''''The Psychology of Money' is an essential read for anyone interested in being better with money. Fast-paced and engaging, this book will help you refine your thoughts towards money. You can finish this book in a week, unlike other books that are too lengthy.

// The most important emotions in relation to money are fear, guilt, shame and envy. It's worth spending some effort to become aware of the emotions that are especially tied to money for you because, without awareness, they will tend to override rational thinking and drive your actions.''',
//           style: GoogleFonts.hankenGrotesk(
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//             color: Color(0xff9091A0),
//           ),
//         ),
//       ],
//     );
//   }
// }

// ///--- News Section ---///
// class NewsSection extends StatelessWidget {
//   const NewsSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'News',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 12),
//         Center(
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Image.asset(Imagestyles.DoctorsLogo),
//           ),
//         ),
//       ],
//     );
//   }
// }

// ///--- Bottom Actions (Read + Icons) ---///
// class BottomActions extends StatelessWidget {
//   const BottomActions({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Wrap(
//         spacing: 12,
//         children: [
//           Container(
//             height: 50,
//             width: 140,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50),
//               color: Color(0xff448092),
//             ),
//             child: Center(
//               child: Text(
//                 'Read',
//                 style: GoogleFonts.roboto(
//                   fontSize: 28,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),

//           IconButton(
//             icon: const Icon(Icons.headphones, color: Colors.black),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.download, color: Colors.black),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.edit, color: Colors.black),
//             onPressed: () {},
//           ),
//           Container(
//             height: 50,
//             width: 50,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50),
//               color: Color(0xff206675),
//             ),
//             child: const Icon(Icons.language, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
// }

// ///--- Bottom Navigation ---///
// // class CustomBottomNavigationBar extends StatelessWidget {
// //   const CustomBottomNavigationBar({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return BottomNavigationBar(
// //       items: const [
// //         BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
// //         BottomNavigationBarItem(icon: Icon(Icons.access_time), label: ''),
// //         BottomNavigationBarItem(
// //           icon: Icon(Icons.chat_bubble_outline),
// //           label: '',
// //         ),
// //         BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
// //       ],
// //       selectedItemColor: Colors.teal,
// //       unselectedItemColor: Colors.black54,
// //       showSelectedLabels: false,
// //       showUnselectedLabels: false,
// //       backgroundColor: Colors.white,
// //       elevation: 10,
// //     );
// //   }
// // }
