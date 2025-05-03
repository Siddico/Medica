// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:medical/Constants/imageStyles.dart';
// import 'package:medical/Constants/responsive_font_styles.dart';
// import 'package:medical/Constants/responsive_utils.dart';
// import 'package:medical/Features/BooksView/not_used_after_refactoring/book_details_api.dart';
// import 'package:medical/Features/BooksView/pdf_viewer_screen.dart';
// import 'package:medical/Models/book.dart';
// import 'package:medical/Services/books_service.dart';

// class BooksViewApi extends StatefulWidget {
//   const BooksViewApi({super.key});

//   @override
//   State<BooksViewApi> createState() => _BooksViewApiState();
// }

// class _BooksViewApiState extends State<BooksViewApi> {
//   late Future<List<Book>> _booksFuture;
//   bool _isLoading = true;
//   String _errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadBooks();
//   }

//   void _loadBooks() {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });

//     _booksFuture = BooksService.fetchMedicalBooks();

//     _booksFuture
//         .then((_) {
//           if (mounted) {
//             setState(() {
//               _isLoading = false;
//             });
//           }
//         })
//         .catchError((error) {
//           if (mounted) {
//             setState(() {
//               _isLoading = false;
//               _errorMessage = 'Failed to load books: ${error.toString()}';
//             });
//           }
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final responsive = ResponsiveUtils(context);
//     final rFonts = context.responsiveFontStyles;

//     // Determine if we're in landscape mode
//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: SvgPicture.asset(
//             Imagestyles.goBack,
//             width: responsive.getResponsiveSize(24),
//             height: responsive.getResponsiveSize(24),
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Medical Books',
//           style: rFonts.style22weight700.copyWith(color: Colors.black),
//         ),
//         centerTitle: true,
//       ),
//       body:
//           _isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : _errorMessage.isNotEmpty
//               ? _buildErrorView()
//               : _buildBooksView(context, responsive, rFonts, isLandscape),
//     );
//   }

//   Widget _buildErrorView() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.error_outline, size: 48, color: Colors.red),
//           const SizedBox(height: 16),
//           Text(
//             _errorMessage,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 16),
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton(
//             onPressed: _loadBooks,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xff0B8FAC),
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             ),
//             child: const Text('Try Again'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBooksView(
//     BuildContext context,
//     ResponsiveUtils responsive,
//     ResponsiveFontStyles rFonts,
//     bool isLandscape,
//   ) {
//     return FutureBuilder<List<Book>>(
//       future: _booksFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.error_outline, size: 48, color: Colors.red),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Error: ${snapshot.error}',
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(fontSize: 16),
//                 ),
//                 const SizedBox(height: 24),
//                 ElevatedButton(
//                   onPressed: _loadBooks,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xff0B8FAC),
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                       vertical: 12,
//                     ),
//                   ),
//                   child: const Text('Try Again'),
//                 ),
//               ],
//             ),
//           );
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.book_outlined, size: 48, color: Colors.grey),
//                 const SizedBox(height: 16),
//                 const Text('No books found', style: TextStyle(fontSize: 18)),
//                 const SizedBox(height: 24),
//                 ElevatedButton(
//                   onPressed: _loadBooks,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xff0B8FAC),
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                       vertical: 12,
//                     ),
//                   ),
//                   child: const Text('Refresh'),
//                 ),
//               ],
//             ),
//           );
//         }

//         final books = snapshot.data!;

//         if (isLandscape && responsive.isTablet) {
//           // Grid layout for landscape tablets
//           return Padding(
//             padding: EdgeInsets.all(responsive.getResponsiveSize(16)),
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.7,
//                 crossAxisSpacing: responsive.getResponsiveSize(16),
//                 mainAxisSpacing: responsive.getResponsiveSize(16),
//               ),
//               itemCount: books.length,
//               itemBuilder: (context, index) {
//                 return _buildBookCard(
//                   context,
//                   books[index],
//                   responsive,
//                   rFonts,
//                 );
//               },
//             ),
//           );
//         } else {
//           // List layout for portrait mode or smaller screens
//           return ListView.builder(
//             padding: EdgeInsets.all(responsive.getResponsiveSize(16)),
//             itemCount: books.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: EdgeInsets.only(
//                   bottom: responsive.getResponsiveSize(16),
//                 ),
//                 child: _buildBookCard(
//                   context,
//                   books[index],
//                   responsive,
//                   rFonts,
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//   }

//   Widget _buildBookCard(
//     BuildContext context,
//     Book book,
//     ResponsiveUtils responsive,
//     ResponsiveFontStyles rFonts,
//   ) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => BookDetailsApi(book: book)),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(responsive.getResponsiveSize(12)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Book cover
//             ClipRRect(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(responsive.getResponsiveSize(12)),
//                 topRight: Radius.circular(responsive.getResponsiveSize(12)),
//               ),
//               child: Container(
//                 height: responsive.getResponsiveSize(200),
//                 width: double.infinity,
//                 color: Colors.grey[200],
//                 child:
//                     book.thumbnail.isNotEmpty
//                         ? Image.network(
//                           book.thumbnail,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Center(
//                               child: Icon(
//                                 Icons.book,
//                                 size: responsive.getResponsiveSize(50),
//                                 color: Colors.grey[400],
//                               ),
//                             );
//                           },
//                         )
//                         : Center(
//                           child: Icon(
//                             Icons.book,
//                             size: responsive.getResponsiveSize(50),
//                             color: Colors.grey[400],
//                           ),
//                         ),
//               ),
//             ),

//             // Book details
//             Padding(
//               padding: EdgeInsets.all(responsive.getResponsiveSize(12)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     book.title,
//                     style: rFonts.style18weight400,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(height: responsive.getResponsiveSize(4)),
//                   Text(
//                     book.authors.join(', '),
//                     style: rFonts.style14wight400.copyWith(
//                       color: Colors.grey[600],
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(height: responsive.getResponsiveSize(8)),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.calendar_today_outlined,
//                         size: responsive.getResponsiveSize(14),
//                         color: Colors.grey[600],
//                       ),
//                       SizedBox(width: responsive.getResponsiveSize(4)),
//                       Text(
//                         book.publishedDate,
//                         style: rFonts.style18weight400.copyWith(
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: responsive.getResponsiveSize(12)),
//                   GestureDetector(
//                     onTap: () {
//                       // Get PDF URL for the book
//                       final pdfUrl = BooksService.getPdfUrlForBook(book);

//                       // Navigate to PDF viewer
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder:
//                               (context) =>
//                                   PdfViewerScreen(book: book, pdfUrl: pdfUrl),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       height: responsive.getResponsiveSize(40),
//                       decoration: BoxDecoration(
//                         color: const Color(0xff0B8FAC),
//                         borderRadius: BorderRadius.circular(
//                           responsive.getResponsiveSize(8),
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Grab Now',
//                           style: rFonts.style16weight700.copyWith(
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
