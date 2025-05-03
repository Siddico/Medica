import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Widgets/Common/responsive_card.dart';

/// A responsive scheduler card that adapts to different screen sizes
class SchedulerCard extends StatelessWidget {
  /// The number of total items (surgeries, appointments, etc.)
  final int number;
  
  /// The start time
  final String time1;
  
  /// The end time
  final String time2;
  
  /// The number of finished items
  final int finished;
  
  /// Whether to use dark mode styling
  final bool isDark;
  
  /// Function to call when the card is pressed
  final VoidCallback? onPressed;
  
  /// The title of the card (e.g., "Surgeries", "Appointments")
  final String title;
  
  const SchedulerCard({
    super.key,
    required this.number,
    required this.time1,
    required this.time2,
    required this.finished,
    this.isDark = false,
    this.onPressed,
    this.title = 'Surgeries',
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    
    final titleFontSize = responsive.fontSize(18);
    final subtitleFontSize = responsive.fontSize(14);
    final progressHeight = responsive.getResponsiveSize(8);
    
    final backgroundColor = isDark ? const Color(0xff0B8FAC) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subtitleColor = isDark ? Colors.white.withOpacity(0.7) : Colors.grey;
    final progressBackgroundColor = isDark ? Colors.white.withOpacity(0.3) : Colors.grey.shade200;
    final progressColor = isDark ? Colors.white : const Color(0xff0B8FAC);
    
    return GestureDetector(
      onTap: onPressed,
      child: ResponsiveCard(
        backgroundColor: backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$number $title',
                  style: GoogleFonts.openSans(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                Text(
                  '$time1 - $time2',
                  style: GoogleFonts.openSans(
                    fontSize: subtitleFontSize,
                    color: subtitleColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: responsive.getResponsiveSize(12)),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: finished / number,
                      backgroundColor: progressBackgroundColor,
                      color: progressColor,
                      minHeight: progressHeight,
                    ),
                  ),
                ),
                SizedBox(width: responsive.getResponsiveSize(12)),
                Text(
                  '$finished/$number',
                  style: GoogleFonts.openSans(
                    fontSize: subtitleFontSize,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
