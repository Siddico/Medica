import 'package:flutter/material.dart';
import 'package:medical/Constants/responsive_utils.dart';

/// A wrapper widget that makes its child responsive
class ResponsiveWrapper extends StatelessWidget {
  /// The child widget to make responsive
  final Widget child;
  
  /// Maximum width for the content (optional)
  final double? maxWidth;
  
  /// Whether to center the content horizontally
  final bool centerHorizontally;
  
  /// Whether to apply padding
  final bool applyPadding;
  
  /// Custom padding to apply (if null, uses responsive padding)
  final EdgeInsets? padding;
  
  /// Background color
  final Color backgroundColor;
  
  /// Whether to use a scrollable view
  final bool scrollable;
  
  const ResponsiveWrapper({
    super.key,
    required this.child,
    this.maxWidth,
    this.centerHorizontally = true,
    this.applyPadding = true,
    this.padding,
    this.backgroundColor = Colors.white,
    this.scrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    
    Widget content = child;
    
    // Apply padding if needed
    if (applyPadding) {
      content = Padding(
        padding: padding ?? responsive.getPadding(),
        child: content,
      );
    }
    
    // Apply max width constraint if needed
    if (maxWidth != null) {
      content = Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth!),
          child: content,
        ),
      );
    } else if (centerHorizontally) {
      // Center horizontally without max width
      content = Center(child: content);
    }
    
    // Apply scrollable view if needed
    if (scrollable) {
      content = SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: content,
      );
    }
    
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: content,
      ),
    );
  }
}

/// A responsive stack that handles positioning of background elements
class ResponsiveStack extends StatelessWidget {
  /// The main content of the stack
  final Widget mainContent;
  
  /// Background elements to position
  final List<ResponsivePositionedItem> backgroundElements;
  
  const ResponsiveStack({
    super.key,
    required this.mainContent,
    required this.backgroundElements,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        mainContent,
        ...backgroundElements.map((item) {
          final responsive = ResponsiveUtils(context);
          return responsive.responsivePositioned(
            left: item.left,
            top: item.top,
            right: item.right,
            bottom: item.bottom,
            child: item.child,
          );
        }).toList(),
      ],
    );
  }
}

/// A class representing a positioned item in a responsive stack
class ResponsivePositionedItem {
  final Widget child;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  
  ResponsivePositionedItem({
    required this.child,
    this.left,
    this.top,
    this.right,
    this.bottom,
  });
}
