import 'package:flutter/material.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Models/book.dart';
import 'package:medical/Services/chat_gpt_service.dart';

class BookAIChatScreen extends StatefulWidget {
  final Book book;
  
  const BookAIChatScreen({
    required this.book,
    super.key,
  });

  @override
  State<BookAIChatScreen> createState() => _BookAIChatScreenState();
}

class _BookAIChatScreenState extends State<BookAIChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;
  
  @override
  void initState() {
    super.initState();
    // Add a welcome message
    _addBotMessage(
      "Hello! I'm your AI assistant for \"${widget.book.title}\". "
      "Ask me anything about this book, and I'll do my best to help you understand its content.",
    );
  }
  
  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
  
  void _addUserMessage(String message) {
    setState(() {
      _messages.add(
        ChatMessage(text: message, isUser: true, timestamp: DateTime.now()),
      );
    });
  }
  
  void _addBotMessage(String message) {
    setState(() {
      _messages.add(
        ChatMessage(text: message, isUser: false, timestamp: DateTime.now()),
      );
    });
  }
  
  Future<void> _handleSubmitted(String text) async {
    if (text.trim().isEmpty) return;
    
    _messageController.clear();
    _addUserMessage(text);
    
    setState(() {
      _isTyping = true;
    });
    
    try {
      // Use the ChatGPT service to get a response
      final response = await ChatGptService.getChatResponse(text, widget.book);
      
      if (mounted) {
        setState(() {
          _isTyping = false;
        });
        _addBotMessage(response);
      }
    } catch (e) {
      // If there's an error, show a fallback response
      if (mounted) {
        setState(() {
          _isTyping = false;
        });
        _addBotMessage(
          "I'm sorry, I'm having trouble connecting to my knowledge base. "
          "Please try again later or ask a different question about \"${widget.book.title}\"."
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0B8FAC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: responsive.getResponsiveSize(16),
              child: Icon(
                Icons.smart_toy,
                size: responsive.getResponsiveSize(16),
                color: const Color(0xff0B8FAC),
              ),
            ),
            SizedBox(width: responsive.getResponsiveSize(8)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'AI Assistant',
                    style: TextStyle(
                      fontSize: responsive.fontSize(16),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.book.title,
                    style: TextStyle(
                      fontSize: responsive.fontSize(12),
                      color: Colors.white.withOpacity(0.8),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    'About AI Assistant',
                    style: TextStyle(
                      fontSize: responsive.fontSize(18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'This AI assistant uses ChatGPT to provide information about "${widget.book.title}".',
                        style: TextStyle(fontSize: responsive.fontSize(14)),
                      ),
                      SizedBox(height: responsive.getResponsiveSize(16)),
                      Text(
                        'You can ask questions about:',
                        style: TextStyle(
                          fontSize: responsive.fontSize(14),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: responsive.getResponsiveSize(8)),
                      _buildInfoItem(responsive, '• The book\'s content and summary'),
                      _buildInfoItem(responsive, '• Author information'),
                      _buildInfoItem(responsive, '• Publication details'),
                      _buildInfoItem(responsive, '• Medical concepts covered'),
                      _buildInfoItem(responsive, '• Related research and studies'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Close',
                        style: TextStyle(
                          fontSize: responsive.fontSize(16),
                          color: const Color(0xff0B8FAC),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/images/chat_bg.png'),
            fit: BoxFit.cover,
            opacity: 0.05,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: _messages.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(responsive.getResponsiveSize(16)),
                            decoration: BoxDecoration(
                              color: const Color(0xff0B8FAC).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.chat_bubble_outline,
                              size: responsive.getResponsiveSize(48),
                              color: const Color(0xff0B8FAC),
                            ),
                          ),
                          SizedBox(height: responsive.getResponsiveSize(16)),
                          Text(
                            'Ask me anything about this book!',
                            style: TextStyle(
                              fontSize: responsive.fontSize(18),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff0B8FAC),
                            ),
                          ),
                          SizedBox(height: responsive.getResponsiveSize(8)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: responsive.getResponsiveSize(32),
                            ),
                            child: Text(
                              'I can help you understand the content, concepts, and context of "${widget.book.title}"',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: responsive.fontSize(14),
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(responsive.getResponsiveSize(16)),
                      reverse: true,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[_messages.length - 1 - index];
                        return _buildMessage(message, responsive);
                      },
                    ),
            ),
            if (_isTyping)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.getResponsiveSize(16),
                  vertical: responsive.getResponsiveSize(8),
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(responsive.getResponsiveSize(8)),
                      decoration: BoxDecoration(
                        color: const Color(0xff0B8FAC).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          responsive.getResponsiveSize(16),
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: responsive.getResponsiveSize(16),
                            height: responsive.getResponsiveSize(16),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xff0B8FAC),
                              ),
                            ),
                          ),
                          SizedBox(width: responsive.getResponsiveSize(8)),
                          Text(
                            'AI is thinking...',
                            style: TextStyle(
                              fontSize: responsive.fontSize(14),
                              color: const Color(0xff0B8FAC),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            Container(
              padding: EdgeInsets.all(responsive.getResponsiveSize(8)),
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
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.help_outline,
                      color: Colors.grey[600],
                      size: responsive.getResponsiveSize(24),
                    ),
                    onPressed: () {
                      _handleSubmitted("What is this book about?");
                    },
                    tooltip: 'Ask about the book',
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Ask about this book...',
                        hintStyle: TextStyle(
                          fontSize: responsive.fontSize(16),
                          color: Colors.grey[500],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            responsive.getResponsiveSize(24),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: responsive.getResponsiveSize(16),
                          vertical: responsive.getResponsiveSize(10),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _messageController.clear();
                          },
                        ),
                      ),
                      textInputAction: TextInputAction.send,
                      onSubmitted: _handleSubmitted,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(width: responsive.getResponsiveSize(8)),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff0B8FAC),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () => _handleSubmitted(_messageController.text),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoItem(ResponsiveUtils responsive, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: responsive.getResponsiveSize(4)),
      child: Text(
        text,
        style: TextStyle(fontSize: responsive.fontSize(14)),
      ),
    );
  }
  
  Widget _buildMessage(ChatMessage message, ResponsiveUtils responsive) {
    return Padding(
      padding: EdgeInsets.only(bottom: responsive.getResponsiveSize(16)),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              backgroundColor: const Color(0xff0B8FAC),
              radius: responsive.getResponsiveSize(16),
              child: Icon(
                Icons.smart_toy,
                size: responsive.getResponsiveSize(16),
                color: Colors.white,
              ),
            ),
            SizedBox(width: responsive.getResponsiveSize(8)),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.all(responsive.getResponsiveSize(12)),
              decoration: BoxDecoration(
                color: message.isUser
                    ? const Color(0xff0B8FAC)
                    : Colors.white,
                borderRadius: BorderRadius.circular(
                  responsive.getResponsiveSize(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      fontSize: responsive.fontSize(16),
                      color: message.isUser ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: responsive.getResponsiveSize(4)),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      fontSize: responsive.fontSize(10),
                      color: message.isUser
                          ? Colors.white.withOpacity(0.7)
                          : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isUser) ...[
            SizedBox(width: responsive.getResponsiveSize(8)),
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: responsive.getResponsiveSize(16),
              child: Icon(
                Icons.person,
                size: responsive.getResponsiveSize(16),
                color: Colors.black,
              ),
            ),
          ],
        ],
      ),
    );
  }
  
  String _formatTime(DateTime timestamp) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  
  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}
