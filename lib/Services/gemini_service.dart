import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:medical/Models/book.dart';

class GeminiService {
  // Gemini API key
  static const String _apiKey = 'AIzaSyAG2qO1UvsObAZ44oz1LPO5x24dKKadulQ';

  /// Sends a message to the Gemini API and returns the response
  static Future<String> getChatResponse(String message, Book book) async {
    try {
      // Initialize the Gemini API with the provided API key
      final model = GenerativeModel(model: 'gemini-pro', apiKey: _apiKey);

      // Create a comprehensive system message with detailed context about the book
      final systemPrompt = """
You are an advanced AI assistant specialized in medical literature and healthcare education.
You are helping a medical professional or student understand the book '${book.title}' by ${book.authors.join(', ')}.

BOOK DETAILS:
- Title: ${book.title}
- Author(s): ${book.authors.join(', ')}
- Publisher: ${book.publisher}
- Publication Date: ${book.publishedDate}
- Pages: ${book.pageCount}
- Categories: ${book.categories.join(', ')}
- Language: ${book.language.toUpperCase()}
- Available as eBook: ${book.isEbook ? 'Yes' : 'No'}

BOOK DESCRIPTION:
${book.description}

YOUR CAPABILITIES:
1. Summarize key concepts, chapters, and themes from the book
2. Explain medical terminology and concepts mentioned in the book
3. Provide context on how this book relates to current medical practice
4. Compare this book with other similar medical texts
5. Suggest related reading materials or research papers
6. Explain complex medical procedures or treatments mentioned in the book
7. Discuss the historical context and significance of the book in medical education
8. Analyze the book's approach to specific medical conditions or treatments
9. Relate the book's content to clinical practice and patient care
10. Discuss the latest research or developments related to topics covered in the book

RESPONSE GUIDELINES:
- Be concise but thorough in your explanations
- Use medical terminology appropriately but explain complex terms
- Cite specific sections or chapters when relevant
- Acknowledge when information might be outdated and provide current perspectives
- Be helpful for both beginners and advanced medical professionals
- If you don't know something specific about the book, acknowledge this and provide general information about the topic instead

Respond to the user's questions about this book in a helpful, accurate, and educational manner.
""";

      // Create a chat session
      final chat = model.startChat(history: [Content.text(systemPrompt)]);

      // Send the message and get the response
      final response = await chat.sendMessage(Content.text(message));

      // Extract the text from the response
      final responseText = response.text;

      if (responseText != null && responseText.isNotEmpty) {
        return responseText;
      } else {
        return _generateFallbackResponse(message, book);
      }
    } catch (e) {
      // If there's an error, fall back to the local response generator
      return _generateFallbackResponse(message, book);
    }
  }

  /// Generates a fallback response when the API call fails
  static String _generateFallbackResponse(String question, Book book) {
    final questionLower = question.toLowerCase();

    // Basic book information
    if (questionLower.contains('about') ||
        questionLower.contains('what is') ||
        questionLower.contains('summary')) {
      return "\"${book.title}\" is ${book.description.substring(0, book.description.length > 200 ? 200 : book.description.length)}... The book was published by ${book.publisher} in ${book.publishedDate}.";
    }
    // Author information
    else if (questionLower.contains('author') ||
        questionLower.contains('who wrote') ||
        questionLower.contains('written by')) {
      return "\"${book.title}\" was written by ${book.authors.join(', ')}. ${book.authors.length > 1 ? 'They are' : 'The author is'} known for their expertise in the medical field covered by this book.";
    }
    // Publication information
    else if (questionLower.contains('publish') ||
        questionLower.contains('when') ||
        questionLower.contains('date')) {
      return "\"${book.title}\" was published on ${book.publishedDate} by ${book.publisher}. This publisher is known for producing high-quality medical literature.";
    }
    // Book length
    else if (questionLower.contains('page') ||
        questionLower.contains('length') ||
        questionLower.contains('how long')) {
      return "\"${book.title}\" is ${book.pageCount} pages long. This is ${book.pageCount > 500
          ? 'a comprehensive'
          : book.pageCount > 300
          ? 'a standard-length'
          : 'a concise'} medical text.";
    }
    // Categories
    else if (questionLower.contains('category') ||
        questionLower.contains('genre') ||
        questionLower.contains('type') ||
        questionLower.contains('field') ||
        questionLower.contains('specialty')) {
      return "\"${book.title}\" falls under the following categories: ${book.categories.join(', ')}. This book is particularly relevant for medical professionals and students in these fields.";
    }
    // Language
    else if (questionLower.contains('language')) {
      return "\"${book.title}\" is written in ${book.language.toUpperCase()}. This makes it accessible to a wide range of medical professionals who read ${book.language.toUpperCase()}.";
    }
    // eBook availability
    else if (questionLower.contains('ebook') ||
        questionLower.contains('digital') ||
        questionLower.contains('electronic') ||
        questionLower.contains('kindle') ||
        questionLower.contains('pdf')) {
      return "\"${book.title}\" ${book.isEbook ? 'is available' : 'is not available'} as an eBook. ${book.isEbook ? 'This makes it convenient to access on various devices and platforms.' : 'You would need to obtain a physical copy of this book.'}";
    }
    // Medical content questions
    else if (questionLower.contains('chapter') ||
        questionLower.contains('section') ||
        questionLower.contains('topic') ||
        questionLower.contains('content')) {
      return "\"${book.title}\" likely covers key topics in ${book.categories.isNotEmpty ? book.categories.join(' and ') : 'medical science'}. While I don't have access to the specific chapters, medical textbooks typically include foundational concepts, clinical applications, case studies, and the latest research in the field.";
    }
    // Clinical applications
    else if (questionLower.contains('clinical') ||
        questionLower.contains('practice') ||
        questionLower.contains('patient') ||
        questionLower.contains('treatment') ||
        questionLower.contains('therapy')) {
      return "\"${book.title}\" likely includes clinical applications and patient care guidelines. Medical textbooks typically bridge theoretical knowledge with practical applications to help healthcare providers deliver effective care.";
    }
    // Research and evidence
    else if (questionLower.contains('research') ||
        questionLower.contains('evidence') ||
        questionLower.contains('study') ||
        questionLower.contains('trial') ||
        questionLower.contains('data')) {
      return "\"${book.title}\" likely incorporates research findings and evidence-based practices. Medical textbooks typically reference key studies and clinical trials to support their recommendations and information.";
    }
    // Comparison with other books
    else if (questionLower.contains('compare') ||
        questionLower.contains('difference') ||
        questionLower.contains('better') ||
        questionLower.contains('other book') ||
        questionLower.contains('similar')) {
      return "\"${book.title}\" is one of several respected texts in ${book.categories.isNotEmpty ? book.categories.join(' and ') : 'this medical field'}. What sets this book apart may be its ${book.pageCount > 500
          ? 'comprehensive coverage'
          : book.pageCount > 300
          ? 'balanced approach'
          : 'concise presentation'} and the expertise of ${book.authors.join(', ')}.";
    }
    // Greetings
    else if (questionLower.contains('hello') ||
        questionLower.contains('hi') ||
        questionLower.contains('hey') ||
        questionLower.contains('greetings')) {
      return "Hello! I'm your AI assistant for \"${book.title}\". How can I help you understand this medical text better today?";
    }
    // Thanks
    else if (questionLower.contains('thank') ||
        questionLower.contains('appreciate') ||
        questionLower.contains('helpful')) {
      return "You're welcome! I'm glad I could help. Feel free to ask if you have any other questions about \"${book.title}\" or related medical topics.";
    }
    // Latest edition or updates
    else if (questionLower.contains('edition') ||
        questionLower.contains('latest') ||
        questionLower.contains('update') ||
        questionLower.contains('current') ||
        questionLower.contains('new')) {
      return "The information I have shows that \"${book.title}\" was published in ${book.publishedDate}. Medical knowledge evolves rapidly, so it's always good to check if there are more recent editions or supplementary materials available.";
    }
    // Default response for unknown questions
    else {
      return "I don't have specific information about that aspect of \"${book.title}\". As a medical text${book.categories.isNotEmpty ? ' in ${book.categories.join(' and ')}' : ''}, it likely covers fundamental concepts, clinical applications, and current research. Would you like to know about the author, publication details, or a summary of the book?";
    }
  }
}
