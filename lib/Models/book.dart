class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String description;
  final String publisher;
  final String publishedDate;
  final int pageCount;
  final List<String> categories;
  final String language;
  final String previewLink;
  final String infoLink;
  final String thumbnail;
  final String smallThumbnail;
  final bool isEbook;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.description,
    required this.publisher,
    required this.publishedDate,
    required this.pageCount,
    required this.categories,
    required this.language,
    required this.previewLink,
    required this.infoLink,
    required this.thumbnail,
    required this.smallThumbnail,
    required this.isEbook,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] ?? {};
    final imageLinks = volumeInfo['imageLinks'] ?? {};
    final saleInfo = json['saleInfo'] ?? {};

    return Book(
      id: json['id'] ?? '',
      title: volumeInfo['title'] ?? 'Unknown Title',
      authors: volumeInfo['authors'] != null
          ? List<String>.from(volumeInfo['authors'])
          : ['Unknown Author'],
      description: volumeInfo['description'] ?? 'No description available',
      publisher: volumeInfo['publisher'] ?? 'Unknown Publisher',
      publishedDate: volumeInfo['publishedDate'] ?? 'Unknown Date',
      pageCount: volumeInfo['pageCount'] ?? 0,
      categories: volumeInfo['categories'] != null
          ? List<String>.from(volumeInfo['categories'])
          : ['Uncategorized'],
      language: volumeInfo['language'] ?? 'en',
      previewLink: volumeInfo['previewLink'] ?? '',
      infoLink: volumeInfo['infoLink'] ?? '',
      thumbnail: imageLinks['thumbnail'] ?? 'https://via.placeholder.com/128x192',
      smallThumbnail: imageLinks['smallThumbnail'] ?? 'https://via.placeholder.com/64x96',
      isEbook: saleInfo['isEbook'] ?? false,
    );
  }
}
