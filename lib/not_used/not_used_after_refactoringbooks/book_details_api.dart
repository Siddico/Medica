// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:medical/Constants/responsive_font_styles.dart';
// import 'package:medical/Constants/responsive_utils.dart';
// import 'package:medical/Features/BooksView/book_ai_chat_screen.dart';
// import 'package:medical/Features/BooksView/pdf_viewer_screen.dart';
// import 'package:medical/Models/book.dart';
// import 'package:medical/Services/books_service.dart';

// class BookDetailsApi extends StatelessWidget {
//   final Book book;

//   const BookDetailsApi({required this.book, super.key});

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
//                           child:
//                               book.thumbnail.isNotEmpty
//                                   ? Image.network(
//                                     book.thumbnail,
//                                     width: responsive.getResponsiveSize(200),
//                                     height: responsive.getResponsiveSize(300),
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return Container(
//                                         width: responsive.getResponsiveSize(
//                                           200,
//                                         ),
//                                         height: responsive.getResponsiveSize(
//                                           300,
//                                         ),
//                                         color: Colors.grey[300],
//                                         child: Icon(
//                                           Icons.book,
//                                           size: responsive.getResponsiveSize(
//                                             100,
//                                           ),
//                                           color: Colors.grey[600],
//                                         ),
//                                       );
//                                     },
//                                   )
//                                   : Container(
//                                     width: responsive.getResponsiveSize(200),
//                                     height: responsive.getResponsiveSize(300),
//                                     color: Colors.grey[300],
//                                     child: Icon(
//                                       Icons.book,
//                                       size: responsive.getResponsiveSize(100),
//                                       color: Colors.grey[600],
//                                     ),
//                                   ),
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
//                     child: AuthorCardApi(
//                       responsive: responsive,
//                       authors: book.authors,
//                     ),
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
//                       AboutBookSectionApi(book: book),
//                       SizedBox(height: responsive.getResponsiveSize(24)),
//                       BookInfoSectionApi(book: book),
//                       SizedBox(height: responsive.getResponsiveSize(24)),
//                       BottomActionsApi(book: book),
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
//                           child:
//                               book.thumbnail.isNotEmpty
//                                   ? Image.network(
//                                     book.thumbnail,
//                                     width: responsive.getResponsiveSize(150),
//                                     height: responsive.getResponsiveSize(200),
//                                     fit: BoxFit.cover,
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return Container(
//                                         width: responsive.getResponsiveSize(
//                                           150,
//                                         ),
//                                         height: responsive.getResponsiveSize(
//                                           200,
//                                         ),
//                                         color: Colors.grey[300],
//                                         child: Icon(
//                                           Icons.book,
//                                           size: responsive.getResponsiveSize(
//                                             50,
//                                           ),
//                                           color: Colors.grey[600],
//                                         ),
//                                       );
//                                     },
//                                   )
//                                   : Container(
//                                     width: responsive.getResponsiveSize(150),
//                                     height: responsive.getResponsiveSize(200),
//                                     color: Colors.grey[300],
//                                     child: Icon(
//                                       Icons.book,
//                                       size: responsive.getResponsiveSize(50),
//                                       color: Colors.grey[600],
//                                     ),
//                                   ),
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
//                         AboutBookSectionApi(book: book),
//                         SizedBox(height: responsive.getResponsiveSize(24)),
//                         BookInfoSectionApi(book: book),
//                         SizedBox(height: responsive.getResponsiveSize(24)),
//                         BottomActionsApi(book: book),
//                         SizedBox(height: responsive.getResponsiveSize(75)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Positioned(
//                 left: responsive.getResponsiveSize(85),
//                 top: responsive.getResponsiveSize(280),
//                 child: AuthorCardApi(
//                   responsive: responsive,
//                   authors: book.authors,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//   }
// }

// class AuthorCardApi extends StatelessWidget {
//   final ResponsiveUtils responsive;
//   final List<String> authors;

//   const AuthorCardApi({
//     required this.responsive,
//     required this.authors,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final rFonts = context.responsiveFontStyles;
//     final authorName = authors.isNotEmpty ? authors.first : 'Unknown Author';

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
//             backgroundColor: Colors.grey[300],
//             child: Icon(
//               Icons.person,
//               size: responsive.getResponsiveSize(40),
//               color: Colors.grey[600],
//             ),
//           ),
//           SizedBox(height: responsive.getResponsiveSize(8)),
//           Text(
//             authorName,
//             style: rFonts.makeResponsive(
//               GoogleFonts.hankenGrotesk(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black,
//               ),
//             ),
//             textAlign: TextAlign.center,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//           SizedBox(height: responsive.getResponsiveSize(4)),
//           Text(
//             'Author',
//             style: rFonts.makeResponsive(
//               GoogleFonts.hankenGrotesk(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           if (authors.length > 1) ...[
//             SizedBox(height: responsive.getResponsiveSize(4)),
//             Text(
//               '+ ${authors.length - 1} more authors',
//               style: rFonts.makeResponsive(
//                 GoogleFonts.hankenGrotesk(
//                   fontSize: 10,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }

// class AboutBookSectionApi extends StatelessWidget {
//   final Book book;

//   const AboutBookSectionApi({required this.book, super.key});

//   @override
//   Widget build(BuildContext context) {
//     final responsive = ResponsiveUtils(context);
//     final rFonts = context.responsiveFontStyles;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           book.title,
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
//               'Published: ${book.publishedDate}',
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
//           book.description,
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
//               book.pageCount > 0 ? book.pageCount.toString() : 'Unknown',
//               Icons.book_outlined,
//               responsive,
//             ),
//             SizedBox(width: responsive.getResponsiveSize(16)),
//             _buildInfoItem(
//               context,
//               'Language',
//               book.language.toUpperCase(),
//               Icons.language,
//               responsive,
//             ),
//             SizedBox(width: responsive.getResponsiveSize(16)),
//             _buildInfoItem(
//               context,
//               'Type',
//               book.isEbook ? 'E-Book' : 'Book',
//               Icons.menu_book,
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
//               textAlign: TextAlign.center,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BookInfoSectionApi extends StatelessWidget {
//   final Book book;

//   const BookInfoSectionApi({required this.book, super.key});

//   @override
//   Widget build(BuildContext context) {
//     final responsive = ResponsiveUtils(context);
//     final rFonts = context.responsiveFontStyles;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Categories',
//           style: rFonts.makeResponsive(
//             GoogleFonts.hankenGrotesk(
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         SizedBox(height: responsive.getResponsiveSize(12)),
//         Wrap(
//           spacing: responsive.getResponsiveSize(8),
//           runSpacing: responsive.getResponsiveSize(8),
//           children:
//               book.categories.map((category) {
//                 return Container(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: responsive.getResponsiveSize(12),
//                     vertical: responsive.getResponsiveSize(6),
//                   ),
//                   decoration: BoxDecoration(
//                     color: const Color(0xff0B8FAC).withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(
//                       responsive.getResponsiveSize(16),
//                     ),
//                   ),
//                   child: Text(
//                     category,
//                     style: rFonts.makeResponsive(
//                       GoogleFonts.hankenGrotesk(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                         color: const Color(0xff0B8FAC),
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//         ),
//         SizedBox(height: responsive.getResponsiveSize(16)),
//         Text(
//           'Publisher',
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
//           book.publisher,
//           style: rFonts.makeResponsive(
//             GoogleFonts.hankenGrotesk(
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//               color: Colors.black87,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class BottomActionsApi extends StatelessWidget {
//   final Book book;

//   const BottomActionsApi({required this.book, super.key});

//   @override
//   Widget build(BuildContext context) {
//     final responsive = ResponsiveUtils(context);
//     final rFonts = context.responsiveFontStyles;

//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: GestureDetector(
//                 onTap: () {
//                   // Save book functionality
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Book saved to your library'),
//                       duration: Duration(seconds: 2),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   height: responsive.getResponsiveSize(50),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(
//                       responsive.getResponsiveSize(8),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.bookmark_border,
//                         size: responsive.getResponsiveSize(24),
//                         color: const Color(0xff0B8FAC),
//                       ),
//                       SizedBox(width: responsive.getResponsiveSize(8)),
//                       Text(
//                         'Save',
//                         style: rFonts.makeResponsive(
//                           GoogleFonts.hankenGrotesk(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: const Color(0xff0B8FAC),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: responsive.getResponsiveSize(16)),
//             Expanded(
//               child: GestureDetector(
//                 onTap: () {
//                   // Get PDF URL for the book
//                   final pdfUrl = BooksService.getPdfUrlForBook(book);

//                   // Navigate to PDF viewer
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder:
//                           (context) =>
//                               PdfViewerScreen(book: book, pdfUrl: pdfUrl),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   height: responsive.getResponsiveSize(50),
//                   decoration: BoxDecoration(
//                     color: const Color(0xff0B8FAC),
//                     borderRadius: BorderRadius.circular(
//                       responsive.getResponsiveSize(8),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.menu_book_outlined,
//                         size: responsive.getResponsiveSize(24),
//                         color: Colors.white,
//                       ),
//                       SizedBox(width: responsive.getResponsiveSize(8)),
//                       Text(
//                         'Read Now',
//                         style: rFonts.makeResponsive(
//                           GoogleFonts.hankenGrotesk(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: responsive.getResponsiveSize(16)),
//         GestureDetector(
//           onTap: () {
//             // Navigate to AI chat
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => BookAIChatScreen(book: book),
//               ),
//             );
//           },
//           child: Container(
//             height: responsive.getResponsiveSize(50),
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: const Color(0xff0B8FAC).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(
//                 responsive.getResponsiveSize(8),
//               ),
//               border: Border.all(color: const Color(0xff0B8FAC), width: 1),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.chat_bubble_outline,
//                   size: responsive.getResponsiveSize(24),
//                   color: const Color(0xff0B8FAC),
//                 ),
//                 SizedBox(width: responsive.getResponsiveSize(8)),
//                 Text(
//                   'Ask AI About This Book',
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
//       ],
//     );
//   }
// }
