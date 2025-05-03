import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical/Models/book.dart';

class ChatGptService {
  // This is a free API endpoint that doesn't require authentication
  // In a production app, you would use the official OpenAI API with proper authentication
  static const String _baseUrl = 'https://free.churchless.tech/v1/chat/completions';
  
  /// Sends a message to the ChatGPT API and returns the response
  static Future<String> getChatResponse(String message, Book book) async {
    try {
      // Create a system message with context about the book
      final systemMessage = "You are an AI assistant specialized in medical literature. "
          "You are helping a user understand the book '${book.title}' by ${book.authors.join(', ')}. "
          "The book was published by ${book.publisher} in ${book.publishedDate}. "
          "It has ${book.pageCount} pages and falls under these categories: ${book.categories.join(', ')}. "
          "Here's a brief description of the book: ${book.description}. "
          "Provide helpful, accurate, and concise information about this book based on the user's questions.";
      
      // Create the request body
      final Map<String, dynamic> requestBody = {
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "system", "content": systemMessage},
          {"role": "user", "content": message}
        ],
        "temperature": 0.7,
        "max_tokens": 500
      };
      
      // Send the request
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );
      
      // Check if the request was successful
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> choices = data['choices'] ?? [];
        
        if (choices.isNotEmpty) {
          final Map<String, dynamic> choice = choices[0];
          final Map<String, dynamic> message = choice['message'] ?? {};
          return message['content'] ?? 'Sorry, I couldn\'t generate a response.';
        } else {
          return 'Sorry, I couldn\'t generate a response.';
        }
      } else {
        // If the API call fails, fall back to the local response generator
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
    
    if (questionLower.contains('about') || 
        questionLower.contains('what is') || 
        questionLower.contains('summary')) {
      return "\"${book.title}\" is ${book.description.substring(0, book.description.length > 200 ? 200 : book.description.length)}... The book was published by ${book.publisher} in ${book.publishedDate}.";
    } else if (questionLower.contains('author') || 
               questionLower.contains('who wrote')) {
      return "\"${book.title}\" was written by ${book.authors.join(', ')}.";
    } else if (questionLower.contains('publish') || 
               questionLower.contains('when') || 
               questionLower.contains('date')) {
      return "\"${book.title}\" was published on ${book.publishedDate} by ${book.publisher}.";
    } else if (questionLower.contains('page') || 
               questionLower.contains('length') || 
               questionLower.contains('how long')) {
      return "\"${book.title}\" is ${book.pageCount} pages long.";
    } else if (questionLower.contains('category') || 
               questionLower.contains('genre') || 
               questionLower.contains('type')) {
      return "\"${book.title}\" falls under the following categories: ${book.categories.join(', ')}.";
    } else if (questionLower.contains('language')) {
      return "\"${book.title}\" is written in ${book.language.toUpperCase()}.";
    } else if (questionLower.contains('ebook') || 
               questionLower.contains('digital')) {
      return "\"${book.title}\" ${book.isEbook ? 'is available' : 'is not available'} as an eBook.";
    } else if (questionLower.contains('hello') || 
               questionLower.contains('hi') || 
               questionLower.contains('hey')) {
      return "Hello! How can I help you with \"${book.title}\" today?";
    } else if (questionLower.contains('thank')) {
      return "You're welcome! Feel free to ask if you have any other questions about \"${book.title}\".";
    } else {
      return "I don't have specific information about that aspect of \"${book.title}\". "
             "Would you like to know about the author, publication date, or a summary of the book?";
    }
  }
}
