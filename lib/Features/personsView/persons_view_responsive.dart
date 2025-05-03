import 'package:flutter/material.dart';
import 'package:medical/Constants/fontStyles.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
// import 'package:medical/Features/LoginView/login_view_responsive.dart';
import 'package:medical/Constants/constants.dart';
import 'package:medical/Features/LoginView/login_view_refactored.dart';
import 'package:medical/Utils/session_manager.dart';

class PersonsViewResponsive extends StatefulWidget {
  const PersonsViewResponsive({super.key});

  @override
  State<PersonsViewResponsive> createState() => _PersonsViewResponsiveState();
}

class _PersonsViewResponsiveState extends State<PersonsViewResponsive>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;

    // Determine if we're in landscape mode
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // Adjust grid based on screen size and orientation
    final crossAxisCount =
        isLandscape
            ? (responsive.isTablet ? 4 : 3)
            : (responsive.isTablet ? 3 : 2);

    // Adjust spacing based on screen size
    final horizontalPadding = responsive.getResponsiveSize(24);
    final verticalPadding = responsive.getResponsiveSize(40);
    final titleTopPadding = responsive.getResponsiveSize(40);
    final gridSpacing = responsive.getResponsiveSize(20);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: titleTopPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('You Are', style: rFonts.style70weight600),
                    // Add a small reset button for testing purposes
                    IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.grey,
                        size: responsive.getResponsiveSize(24),
                      ),
                      onPressed: () async {
                        // Reset onboarding status for testing
                        await SessionManager.resetOnboardingStatus();
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Onboarding reset. Restart the app to see onboarding again.',
                              ),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      tooltip: 'Reset onboarding (for testing)',
                    ),
                  ],
                ),
                SizedBox(height: responsive.getResponsiveSize(40)),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: gridSpacing,
                    crossAxisSpacing: gridSpacing,
                    children: [
                      GestureDetector(
                        onTap: () {
                          NavigateTo(context, const LoginView());
                        },
                        child: _buildRole(
                          context,
                          Imagestyles.DoctorsLogo,
                          'Doctor',
                          responsive,
                          rFonts,
                        ),
                      ),
                      _buildRole(
                        context,
                        Imagestyles.InternDoctorsLogo,
                        'Intern Doctor',
                        responsive,
                        rFonts,
                      ),
                      _buildRole(
                        context,
                        Imagestyles.PatientLogo,
                        'Patient',
                        responsive,
                        rFonts,
                      ),
                      _buildRole(
                        context,
                        Imagestyles.NurseLogo,
                        'Nurse',
                        responsive,
                        rFonts,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRole(
    BuildContext context,
    String imagePath,
    String title,
    ResponsiveUtils responsive,
    ResponsiveFontStyles rFonts,
  ) {
    // Adjust card size based on screen size
    final cardPadding = responsive.getResponsiveSize(16);
    final imageSize = responsive.getResponsiveSize(80);
    final titleFontSize = responsive.fontSize(18);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(cardPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.cover,
            ),
            SizedBox(height: responsive.getResponsiveSize(12)),
            Text(
              title,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xff0B8FAC),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
