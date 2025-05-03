import 'package:flutter/material.dart';

/// A utility class that provides tools for making the app responsive across different screen sizes.
class ResponsiveUtils {
  /// The context used to get the screen size
  final BuildContext context;
  
  /// Screen width
  late final double screenWidth;
  
  /// Screen height
  late final double screenHeight;
  
  /// Device pixel ratio
  late final double pixelRatio;
  
  /// Status bar height
  late final double statusBarHeight;
  
  /// Bottom padding (for notches, etc.)
  late final double bottomPadding;
  
  /// Whether the device is a phone (smaller screen)
  late final bool isPhone;
  
  /// Whether the device is a tablet (larger screen)
  late final bool isTablet;
  
  /// Whether the device is in landscape orientation
  late final bool isLandscape;

  /// Constructor that initializes all properties
  ResponsiveUtils(this.context) {
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    pixelRatio = mediaQuery.devicePixelRatio;
    statusBarHeight = mediaQuery.padding.top;
    bottomPadding = mediaQuery.padding.bottom;
    isLandscape = mediaQuery.orientation == Orientation.landscape;
    
    // Determine device type based on screen width
    // Common breakpoints: Phone < 600, Tablet >= 600
    isPhone = screenWidth < 600;
    isTablet = screenWidth >= 600;
  }

  /// Returns a responsive font size based on screen width
  double fontSize(double size) {
    // Base size adjustment for different screen sizes
    if (isTablet) {
      // For tablets, slightly increase font size
      return size * 1.15;
    } else {
      // For phones, adjust based on screen width
      final scaleFactor = screenWidth / 375; // 375 is baseline (iPhone X width)
      return size * (scaleFactor.clamp(0.8, 1.2)); // Limit scaling range
    }
  }

  /// Returns a responsive padding based on screen size
  EdgeInsets getPadding({
    double horizontal = 24.0,
    double vertical = 20.0,
  }) {
    if (isTablet) {
      // Increase padding for tablets
      return EdgeInsets.symmetric(
        horizontal: horizontal * 1.5,
        vertical: vertical * 1.2,
      );
    } else {
      // Adjust padding based on screen width for phones
      final scaleFactor = screenWidth / 375; // 375 is baseline
      return EdgeInsets.symmetric(
        horizontal: horizontal * scaleFactor.clamp(0.8, 1.2),
        vertical: vertical * scaleFactor.clamp(0.8, 1.2),
      );
    }
  }

  /// Returns a responsive height based on screen height percentage
  double heightPercent(double percent) {
    return screenHeight * (percent / 100);
  }

  /// Returns a responsive width based on screen width percentage
  double widthPercent(double percent) {
    return screenWidth * (percent / 100);
  }

  /// Returns a responsive size for widgets based on screen width
  double getResponsiveSize(double size) {
    if (isTablet) {
      // For tablets, slightly increase size
      return size * 1.25;
    } else {
      // For phones, adjust based on screen width
      final scaleFactor = screenWidth / 375; // 375 is baseline
      return size * scaleFactor.clamp(0.8, 1.3); // Limit scaling range
    }
  }

  /// Returns a responsive value based on device type
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isTablet && tablet != null) {
      return tablet;
    } else if (screenWidth >= 1200 && desktop != null) {
      return desktop;
    }
    return mobile;
  }
  
  /// Returns a responsive spacing (SizedBox) for height
  Widget verticalSpace(double height) {
    return SizedBox(height: getResponsiveSize(height));
  }
  
  /// Returns a responsive spacing (SizedBox) for width
  Widget horizontalSpace(double width) {
    return SizedBox(width: getResponsiveSize(width));
  }
  
  /// Adjusts the position of background images based on screen size
  Positioned responsivePositioned({
    required Widget child,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    // Calculate responsive positions
    final responsiveLeft = left != null ? getResponsiveSize(left) : null;
    final responsiveTop = top != null ? getResponsiveSize(top) : null;
    final responsiveRight = right != null ? getResponsiveSize(right) : null;
    final responsiveBottom = bottom != null ? getResponsiveSize(bottom) : null;
    
    return Positioned(
      left: responsiveLeft,
      top: responsiveTop,
      right: responsiveRight,
      bottom: responsiveBottom,
      child: child,
    );
  }
  
  /// Creates a responsive text style based on the provided style
  TextStyle responsiveTextStyle(TextStyle style) {
    return style.copyWith(
      fontSize: fontSize(style.fontSize ?? 14),
    );
  }
  
  /// Returns a container with responsive constraints
  Widget constrainedBox({
    required Widget child,
    double maxWidth = 600,
  }) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: child,
      ),
    );
  }
}

/// Extension on BuildContext to easily access ResponsiveUtils
extension ResponsiveUtilsExtension on BuildContext {
  ResponsiveUtils get responsive => ResponsiveUtils(this);
}
