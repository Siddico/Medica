import 'package:flutter/material.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/BooksView/book_ai_chat_screen.dart';
import 'package:medical/Models/book.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatefulWidget {
  final Book book;
  final String pdfUrl;

  const PdfViewerScreen({required this.book, required this.pdfUrl, super.key});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late PdfViewerController _pdfViewerController;
  bool _isLoading = true;
  String _errorMessage = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Show a custom search dialog
  void _showSearchDialog(BuildContext context) {
    final responsive = ResponsiveUtils(context);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Search in Document',
            style: TextStyle(
              fontSize: responsive.fontSize(18),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Enter text to search',
                  hintStyle: TextStyle(
                    fontSize: responsive.fontSize(16),
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      responsive.getResponsiveSize(8),
                    ),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    Navigator.pop(context);

                    // Show a message to the user
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Searching for "$value"...'),
                        duration: const Duration(seconds: 1),
                      ),
                    );

                    // Use the controller to search
                    try {
                      _pdfViewerController.searchText(value);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Search failed: ${e.toString()}'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: responsive.fontSize(16),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              onPressed:
                  _searchController.text.isEmpty
                      ? null
                      : () {
                        Navigator.pop(context);

                        // Show a message to the user
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Searching for "${_searchController.text}"...',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );

                        // Use the controller to search
                        try {
                          _pdfViewerController.searchText(
                            _searchController.text,
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Search failed: ${e.toString()}'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0B8FAC),
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Search',
                style: TextStyle(
                  fontSize: responsive.fontSize(16),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.book.title,
          style: rFonts.style18weight400.copyWith(color: Colors.black),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat, color: Color(0xff0B8FAC)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookAIChatScreen(book: widget.book),
                ),
              );
            },
            tooltip: 'Ask AI about this book',
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.black),
            onPressed: () {
              // Save book functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Book saved to your library'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Show custom search dialog
              _showSearchDialog(context);
            },
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _errorMessage.isNotEmpty
              ? _buildErrorView(responsive, rFonts)
              : Stack(
                children: [
                  SfPdfViewer.network(
                    widget.pdfUrl,
                    key: _pdfViewerKey,
                    controller: _pdfViewerController,
                    onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    onDocumentLoadFailed: (
                      PdfDocumentLoadFailedDetails details,
                    ) {
                      setState(() {
                        _isLoading = false;
                        _errorMessage = 'Failed to load PDF: ${details.error}';
                      });
                    },
                  ),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
      bottomNavigationBar: Container(
        height: responsive.getResponsiveSize(56),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.zoom_out),
              onPressed: () {
                _pdfViewerController.zoomLevel =
                    (_pdfViewerController.zoomLevel - 0.25).clamp(0.75, 3.0);
              },
            ),
            IconButton(
              icon: const Icon(Icons.zoom_in),
              onPressed: () {
                _pdfViewerController.zoomLevel =
                    (_pdfViewerController.zoomLevel + 0.25).clamp(0.75, 3.0);
              },
            ),
            IconButton(
              icon: const Icon(Icons.navigate_before),
              onPressed: () {
                _pdfViewerController.previousPage();
              },
            ),
            IconButton(
              icon: const Icon(Icons.navigate_next),
              onPressed: () {
                _pdfViewerController.nextPage();
              },
            ),
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookAIChatScreen(book: widget.book),
                  ),
                );
              },
              tooltip: 'Ask AI about this book',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(
    ResponsiveUtils responsive,
    ResponsiveFontStyles rFonts,
  ) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(responsive.getResponsiveSize(24)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: responsive.getResponsiveSize(64),
              color: Colors.red,
            ),
            SizedBox(height: responsive.getResponsiveSize(16)),
            Text(
              _errorMessage,
              style: rFonts.style16weight700,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: responsive.getResponsiveSize(24)),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _errorMessage = '';
                });
                // Retry loading the PDF
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (mounted) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0B8FAC),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.getResponsiveSize(24),
                  vertical: responsive.getResponsiveSize(12),
                ),
              ),
              child: Text(
                'Try Again',
                style: rFonts.style16weight700.copyWith(color: Colors.white),
              ),
            ),
            SizedBox(height: responsive.getResponsiveSize(16)),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Go Back',
                style: rFonts.style16weight700.copyWith(
                  color: const Color(0xff0B8FAC),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
