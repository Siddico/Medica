// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:medical/Constants/constants.dart';
// import 'package:medical/Constants/fontStyles.dart';
// import 'package:medical/Constants/imageStyles.dart';
// import 'package:medical/Constants/responsive_font_styles.dart';
// import 'package:medical/Constants/responsive_utils.dart';
// import 'package:medical/Features/BooksView/not_used_after_refactoring/book_details.dart';

// class BooksViewResponsive extends StatelessWidget {
//   const BooksViewResponsive({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final responsive = ResponsiveUtils(context);

//     return Scaffold(
//       backgroundColor: const Color(0xFFFfffff),
//       body: const HomeBodyResponsive(),
//       bottomNavigationBar: CustomBottomNavigationResponsive(
//         responsive: responsive,
//       ),
//     );
//   }
// }

// // Responsive home body
// class HomeBodyResponsive extends StatelessWidget {
//   const HomeBodyResponsive({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final responsive = ResponsiveUtils(context);

//     // Determine if we're in landscape mode
//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;
//     final isTablet = responsive.isTablet;

//     // For landscape mode on tablets, we'll use a two-column layout
//     if (isLandscape && isTablet) {
//       return Stack(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Left column
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: EdgeInsets.all(responsive.getResponsiveSize(16)),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // SizedBox(height: responsive.getResponsiveSize(80)), // Space for the background SVG
//                         const CustomAppBarResponsive(),
//                         SizedBox(height: responsive.getResponsiveSize(20)),
//                         const FeaturedReportResponsive(),
//                         SizedBox(height: responsive.getResponsiveSize(20)),
//                         SectionTitleResponsive(title: "Recommended for you"),
//                         const RecommendedListResponsive(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),

//               // Right column
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: EdgeInsets.all(responsive.getResponsiveSize(16)),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: responsive.getResponsiveSize(80),
//                         ), // Space for the background SVG
//                         SizedBox(height: responsive.getResponsiveSize(20)),
//                         SectionTitleResponsive(title: "Popular books"),
//                         const PopularBooksListResponsive(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           // Background SVG
//           Positioned(
//             top: 0,
//             right: 0,
//             child: SvgPicture.asset(
//               Imagestyles.backOfBookView,
//               width: responsive.getResponsiveSize(200),
//               height: responsive.getResponsiveSize(200),
//               fit: BoxFit.fill,
//             ),
//           ),
//         ],
//       );
//     } else {
//       // Portrait mode or smaller screens use a single column layout
//       return Stack(
//         children: [
//           SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.all(responsive.getResponsiveSize(16)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: responsive.getResponsiveSize(80),
//                   ), // Space for the background SVG
//                   const CustomAppBarResponsive(),
//                   SizedBox(height: responsive.getResponsiveSize(20)),
//                   const FeaturedReportResponsive(),
//                   SizedBox(height: responsive.getResponsiveSize(20)),
//                   SectionTitleResponsive(title: "Recommended for you"),
//                   const RecommendedListResponsive(),
//                   SizedBox(height: responsive.getResponsiveSize(20)),
//                   SectionTitleResponsive(title: "Popular books"),
//                   const PopularBooksListResponsive(),
//                 ],
//               ),
//             ),
//           ),

//           // Background SVG
//           Positioned(
//             top: 0,
//             right: 0,
//             child: SvgPicture.asset(
//               Imagestyles.backOfBookView,
//               width: responsive.getResponsiveSize(200),
//               height: responsive.getResponsiveSize(200),
//               fit: BoxFit.fill,
//             ),
//           ),
//         ],
//       );
//     }
//   }
// }

// // Responsive featured report
// class FeaturedReportResponsive extends StatelessWidget {
//   const FeaturedReportResponsive({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final responsive = ResponsiveUtils(context);
//     final rFonts = context.responsiveFontStyles;

//     final cardPadding = responsive.getResponsiveSize(16);
//     final imageHeight = responsive.getResponsiveSize(120);
//     final imageWidth = responsive.getResponsiveSize(80);
//     final borderRadius = responsive.getResponsiveSize(16);

//     return Container(
//       margin: EdgeInsets.all(responsive.getResponsiveSize(4)),
//       padding: EdgeInsets.all(cardPadding),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(borderRadius),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: imageWidth,
//             height: imageHeight,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(borderRadius / 2),
//               image: const DecorationImage(
//                 image: AssetImage(Imagestyles.DoctorsLogo),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SizedBox(width: responsive.getResponsiveSize(16)),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'World Heart Day',
//                   style: rFonts.makeResponsive(
//                     GoogleFonts.hankenGrotesk(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w700,
//                       color: const Color(0xff4D506C),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: responsive.getResponsiveSize(4)),
//                 Text(
//                   'Dr. John Smith',
//                   style: rFonts.makeResponsive(
//                     GoogleFonts.hankenGrotesk(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w600,
//                       color: const Color(0xff4D506C),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: responsive.getResponsiveSize(4)),
//                 Row(
//                   children: [
//                     Text(
//                       "4.5",
//                       style: rFonts.makeResponsive(
//                         GoogleFonts.hankenGrotesk(
//                           fontSize: 8,
//                           fontWeight: FontWeight.w400,
//                           color: const Color(0xff0B8FAC),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: responsive.getResponsiveSize(4)),
//                     Text(
//                       " | 23k Reviews",
//                       style: rFonts.makeResponsive(
//                         GoogleFonts.hankenGrotesk(
//                           fontSize: 8,
//                           fontWeight: FontWeight.w400,
//                           color: const Color(0xff4D506C),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: responsive.getResponsiveSize(8)),
//                 Text(
//                   'Learn about heart health and preventive measures for a healthy cardiovascular system.',
//                   style: rFonts.makeResponsive(
//                     GoogleFonts.hankenGrotesk(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w400,
//                       color: const Color(0xff4D506C),
//                     ),
//                   ),
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: responsive.getResponsiveSize(8)),

//                 // GestureDetector(
//                 //   onTap: () {
//                 //     Navigator.push(
//                 //       context,
//                 //       MaterialPageRoute(
//                 //         builder: (context) => const BookDetailsResponsive(),
//                 //       ),
//                 //     );
//                 //   },
//                 //   child: Container(
//                 //     padding: EdgeInsets.symmetric(
//                 //       horizontal: responsive.getResponsiveSize(12),
//                 //       vertical: responsive.getResponsiveSize(6),
//                 //     ),
//                 //     decoration: BoxDecoration(
//                 //       color: const Color(0xff0B8FAC),
//                 //       borderRadius: BorderRadius.circular(borderRadius / 2),
//                 //     ),
//                 //     child: Text(
//                 //       'Read More',
//                 //       style: rFonts.makeResponsive(
//                 //         GoogleFonts.hankenGrotesk(
//                 //           fontSize: 10,
//                 //           fontWeight: FontWeight.w600,
//                 //           color: Colors.white,
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//                 Row(
//                   children: [
//                     Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             NavigateTo(context, WorldHeartDayScreen());
//                           },
//                           child: Container(
//                             width: 90,
//                             height: 27,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: Color(0xff0B8FAC),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 "Grab Now",
//                                 style: GoogleFonts.hankenGrotesk(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),

//                         const SizedBox(width: 8),
//                         TextButton(
//                           onPressed: () {},
//                           child: Text(
//                             "Learn More",
//                             style: GoogleFonts.hankenGrotesk(
//                               fontSize: 10,
//                               fontWeight: FontWeight.w700,
//                               color: Color(0xff4D506C),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Responsive section title
// class SectionTitleResponsive extends StatelessWidget {
//   final String title;
//   const SectionTitleResponsive({required this.title, super.key});

//   @override
//   Widget build(BuildContext context) {
//     final responsive = ResponsiveUtils(context);

//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: responsive.getResponsiveSize(16),
//       ),
//       child: Text(
//         title,
//         style: GoogleFonts.hankenGrotesk(
//           fontSize: responsive.fontSize(20),
//           color: Colors.black,
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//     );
//   }
// }

// // Responsive recommended list
// class RecommendedListResponsive extends StatelessWidget {
//   const RecommendedListResponsive({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final responsive = ResponsiveUtils(context);
//     final rFonts = context.responsiveFontStyles;

//     // Adjust item size based on screen size and orientation
//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;
//     final isTablet = responsive.isTablet;

//     final itemHeight = responsive.getResponsiveSize(220);
//     final itemWidth =
//         isLandscape && isTablet
//             ? responsive.widthPercent(20)
//             : isTablet
//             ? responsive.widthPercent(30)
//             : responsive.widthPercent(40);

//     final books = [
//       {
//         "title": "Medical Ethics",
//         "author": "Dr. Emily Johnson",
//         "rating": "4.8",
//         "image": Imagestyles.DoctorsLogo,
//       },
//       {
//         "title": "Anatomy Basics",
//         "author": "Dr. Michael Chen",
//         "rating": "4.6",
//         "image": Imagestyles.DoctorsLogo,
//       },
//       {
//         "title": "Clinical Practice",
//         "author": "Dr. Sarah Williams",
//         "rating": "4.7",
//         "image": Imagestyles.DoctorsLogo,
//       },
//       {
//         "title": "Pharmacology",
//         "author": "Dr. Robert Miller",
//         "rating": "4.5",
//         "image": Imagestyles.DoctorsLogo,
//       },
//     ];

//     return SizedBox(
//       height: itemHeight,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: books.length,
//         itemBuilder: (context, index) {
//           final book = books[index];
//           return Container(
//             width: itemWidth,
//             margin: EdgeInsets.only(
//               left:
//                   index == 0
//                       ? responsive.getResponsiveSize(16)
//                       : responsive.getResponsiveSize(8),
//               right: responsive.getResponsiveSize(8),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(
//                         responsive.getResponsiveSize(12),
//                       ),
//                       image: DecorationImage(
//                         image: AssetImage(book["image"]!),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: responsive.getResponsiveSize(8)),
//                 Text(
//                   book["title"]!,
//                   style: rFonts.makeResponsive(
//                     GoogleFonts.hankenGrotesk(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w700,
//                       color: const Color(0xff4D506C),
//                     ),
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: responsive.getResponsiveSize(2)),
//                 Text(
//                   book["author"]!,
//                   style: rFonts.makeResponsive(
//                     GoogleFonts.hankenGrotesk(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: const Color(0xff4D506C),
//                     ),
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: responsive.getResponsiveSize(2)),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.star,
//                       color: Colors.amber,
//                       size: responsive.getResponsiveSize(14),
//                     ),
//                     SizedBox(width: responsive.getResponsiveSize(4)),
//                     Text(
//                       book["rating"]!,
//                       style: rFonts.makeResponsive(
//                         GoogleFonts.hankenGrotesk(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                           color: const Color(0xff4D506C),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // Responsive popular books list
// class PopularBooksListResponsive extends StatelessWidget {
//   const PopularBooksListResponsive({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final responsive = ResponsiveUtils(context);
//     final rFonts = context.responsiveFontStyles;

//     final books = [
//       {
//         "title": "Cardiology Essentials",
//         "author": "Dr. James Wilson",
//         "rating": "4.9",
//         "image": Imagestyles.DoctorsLogo,
//       },
//       {
//         "title": "Neurology Handbook",
//         "author": "Dr. Lisa Brown",
//         "rating": "4.7",
//         "image": Imagestyles.DoctorsLogo,
//       },
//       {
//         "title": "Pediatric Care",
//         "author": "Dr. David Thompson",
//         "rating": "4.8",
//         "image": Imagestyles.DoctorsLogo,
//       },
//     ];

//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: books.length,
//       itemBuilder: (context, index) {
//         final book = books[index];
//         return Container(
//           margin: EdgeInsets.symmetric(
//             horizontal: responsive.getResponsiveSize(16),
//             vertical: responsive.getResponsiveSize(8),
//           ),
//           padding: EdgeInsets.all(responsive.getResponsiveSize(12)),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(
//               responsive.getResponsiveSize(12),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 blurRadius: 5,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               Container(
//                 width: responsive.getResponsiveSize(60),
//                 height: responsive.getResponsiveSize(80),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(
//                     responsive.getResponsiveSize(8),
//                   ),
//                   image: DecorationImage(
//                     image: AssetImage(book["image"]!),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(width: responsive.getResponsiveSize(16)),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       book["title"]!,
//                       style: rFonts.makeResponsive(
//                         GoogleFonts.hankenGrotesk(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700,
//                           color: const Color(0xff4D506C),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: responsive.getResponsiveSize(4)),
//                     Text(
//                       book["author"]!,
//                       style: rFonts.makeResponsive(
//                         GoogleFonts.hankenGrotesk(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w600,
//                           color: const Color(0xff4D506C),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: responsive.getResponsiveSize(4)),
//                     Row(
//                       children: [
//                         Text(
//                           book["rating"]!,
//                           style: rFonts.makeResponsive(
//                             GoogleFonts.hankenGrotesk(
//                               fontSize: 8,
//                               fontWeight: FontWeight.w400,
//                               color: const Color(0xff0B8FAC),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: responsive.getResponsiveSize(4)),
//                         Text(
//                           " | 23k Reviews",
//                           style: rFonts.makeResponsive(
//                             GoogleFonts.hankenGrotesk(
//                               fontSize: 8,
//                               fontWeight: FontWeight.w400,
//                               color: const Color(0xff4D506C),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Column(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       NavigateTo(context, WorldHeartDayScreen());
//                     },
//                     child: Container(
//                       width: 90,
//                       height: 27,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         color: Color(0xff0B8FAC),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Grab Now",
//                           style: GoogleFonts.hankenGrotesk(
//                             fontSize: 10,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(width: 8),
//                   TextButton(
//                     onPressed: () {},
//                     child: Text(
//                       "Learn More",
//                       style: GoogleFonts.hankenGrotesk(
//                         fontSize: 10,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xff4D506C),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               // Icon(
//               //   Icons.bookmark_border,
//               //   color: const Color(0xff0B8FAC),
//               //   size: responsive.getResponsiveSize(24),
//               // ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// // Responsive custom app bar
// class CustomAppBarResponsive extends StatelessWidget {
//   const CustomAppBarResponsive({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final responsive = ResponsiveUtils(context);
//     final rFonts = context.responsiveFontStyles;

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Hello, Doctor',
//               style: rFonts.makeResponsive(
//                 GoogleFonts.hankenGrotesk(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                   color: const Color(0xff4D506C),
//                 ),
//               ),
//             ),
//             SizedBox(height: responsive.getResponsiveSize(4)),
//             Text(
//               'Find Your Medical Books',
//               style: rFonts.makeResponsive(
//                 GoogleFonts.hankenGrotesk(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         CircleAvatar(
//           radius: responsive.getResponsiveSize(20),
//           backgroundImage: const AssetImage(Imagestyles.DoctorsLogo),
//         ),
//       ],
//     );
//   }
// }

// // Responsive bottom navigation
// class CustomBottomNavigationResponsive extends StatelessWidget {
//   final ResponsiveUtils responsive;

//   const CustomBottomNavigationResponsive({required this.responsive, super.key});

//   @override
//   Widget build(BuildContext context) {
//     final iconSize = responsive.getResponsiveSize(24);
//     final barHeight = responsive.getResponsiveSize(60);

//     return Container(
//       height: barHeight,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 10,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildNavItem(Icons.home_outlined, 'Home', false, iconSize),
//           _buildNavItem(Icons.book_outlined, 'Books', true, iconSize),
//           _buildNavItem(Icons.bookmark_border, 'Saved', false, iconSize),
//           _buildNavItem(Icons.person_outline, 'Profile', false, iconSize),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(
//     IconData icon,
//     String label,
//     bool isActive,
//     double iconSize,
//   ) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           icon,
//           color: isActive ? const Color(0xff0B8FAC) : Colors.grey,
//           size: iconSize,
//         ),
//         SizedBox(height: responsive.getResponsiveSize(4)),
//         Text(
//           label,
//           style: TextStyle(
//             color: isActive ? const Color(0xff0B8FAC) : Colors.grey,
//             fontSize: responsive.fontSize(12),
//             fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
//           ),
//         ),
//       ],
//     );
//   }
// }
