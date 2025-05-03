import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical/Models/book.dart';

class BooksService {
  static const String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  /// Fetches medical books from the Google Books API
  static Future<List<Book>> fetchMedicalBooks({int maxResults = 10}) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$_baseUrl?Filtering=free-ebooks&q=subject:computer%20science&Sorting=newest&maxResults=$maxResults',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> items = data['items'] ?? [];

        return items.map((item) => Book.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching books: $e');
    }
  }

  /// Fetches a specific book by ID
  static Future<Book> fetchBookById(String bookId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$bookId'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Book.fromJson(data);
      } else {
        throw Exception('Failed to load book: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching book: $e');
    }
  }

  /// Gets a PDF URL for a book
  /// Note: In a real app, you would get this from your backend or a PDF provider
  /// For this demo, we're using sample PDFs
  static String getPdfUrlForBook(Book book) {
    // For demo purposes, we're using sample PDFs based on book ID
    // In a real app, you would get the actual PDF URL from your backend

    // Use the last character of the book ID to determine which sample PDF to use
    final lastChar = book.id.isNotEmpty ? book.id[book.id.length - 1] : '0';
    final pdfNumber = int.tryParse(lastChar) ?? 0;

    // List of actual sample medical PDFs with direct PDF URLs
    const List<String> samplePdfs = [
      'https://www.cancer.gov/publications/patient-education/takingtime.pdf',
      'https://www.who.int/docs/default-source/coronaviruse/clinical-management-of-novel-cov.pdf',
      'https://www.cdc.gov/coronavirus/2019-ncov/downloads/community/CDC-Strategy-Face-Masks.pdf',
      'https://www.who.int/publications/i/item/WHO-2019-nCoV-clinical-2021-1/file/WHO-2019-nCoV-clinical-2021-1-eng.pdf',
      'https://www.who.int/docs/default-source/coronaviruse/situation-reports/20200423-sitrep-94-covid-19.pdf',
      'https://www.cdc.gov/coronavirus/2019-ncov/downloads/2019-ncov-factsheet.pdf',
      'https://www.who.int/docs/default-source/coronaviruse/who-china-joint-mission-on-covid-19-final-report.pdf',
      'https://www.cdc.gov/coronavirus/2019-ncov/downloads/sick-with-2019-nCoV-fact-sheet.pdf',
      'https://www.who.int/docs/default-source/coronaviruse/situation-reports/20200306-sitrep-46-covid-19.pdf',
      'https://www.cdc.gov/coronavirus/2019-ncov/downloads/COVID19-symptoms.pdf',
    ];

    // Return a sample PDF URL
    return samplePdfs[pdfNumber % samplePdfs.length];
  }

  /// Checks if a book has a readable PDF
  static bool hasReadablePdf(Book book) {
    // In a real app, you would check if the book has a readable PDF
    // For this demo, we'll assume all books have readable PDFs
    return true;
  }
}
