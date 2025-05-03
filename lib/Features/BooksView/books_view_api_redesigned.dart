import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/BooksView/book_details_api_redesigned.dart';
import 'package:medical/Features/BooksView/pdf_viewer_screen.dart';
import 'package:medical/Models/book.dart';
import 'package:medical/Services/books_service.dart';

class BooksViewApiRedesigned extends StatefulWidget {
  const BooksViewApiRedesigned({super.key});

  @override
  State<BooksViewApiRedesigned> createState() => _BooksViewApiRedesignedState();
}

class _BooksViewApiRedesignedState extends State<BooksViewApiRedesigned> {
  late Future<List<Book>> _booksFuture;
  bool _isLoading = true;
  String _errorMessage = '';
  List<Book> _featuredBooks = [];
  List<Book> _recommendedBooks = [];
  List<Book> _popularBooks = [];

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  void _loadBooks() {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    _booksFuture = BooksService.fetchMedicalBooks(maxResults: 15);

    _booksFuture
        .then((books) {
          if (mounted) {
            setState(() {
              // Distribute books into different sections
              if (books.isNotEmpty) {
                _featuredBooks = [books.first]; // First book as featured

                // Split remaining books between recommended and popular
                final remainingBooks = books.sublist(1);
                final midPoint = remainingBooks.length ~/ 2;

                _recommendedBooks = remainingBooks.sublist(0, midPoint);
                _popularBooks = remainingBooks.sublist(midPoint);
              }

              _isLoading = false;
            });
          }
        })
        .catchError((error) {
          if (mounted) {
            setState(() {
              _isLoading = false;
              _errorMessage = 'Failed to load books: ${error.toString()}';
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;

    // Determine if we're in landscape mode
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final isTablet = responsive.isTablet;

    return Scaffold(
      backgroundColor: Colors.white,
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _errorMessage.isNotEmpty
              ? _buildErrorView()
              : _buildBooksView(
                context,
                responsive,
                rFonts,
                isLandscape,
                isTablet,
              ),
      bottomNavigationBar: CustomBottomNavigationResponsive(
        responsive: responsive,
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            _errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _loadBooks,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff0B8FAC),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildBooksView(
    BuildContext context,
    ResponsiveUtils responsive,
    ResponsiveFontStyles rFonts,
    bool isLandscape,
    bool isTablet,
  ) {
    // For landscape mode on tablets, we'll use a two-column layout
    if (!isLandscape && !isTablet) {
      return Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left column
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(responsive.getResponsiveSize(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomAppBarResponsive(),
                        SizedBox(height: responsive.getResponsiveSize(20)),
                        _buildFeaturedBook(responsive, rFonts),
                        SizedBox(height: responsive.getResponsiveSize(20)),
                        SectionTitleResponsive(title: "Recommended for you"),
                        _buildRecommendedBooks(responsive, rFonts),
                      ],
                    ),
                  ),
                ),
              ),

              // Right column
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(responsive.getResponsiveSize(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: responsive.getResponsiveSize(80)),
                        SizedBox(height: responsive.getResponsiveSize(20)),
                        SectionTitleResponsive(title: "Popular books"),
                        _buildPopularBooks(responsive, rFonts),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Background SVG
          Positioned(
            top: 0,
            right: 0,
            child: SvgPicture.asset(
              Imagestyles.backOfBookView,
              width: responsive.getResponsiveSize(200),
              height: responsive.getResponsiveSize(200),
              fit: BoxFit.fill,
            ),
          ),
        ],
      );
    } else {
      // Portrait mode or smaller screens use a single column layout
      return Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(responsive.getResponsiveSize(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: responsive.getResponsiveSize(80)),
                  const CustomAppBarResponsive(),
                  SizedBox(height: responsive.getResponsiveSize(20)),
                  _buildFeaturedBook(responsive, rFonts),
                  SizedBox(height: responsive.getResponsiveSize(20)),
                  SectionTitleResponsive(title: "Recommended for you"),
                  _buildRecommendedBooks(responsive, rFonts),
                  SizedBox(height: responsive.getResponsiveSize(20)),
                  SectionTitleResponsive(title: "Popular books"),
                  _buildPopularBooks(responsive, rFonts),
                ],
              ),
            ),
          ),

          // Background SVG
          Positioned(
            top: 0,
            right: 0,
            child: SvgPicture.asset(
              Imagestyles.backOfBookView,
              width: responsive.getResponsiveSize(200),
              height: responsive.getResponsiveSize(200),
              fit: BoxFit.fill,
            ),
          ),
        ],
      );
    }
  }

  Widget _buildFeaturedBook(
    ResponsiveUtils responsive,
    ResponsiveFontStyles rFonts,
  ) {
    if (_featuredBooks.isEmpty) {
      return const SizedBox.shrink();
    }

    final book = _featuredBooks.first;
    final cardPadding = responsive.getResponsiveSize(16);
    final imageHeight = responsive.getResponsiveSize(120);
    final imageWidth = responsive.getResponsiveSize(80);
    final borderRadius = responsive.getResponsiveSize(16);

    return Container(
      margin: EdgeInsets.all(responsive.getResponsiveSize(4)),
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: imageWidth,
            height: imageHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius / 2),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius / 2),
              child:
                  book.thumbnail.isNotEmpty
                      ? Image.network(
                        book.thumbnail,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.book,
                            size: responsive.getResponsiveSize(40),
                            color: Colors.grey[400],
                          );
                        },
                      )
                      : Icon(
                        Icons.book,
                        size: responsive.getResponsiveSize(40),
                        color: Colors.grey[400],
                      ),
            ),
          ),
          SizedBox(width: responsive.getResponsiveSize(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: rFonts.makeResponsive(
                    GoogleFonts.hankenGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff4D506C),
                    ),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: responsive.getResponsiveSize(4)),
                Text(
                  book.authors.join(', '),
                  style: rFonts.makeResponsive(
                    GoogleFonts.hankenGrotesk(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff4D506C),
                    ),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: responsive.getResponsiveSize(4)),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: responsive.getResponsiveSize(14),
                    ),
                    Text(
                      "4.5",
                      style: rFonts.makeResponsive(
                        GoogleFonts.hankenGrotesk(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff0B8FAC),
                        ),
                      ),
                    ),
                    SizedBox(width: responsive.getResponsiveSize(4)),
                    Text(
                      " | ${book.pageCount} pages",
                      style: rFonts.makeResponsive(
                        GoogleFonts.hankenGrotesk(
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff4D506C),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: responsive.getResponsiveSize(8)),
                Text(
                  book.description,
                  style: rFonts.makeResponsive(
                    GoogleFonts.hankenGrotesk(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff4D506C),
                    ),
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: responsive.getResponsiveSize(8)),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _navigateToBookDetails(context, book);
                      },
                      child: Container(
                        width: 90,
                        height: 27,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xff0B8FAC),
                        ),
                        child: Center(
                          child: Text(
                            "Grab Now",
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        _navigateToBookDetails(context, book);
                      },
                      child: Text(
                        "Learn More",
                        style: GoogleFonts.hankenGrotesk(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff4D506C),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedBooks(
    ResponsiveUtils responsive,
    ResponsiveFontStyles rFonts,
  ) {
    if (_recommendedBooks.isEmpty) {
      return SizedBox(
        height: responsive.getResponsiveSize(220),
        child: Center(
          child: Text(
            "No recommended books available",
            style: rFonts.makeResponsive(
              GoogleFonts.hankenGrotesk(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      );
    }

    // Adjust item size based on screen size and orientation
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final isTablet = responsive.isTablet;

    final itemHeight = responsive.getResponsiveSize(220);
    final itemWidth =
        isLandscape && isTablet
            ? responsive.widthPercent(20)
            : isTablet
            ? responsive.widthPercent(30)
            : responsive.widthPercent(40);

    return SizedBox(
      height: itemHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _recommendedBooks.length,
        itemBuilder: (context, index) {
          final book = _recommendedBooks[index];
          return GestureDetector(
            onTap: () => _navigateToBookDetails(context, book),
            child: Container(
              width: itemWidth,
              margin: EdgeInsets.only(
                left:
                    index == 0
                        ? responsive.getResponsiveSize(16)
                        : responsive.getResponsiveSize(8),
                right: responsive.getResponsiveSize(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          responsive.getResponsiveSize(12),
                        ),
                        color: Colors.grey[200],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          responsive.getResponsiveSize(12),
                        ),
                        child:
                            book.thumbnail.isNotEmpty
                                ? Image.network(
                                  book.thumbnail,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Icon(
                                        Icons.book,
                                        size: responsive.getResponsiveSize(40),
                                        color: Colors.grey[400],
                                      ),
                                    );
                                  },
                                )
                                : Center(
                                  child: Icon(
                                    Icons.book,
                                    size: responsive.getResponsiveSize(40),
                                    color: Colors.grey[400],
                                  ),
                                ),
                      ),
                    ),
                  ),
                  SizedBox(height: responsive.getResponsiveSize(8)),
                  Text(
                    book.title,
                    style: rFonts.makeResponsive(
                      GoogleFonts.hankenGrotesk(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff4D506C),
                      ),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: responsive.getResponsiveSize(2)),
                  Text(
                    book.authors.join(', '),
                    style: rFonts.makeResponsive(
                      GoogleFonts.hankenGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff4D506C),
                      ),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: responsive.getResponsiveSize(2)),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: responsive.getResponsiveSize(14),
                      ),
                      SizedBox(width: responsive.getResponsiveSize(4)),
                      Text(
                        "4.5",
                        style: rFonts.makeResponsive(
                          GoogleFonts.hankenGrotesk(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff4D506C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPopularBooks(
    ResponsiveUtils responsive,
    ResponsiveFontStyles rFonts,
  ) {
    if (_popularBooks.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(responsive.getResponsiveSize(16)),
          child: Text(
            "No popular books available",
            style: rFonts.makeResponsive(
              GoogleFonts.hankenGrotesk(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _popularBooks.length,
      itemBuilder: (context, index) {
        final book = _popularBooks[index];
        return GestureDetector(
          onTap: () => _navigateToBookDetails(context, book),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: responsive.getResponsiveSize(16),
              vertical: responsive.getResponsiveSize(8),
            ),
            padding: EdgeInsets.all(responsive.getResponsiveSize(12)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                responsive.getResponsiveSize(12),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: responsive.getResponsiveSize(60),
                  height: responsive.getResponsiveSize(80),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      responsive.getResponsiveSize(8),
                    ),
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      responsive.getResponsiveSize(8),
                    ),
                    child:
                        book.thumbnail.isNotEmpty
                            ? Image.network(
                              book.thumbnail,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(
                                    Icons.book,
                                    size: responsive.getResponsiveSize(24),
                                    color: Colors.grey[400],
                                  ),
                                );
                              },
                            )
                            : Center(
                              child: Icon(
                                Icons.book,
                                size: responsive.getResponsiveSize(24),
                                color: Colors.grey[400],
                              ),
                            ),
                  ),
                ),
                SizedBox(width: responsive.getResponsiveSize(16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: rFonts.makeResponsive(
                          GoogleFonts.hankenGrotesk(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff4D506C),
                          ),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: responsive.getResponsiveSize(4)),
                      Text(
                        book.authors.join(', '),
                        style: rFonts.makeResponsive(
                          GoogleFonts.hankenGrotesk(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff4D506C),
                          ),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: responsive.getResponsiveSize(4)),
                      Row(
                        children: [
                          Text(
                            "4.5",
                            style: rFonts.makeResponsive(
                              GoogleFonts.hankenGrotesk(
                                fontSize: 8,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff0B8FAC),
                              ),
                            ),
                          ),
                          SizedBox(width: responsive.getResponsiveSize(4)),
                          Text(
                            " | ${book.pageCount} pages",
                            style: rFonts.makeResponsive(
                              GoogleFonts.hankenGrotesk(
                                fontSize: 8,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff4D506C),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _navigateToBookDetails(context, book);
                      },
                      child: Container(
                        width: 90,
                        height: 27,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xff0B8FAC),
                        ),
                        child: Center(
                          child: Text(
                            "Grab Now",
                            style: GoogleFonts.hankenGrotesk(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _navigateToBookDetails(context, book);
                      },
                      child: Text(
                        "Learn More",
                        style: GoogleFonts.hankenGrotesk(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff4D506C),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToBookDetails(BuildContext context, Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsApiRedesigned(book: book),
      ),
    );
  }

  void _navigateToPdfViewer(BuildContext context, Book book) {
    final pdfUrl = BooksService.getPdfUrlForBook(book);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerScreen(book: book, pdfUrl: pdfUrl),
      ),
    );
  }
}

// Responsive section title
class SectionTitleResponsive extends StatelessWidget {
  final String title;
  const SectionTitleResponsive({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.getResponsiveSize(16),
      ),
      child: Text(
        title,
        style: GoogleFonts.hankenGrotesk(
          fontSize: responsive.fontSize(20),
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// Responsive custom app bar
class CustomAppBarResponsive extends StatelessWidget {
  const CustomAppBarResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, Doctor',
              style: rFonts.makeResponsive(
                GoogleFonts.hankenGrotesk(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff4D506C),
                ),
              ),
            ),
            SizedBox(height: responsive.getResponsiveSize(4)),
            Text(
              'Find Your Medical Books',
              style: rFonts.makeResponsive(
                GoogleFonts.hankenGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: CircleAvatar(
            radius: responsive.getResponsiveSize(20),
            backgroundColor: Colors.grey[200],
            child: Icon(
              Icons.arrow_back,
              size: responsive.getResponsiveSize(20),
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

// Responsive bottom navigation
class CustomBottomNavigationResponsive extends StatelessWidget {
  final ResponsiveUtils responsive;

  const CustomBottomNavigationResponsive({required this.responsive, super.key});

  @override
  Widget build(BuildContext context) {
    final iconSize = responsive.getResponsiveSize(24);
    final barHeight = responsive.getResponsiveSize(60);

    return Container(
      height: barHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_outlined, 'Home', false, iconSize),
          _buildNavItem(Icons.book_outlined, 'Books', true, iconSize),
          _buildNavItem(Icons.bookmark_border, 'Saved', false, iconSize),
          _buildNavItem(Icons.person_outline, 'Profile', false, iconSize),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isActive,
    double iconSize,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xff0B8FAC) : Colors.grey,
          size: iconSize,
        ),
        SizedBox(height: responsive.getResponsiveSize(4)),
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xff0B8FAC) : Colors.grey,
            fontSize: responsive.fontSize(12),
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
