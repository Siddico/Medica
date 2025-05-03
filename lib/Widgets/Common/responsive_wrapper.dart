import 'package:flutter/material.dart';

/// A responsive stack that allows for positioning elements responsively
class ResponsiveStack extends StatelessWidget {
  /// The main content of the stack
  final Widget mainContent;
  
  /// Background elements to be positioned behind the main content
  final List<ResponsivePositionedItem> backgroundElements;
  
  /// Foreground elements to be positioned in front of the main content
  final List<ResponsivePositionedItem> foregroundElements;
  
  const ResponsiveStack({
    super.key,
    required this.mainContent,
    this.backgroundElements = const [],
    this.foregroundElements = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background elements
        ...backgroundElements.map((item) => Positioned(
          left: item.left,
          right: item.right,
          top: item.top,
          bottom: item.bottom,
          child: item.child,
        )),
        
        // Main content
        mainContent,
        
        // Foreground elements
        ...foregroundElements.map((item) => Positioned(
          left: item.left,
          right: item.right,
          top: item.top,
          bottom: item.bottom,
          child: item.child,
        )),
      ],
    );
  }
}

/// A class representing a positioned item in a responsive stack
class ResponsivePositionedItem {
  /// The left position of the item
  final double? left;
  
  /// The right position of the item
  final double? right;
  
  /// The top position of the item
  final double? top;
  
  /// The bottom position of the item
  final double? bottom;
  
  /// The child widget to position
  final Widget child;
  
  const ResponsivePositionedItem({
    this.left,
    this.right,
    this.top,
    this.bottom,
    required this.child,
  });
}
