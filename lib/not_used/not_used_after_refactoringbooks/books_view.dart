// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:medical/Constants/constants.dart';
// import 'package:medical/Constants/fontStyles.dart';
// import 'package:medical/Constants/imageStyles.dart';
// import 'package:medical/Features/BooksView/not_used_after_refactoring/book_details.dart';

// class BooksView extends StatelessWidget {
//   const BooksView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFfffff),
//       // appBar: const CustomAppBar(),
//       body: const HomeBody(),
//       bottomNavigationBar: const CustomBottomNavigation(),
//     );
//   }
// }

// // ---------------- Widgets ----------------

// class HomeBody extends StatelessWidget {
//   const HomeBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 12.0,
//                   vertical: 12,
//                 ),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       onPressed: () {},
//                       icon: Icon(Icons.menu, color: Colors.black, size: 24),
//                     ),
//                     IconButton(
//                       onPressed: () {},
//                       icon: Icon(Icons.notifications_none, color: Colors.black),
//                     ),
//                     Spacer(),
//                     CircleAvatar(
//                       // backgroundColor: Colors.black,
//                       radius: 22,
//                       backgroundImage: AssetImage(
//                         Imagestyles.DoctorsLogo,
//                       ), // Your profile image
//                     ),
//                   ],
//                 ),
//               ),
//               const FeaturedReport(),
//               const SizedBox(height: 20),
//               const SectionTitle(title: "Recommended for you"),
//               const RecommendedList(),
//               const SizedBox(height: 20),
//               const SectionTitle(title: "Popular books"),
//               const PopularBooksList(),
//             ],
//           ),

//           Positioned(
//             top: 0,
//             right: 0,
//             child: SvgPicture.asset(
//               Imagestyles.backOfBookView,
//               fit: BoxFit.fill,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FeaturedReport extends StatelessWidget {
//   const FeaturedReport({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
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
//             width: 80,
//             height: 120,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               image: const DecorationImage(
//                 image: AssetImage(Imagestyles.DoctorsLogo),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "The Annual report",
//                   style: FontStyles.style32weight800.copyWith(
//                     fontSize: 24,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   "The psychology of money is the study of our behavior with money. Success with money isn't about knowledge, IQ or how good you are at math. It's about behavior, and everyone is prone to certain behaviors over others.",
//                   style: GoogleFonts.hankenGrotesk(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff9091A0),
//                   ),
//                   // maxLines: 3,
//                   // overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   children: [
//                     Container(
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

//                     const SizedBox(width: 8),
//                     TextButton(
//                       onPressed: () {},
//                       child: Text(
//                         "Learn More",
//                         style: GoogleFonts.hankenGrotesk(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xff4D506C),
//                         ),
//                       ),
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

// class SectionTitle extends StatelessWidget {
//   final String title;
//   const SectionTitle({required this.title, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Text(
//         title,
//         style: GoogleFonts.hankenGrotesk(
//           fontSize: 20,
//           color: Colors.black,
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//     );
//   }
// }

// class RecommendedList extends StatelessWidget {
//   const RecommendedList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final recommended = [
//       Imagestyles.DoctorsLogo,
//       Imagestyles.DoctorsLogo,
//       Imagestyles.DoctorsLogo,
//     ];
//     return SizedBox(
//       height: 180,
//       child: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         scrollDirection: Axis.horizontal,
//         itemCount: recommended.length,
//         itemBuilder: (context, index) {
//           return Container(
//             width: 120,
//             margin: const EdgeInsets.only(right: 16),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               image: DecorationImage(
//                 image: AssetImage(recommended[index]),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class PopularBooksList extends StatelessWidget {
//   const PopularBooksList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final books = [
//       {
//         "title": "The Steal Like An Artist",
//         "author": "Austin Kleon",
//         "rating": 5.0,
//       },
//       {"title": "Laws of UX", "author": "Jon Yablonski", "rating": 4.8},
//       {"title": "A Million To One", "author": "Tony Faggioli", "rating": 5.0},
//     ];

//     return ListView.builder(
//       shrinkWrap: true,
//       padding: const EdgeInsets.all(16),
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: books.length,
//       itemBuilder: (context, index) {
//         final book = books[index];
//         return Container(
//           margin: const EdgeInsets.only(bottom: 16),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: const Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               Container(
//                 height: 120,
//                 width: 85,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade200,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Image.asset(Imagestyles.DoctorsLogo),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${book["title"]}',
//                       style: GoogleFonts.hankenGrotesk(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700,
//                         color: Color(0xff4D506C),
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '${book["author"]}',
//                       style: GoogleFonts.hankenGrotesk(
//                         fontSize: 10,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xff4D506C),
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         Text(
//                           "${book["rating"]}",
//                           style: GoogleFonts.hankenGrotesk(
//                             fontSize: 8,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff0B8FAC),
//                           ),
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           " | 23k Reviews",
//                           style: GoogleFonts.hankenGrotesk(
//                             fontSize: 8,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff4D506C),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Text(
//                       r"$45.78",
//                       style: GoogleFonts.hankenGrotesk(
//                         fontSize: 10,
//                         fontWeight: FontWeight.w500,
//                         color: Color(0xff4D506C),
//                       ),
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
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class CustomBottomNavigation extends StatelessWidget {
//   const CustomBottomNavigation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       backgroundColor: Colors.white,
//       selectedItemColor: Colors.teal,
//       unselectedItemColor: Colors.grey,
//       showSelectedLabels: false,
//       showUnselectedLabels: false,
//       items: const [
//         BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.access_time),
//           label: "History",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.chat_bubble_outline),
//           label: "Chat",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.settings_outlined),
//           label: "Settings",
//         ),
//       ],
//     );
//   }
// }
