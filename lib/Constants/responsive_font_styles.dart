import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/Constants/fontStyles.dart';
import 'package:medical/Constants/responsive_utils.dart';

/// A utility class that provides responsive font styles
class ResponsiveFontStyles {
  final BuildContext context;

  ResponsiveFontStyles(this.context);

  /// Get responsive version of style70weight600
  TextStyle get style70weight600 {
    return GoogleFonts.lexend(
      fontSize: context.responsive.fontSize(70),
      fontWeight: FontWeight.w600,
      color: const Color(0xff0B8FAC),
    );
  }

  /// Get responsive version of style28wight500
  TextStyle get style28wight500 {
    return GoogleFonts.rubik(
      fontSize: context.responsive.fontSize(28),
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );
  }

  /// Get responsive version of style14wight400
  TextStyle get style14wight400 {
    return GoogleFonts.rubik(
      fontSize: context.responsive.fontSize(14),
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
  }

  /// Get responsive version of style26weight700
  TextStyle get style26weight700 {
    return GoogleFonts.openSans(
      fontSize: context.responsive.fontSize(26),
      fontWeight: FontWeight.w700,
      color: const Color(0xff0B8FAC),
    );
  }

  /// Get responsive version of style18weight400
  TextStyle get style18weight400 {
    return GoogleFonts.openSans(
      fontSize: context.responsive.fontSize(18),
      fontWeight: FontWeight.w400,
      color: const Color(0xff858585),
    );
  }

  /// Get responsive version of style22weight600
  TextStyle get style22weight600 {
    return GoogleFonts.openSans(
      fontSize: context.responsive.fontSize(22),
      fontWeight: FontWeight.w600,
      color: const Color(0xff000000),
    );
  }

  /// Get responsive version of style22weight700
  TextStyle get style22weight700 {
    return GoogleFonts.openSans(
      fontSize: context.responsive.fontSize(22),
      fontWeight: FontWeight.w700,
      color: const Color(0xffffffff),
    );
  }

  /// Get responsive version of style16weight700
  TextStyle get style16weight700 {
    return GoogleFonts.openSans(
      fontSize: context.responsive.fontSize(16),
      fontWeight: FontWeight.w700,
      color: const Color(0xff858585),
    );
  }

  /// Get responsive version of style18weight800
  TextStyle get style18weight800 {
    return GoogleFonts.openSans(
      fontSize: context.responsive.fontSize(18),
      fontWeight: FontWeight.w800,
      color: const Color(0xffffffff),
    );
  }

  /// Get responsive version of style32weight800
  TextStyle get style32weight800 {
    return GoogleFonts.openSans(
      fontSize: context.responsive.fontSize(32),
      fontWeight: FontWeight.w800,
      color: const Color(0xffD0BE6A),
    );
  }

  /// Make any existing TextStyle responsive
  TextStyle makeResponsive(TextStyle style) {
    return style.copyWith(
      fontSize: context.responsive.fontSize(style.fontSize ?? 14),
    );
  }
}

/// Extension on BuildContext to easily access ResponsiveFontStyles
extension ResponsiveFontStylesExtension on BuildContext {
  ResponsiveFontStyles get responsiveFontStyles => ResponsiveFontStyles(this);

  /// Helper method to make any TextStyle responsive
  TextStyle responsiveStyle(TextStyle style) {
    return responsiveFontStyles.makeResponsive(style);
  }
}
