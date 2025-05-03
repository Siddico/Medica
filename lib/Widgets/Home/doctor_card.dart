import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/Constants/responsive_utils.dart';

/// A responsive doctor card that adapts to different screen sizes
class DoctorCard extends StatelessWidget {
  /// The doctor's name
  final String name;
  
  /// The doctor's hourly rate
  final String hourlyRate;
  
  /// The doctor's rating
  final String rating;
  
  /// The doctor's image asset path
  final String imagePath;
  
  /// Whether this is a favorite doctor
  final bool isFavorite;
  
  /// Function to call when the favorite button is pressed
  final VoidCallback? onFavoritePressed;
  
  /// Function to call when the card is pressed
  final VoidCallback? onPressed;
  
  /// The width of the card (will be adjusted for responsiveness)
  final double width;
  
  /// The height of the card (will be adjusted for responsiveness)
  final double height;
  
  const DoctorCard({
    super.key,
    required this.name,
    required this.hourlyRate,
    required this.rating,
    required this.imagePath,
    this.isFavorite = false,
    this.onFavoritePressed,
    this.onPressed,
    this.width = 120.0,
    this.height = 160.0,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    
    final itemWidth = responsive.getResponsiveSize(width);
    final itemHeight = responsive.getResponsiveSize(height);
    final avatarRadius = responsive.getResponsiveSize(35);
    final iconSize = responsive.getResponsiveSize(16);
    final titleFontSize = responsive.fontSize(12);
    final subtitleFontSize = responsive.fontSize(10);
    
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(right: responsive.getResponsiveSize(12)),
        width: itemWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(responsive.getResponsiveSize(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: onFavoritePressed,
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : const Color(0xff777EA5),
                      size: iconSize,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.star, color: Colors.amber, size: iconSize),
                  SizedBox(width: responsive.getResponsiveSize(4)),
                  Text(
                    rating,
                    style: GoogleFonts.rubik(
                      fontSize: subtitleFontSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: responsive.getResponsiveSize(4)),
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: avatarRadius,
            ),
            SizedBox(height: responsive.getResponsiveSize(8)),
            Text(
              name,
              style: GoogleFonts.rubik(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              hourlyRate,
              style: GoogleFonts.rubik(
                fontSize: subtitleFontSize,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
