// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:medical/Constants/fontStyles.dart';
// import 'package:medical/Constants/imageStyles.dart';
// import 'package:medical/Constants/responsive_font_styles.dart';
// import 'package:medical/Constants/responsive_utils.dart';

// class BookDetailsResponsive extends StatelessWidget {
//   const BookDetailsResponsive({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final responsive = ResponsiveUtils(context);

//     // Determine if we're in landscape mode
//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;
//     final isTablet = responsive.isTablet;

//     if (isLandscape && isTablet) {
//       // Landscape layout for tablets
//       return Scaffold(
//         backgroundColor: Colors.white,
//         body: Row(
//           children: [
//             // Left side with header
//             Expanded(
//               flex: 5,
//               child: Stack(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: responsive.heightPercent(100),
//                         color: const Color(0xff9ECBD4),
//                         child: Center(
//                           child: Image.asset(
//                             Imagestyles.DoctorsLogo,
//                             width: responsive.getResponsiveSize(200),
//                             height: responsive.getResponsiveSize(300),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   // Back button
//                   Positioned(
//                     top: responsive.getResponsiveSize(40),
//                     left: responsive.getResponsiveSize(20),
//                     child: GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child: Container(
//                         padding: EdgeInsets.all(
//                           responsive.getResponsiveSize(8),
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(
//                             responsive.getResponsiveSize(8),
//                           ),
//                         ),
//                         child: Icon(
//                           Icons.arrow_back,
//                           size: responsive.getResponsiveSize(24),
//                         ),
//                       ),
//                     ),
//                   ),

//                   // Author card
//                   Positioned(
//                     left: responsive.getResponsiveSize(85),
//                     top: responsive.getResponsiveSize(280),
//                     child: AuthorCardResponsive(responsive: responsive),
//                   ),
//                 ],
//               ),
//             ),

//             // Right side with content
//             Expanded(
//               flex: 5,
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.all(responsive.getResponsiveSize(20)),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const AboutBookSectionResponsive(),
//                       SizedBox(height: responsive.getResponsiveSize(24)),
//                       const NewsSectionResponsive(),
//                       SizedBox(height: responsive.getResponsiveSize(24)),
//                       const BottomActionsResponsive(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     } else {
//       // Portrait layout
//       return Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Stack(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     children: [
//                       Container(
//                         height: responsive.getResponsiveSize(320),
//                         width: double.infinity,
//                         color: const Color(0xff9ECBD4),
//                       ),
//                       Positioned(
//                         top: responsive.getResponsiveSize(40),
//                         left: responsive.getResponsiveSize(20),
//                         child: GestureDetector(
//                           onTap: () => Navigator.pop(context),
//                           child: Container(
//                             padding: EdgeInsets.all(
//                               responsive.getResponsiveSize(8),
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(
//                                 responsive.getResponsiveSize(8),
//                               ),
//                             ),
//                             child: Icon(
//                               Icons.arrow_back,
//                               size: responsive.getResponsiveSize(24),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: responsive.getResponsiveSize(100),
//                         left: 0,
//                         right: 0,
//                         child: Center(
//                           child: Image.asset(
//                             Imagestyles.DoctorsLogo,
//                             width: responsive.getResponsiveSize(150),
//                             height: responsive.getResponsiveSize(200),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: responsive.getResponsiveSize(50)),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: responsive.getResponsiveSize(12),
//                     ),
//                     child: Column(
//                       children: [
//                         const AboutBookSectionResponsive(),
//                         SizedBox(height: responsive.getResponsiveSize(24)),
//                         const NewsSectionResponsive(),
//                         SizedBox(height: responsive.getResponsiveSize(24)),
//                         const BottomActionsResponsive(),
//                         SizedBox(height: responsive.getResponsiveSize(75)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Positioned(
//                 left: responsive.getResponsiveSize(85),
//                 top: responsive.getResponsiveSize(280),
//                 child: AuthorCardResponsive(responsive: responsive),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//   }
// }

// class AuthorCardResponsive extends StatelessWidget {
//   final ResponsiveUtils responsive;

//   const AuthorCardResponsive({required this.responsive, super.key});

//   @override
//   Widget build(BuildContext context) {
//     final rFonts = context.responsiveFontStyles;

//     return Container(
//       width: responsive.getResponsiveSize(200),
//       padding: EdgeInsets.all(responsive.getResponsiveSize(16)),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(responsive.getResponsiveSize(12)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: responsive.getResponsiveSize(40),
//             backgroundImage: const AssetImage(Imagestyles.DoctorsLogo),
//           ),
//           SizedBox(height: responsive.getResponsiveSize(8)),
//           Text(
//             'Dr. John Smith',
//             style: rFonts.makeResponsive(
//               GoogleFonts.hankenGrotesk(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           SizedBox(height: responsive.getResponsiveSize(4)),
//           Text(
//             'Cardiologist',
//             style: rFonts.makeResponsive(
//               GoogleFonts.hankenGrotesk(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           SizedBox(height: responsive.getResponsiveSize(8)),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.star,
//                 color: Colors.amber,
//                 size: responsive.getResponsiveSize(16),
//               ),
//               SizedBox(width: responsive.getResponsiveSize(4)),
//               Text(
//                 '4.9',
//                 style: rFonts.makeResponsive(
//                   GoogleFonts.hankenGrotesk(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               SizedBox(width: responsive.getResponsiveSize(4)),
//               Text(
//                 '(2.5k reviews)',
//                 style: rFonts.makeResponsive(
//                   GoogleFonts.hankenGrotesk(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AboutBookSectionResponsive extends StatelessWidget {
//   const AboutBookSectionResponsive({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final responsive = ResponsiveUtils(context);
//     final rFonts = context.responsiveFontStyles;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'World Heart Day',
//           style: rFonts.makeResponsive(
//             GoogleFonts.hankenGrotesk(
//               fontSize: 24,
//               fontWeight: FontWeight.w700,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         SizedBox(height: responsive.getResponsiveSize(8)),
//         Row(
//           children: [
//             Icon(
//               Icons.calendar_today_outlined,
//               size: responsive.getResponsiveSize(16),
//               color: Colors.grey,
//             ),
//             SizedBox(width: responsive.getResponsiveSize(4)),
//             Text(
//               'Published: September 29, 2023',
//               style: rFonts.makeResponsive(
//                 GoogleFonts.hankenGrotesk(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: responsive.getResponsiveSize(16)),
//         Text(
//           'About',
//           style: rFonts.makeResponsive(
//             GoogleFonts.hankenGrotesk(
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         SizedBox(height: responsive.getResponsiveSize(8)),
//         Text(
//           'World Heart Day is celebrated every year on September 29. This special day was created to inform people around the world about cardiovascular diseases, which are the leading cause of death globally. The day promotes preventative measures to reduce the risk of cardiovascular diseases.',
//           style: rFonts.makeResponsive(
//             GoogleFonts.hankenGrotesk(
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//               color: Colors.black87,
//               height: 1.5,
//             ),
//           ),
//         ),
//         SizedBox(height: responsive.getResponsiveSize(16)),
//         Row(
//           children: [
//             _buildInfoItem(
//               context,
//               'Pages',
//               '124',
//               Icons.book_outlined,
//               responsive,
//             ),
//             SizedBox(width: responsive.getResponsiveSize(16)),
//             _buildInfoItem(
//               context,
//               'Language',
//               'English',
//               Icons.language,
//               responsive,
//             ),
//             SizedBox(width: responsive.getResponsiveSize(16)),
//             _buildInfoItem(
//               context,
//               'Audio',
//               'Available',
//               Icons.headphones,
//               responsive,
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildInfoItem(
//     BuildContext context,
//     String label,
//     String value,
//     IconData icon,
//     ResponsiveUtils responsive,
//   ) {
//     final rFonts = context.responsiveFontStyles;

//     return Expanded(
//       child: Container(
//         padding: EdgeInsets.all(responsive.getResponsiveSize(8)),
//         decoration: BoxDecoration(
//           color: Colors.grey.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(responsive.getResponsiveSize(8)),
//         ),
//         child: Column(
//           children: [
//             Icon(
//               icon,
//               size: responsive.getResponsiveSize(20),
//               color: const Color(0xff0B8FAC),
//             ),
//             SizedBox(height: responsive.getResponsiveSize(4)),
//             Text(
//               label,
//               style: rFonts.makeResponsive(
//                 GoogleFonts.hankenGrotesk(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//             SizedBox(height: responsive.getResponsiveSize(2)),
//             Text(
//               value,
//               style: rFonts.makeResponsive(
//                 GoogleFonts.hankenGrotesk(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class NewsSectionResponsive extends StatelessWidget {
//   const NewsSectionResponsive({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final responsive = ResponsiveUtils(context);
//     final rFonts = context.responsiveFontStyles;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Latest News',
//           style: rFonts.makeResponsive(
//             GoogleFonts.hankenGrotesk(
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         SizedBox(height: responsive.getResponsiveSize(12)),
//         _buildNewsItem(
//           context,
//           'New Research on Heart Health',
//           'Recent studies show that regular exercise can reduce heart disease risk by up to 30%.',
//           '2 hours ago',
//           responsive,
//         ),
//         SizedBox(height: responsive.getResponsiveSize(12)),
//         _buildNewsItem(
//           context,
//           'Healthy Diet Tips',
//           'Incorporating more fruits, vegetables, and whole grains can significantly improve heart health.',
//           '1 day ago',
//           responsive,
//         ),
//       ],
//     );
//   }

//   Widget _buildNewsItem(
//     BuildContext context,
//     String title,
//     String content,
//     String time,
//     ResponsiveUtils responsive,
//   ) {
//     final rFonts = context.responsiveFontStyles;

//     return Container(
//       padding: EdgeInsets.all(responsive.getResponsiveSize(12)),
//       decoration: BoxDecoration(
//         color: Colors.grey.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(responsive.getResponsiveSize(8)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   title,
//                   style: rFonts.makeResponsive(
//                     GoogleFonts.hankenGrotesk(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: responsive.getResponsiveSize(8),
//                   vertical: responsive.getResponsiveSize(4),
//                 ),
//                 decoration: BoxDecoration(
//                   color: const Color(0xff0B8FAC).withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(
//                     responsive.getResponsiveSize(4),
//                   ),
//                 ),
//                 child: Text(
//                   time,
//                   style: rFonts.makeResponsive(
//                     GoogleFonts.hankenGrotesk(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: const Color(0xff0B8FAC),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: responsive.getResponsiveSize(8)),
//           Text(
//             content,
//             style: rFonts.makeResponsive(
//               GoogleFonts.hankenGrotesk(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BottomActionsResponsive extends StatelessWidget {
//   const BottomActionsResponsive({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final responsive = ResponsiveUtils(context);
//     final rFonts = context.responsiveFontStyles;

//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             height: responsive.getResponsiveSize(50),
//             decoration: BoxDecoration(
//               color: Colors.grey.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(
//                 responsive.getResponsiveSize(8),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.bookmark_border,
//                   size: responsive.getResponsiveSize(24),
//                   color: const Color(0xff0B8FAC),
//                 ),
//                 SizedBox(width: responsive.getResponsiveSize(8)),
//                 Text(
//                   'Save',
//                   style: rFonts.makeResponsive(
//                     GoogleFonts.hankenGrotesk(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: const Color(0xff0B8FAC),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(width: responsive.getResponsiveSize(16)),
//         Expanded(
//           child: Container(
//             height: responsive.getResponsiveSize(50),
//             decoration: BoxDecoration(
//               color: const Color(0xff0B8FAC),
//               borderRadius: BorderRadius.circular(
//                 responsive.getResponsiveSize(8),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.menu_book_outlined,
//                   size: responsive.getResponsiveSize(24),
//                   color: Colors.white,
//                 ),
//                 SizedBox(width: responsive.getResponsiveSize(8)),
//                 Text(
//                   'Read Now',
//                   style: rFonts.makeResponsive(
//                     GoogleFonts.hankenGrotesk(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
