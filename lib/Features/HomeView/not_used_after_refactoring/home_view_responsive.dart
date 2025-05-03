import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/Constants/constants.dart';
import 'package:medical/Constants/fontStyles.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/AuthCheck/auth_check_screen.dart';
import 'package:medical/Features/BooksView/books_view_api_redesigned.dart';
import 'package:medical/Utils/session_manager.dart';

class HomeScreenResponsive extends StatelessWidget {
  const HomeScreenResponsive({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;

    // Determine if we're in landscape mode
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // Adjust layout based on screen size and orientation
    final horizontalPadding = responsive.getResponsiveSize(16);
    final sectionSpacing = responsive.getResponsiveSize(20);
    final itemSpacing = responsive.getResponsiveSize(10);

    // For landscape mode on tablets, we'll use a two-column layout
    if (isLandscape && responsive.isTablet) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context, responsive),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: itemSpacing),
                    _buildSearchBar(context, responsive, rFonts),
                    SizedBox(height: sectionSpacing),
                    _sectionTitle(
                      'Live Doctors',
                      action: Icon(Icons.add),
                      responsive: responsive,
                    ),
                    SizedBox(height: itemSpacing),
                    _liveDoctors(responsive),
                    SizedBox(height: sectionSpacing),
                    _sectionTitle('Surgery Scheduler', responsive: responsive),
                    SizedBox(height: itemSpacing),
                    _schedulerCard(
                      number: 4,
                      time1: '11:00 am',
                      time2: '02:00 pm',
                      finished: 2,
                      responsive: responsive,
                    ),
                    SizedBox(height: sectionSpacing),
                    _sectionTitle('Intern Doctor', responsive: responsive),
                    SizedBox(height: itemSpacing),
                    _internDoctors(responsive),
                    SizedBox(height: sectionSpacing),
                  ],
                ),
              ),
            ),

            // Right column
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: sectionSpacing),
                    _sectionTitle('Inpatients Check', responsive: responsive),
                    SizedBox(height: itemSpacing),
                    _inpatientsCard(responsive),
                    SizedBox(height: sectionSpacing),
                    _sectionTitle(
                      'Outpatient Appointment',
                      responsive: responsive,
                    ),
                    SizedBox(height: itemSpacing),
                    _schedulerCardOutpatient(
                      number: 11,
                      time1: '3:00 am',
                      time2: '4:30 pm',
                      finished: 4,
                      isDark: true,
                      responsive: responsive,
                    ),
                    SizedBox(height: sectionSpacing),
                    _notesSection(responsive),
                    SizedBox(height: sectionSpacing),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: _bottomNavigationBar(responsive),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: const Color(0xff0B8FAC),
          onPressed: () {
            NavigateTo(context, const BooksViewApiRedesigned());
          },
          child: Icon(
            Icons.add,
            size: responsive.getResponsiveSize(32),
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      );
    } else {
      // Portrait mode or smaller screens use a single column layout
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context, responsive),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: itemSpacing),
              _buildSearchBar(context, responsive, rFonts),
              SizedBox(height: sectionSpacing),
              _sectionTitle(
                'Live Doctors',
                action: Icon(Icons.add),
                responsive: responsive,
              ),
              SizedBox(height: itemSpacing),
              _liveDoctors(responsive),
              SizedBox(height: sectionSpacing),
              _sectionTitle('Surgery Scheduler', responsive: responsive),
              SizedBox(height: itemSpacing),
              _schedulerCard(
                number: 4,
                time1: '11:00 am',
                time2: '02:00 pm',
                finished: 2,
                responsive: responsive,
              ),
              SizedBox(height: sectionSpacing),
              _sectionTitle('Inpatients Check', responsive: responsive),
              SizedBox(height: itemSpacing),
              _inpatientsCard(responsive),
              SizedBox(height: sectionSpacing),
              _sectionTitle('Outpatient Appointment', responsive: responsive),
              SizedBox(height: itemSpacing),
              _schedulerCardOutpatient(
                number: 11,
                time1: '3:00 am',
                time2: '4:30 pm',
                finished: 4,
                isDark: true,
                responsive: responsive,
              ),
              SizedBox(height: sectionSpacing),
              _sectionTitle('Intern Doctor', responsive: responsive),
              SizedBox(height: itemSpacing),
              _internDoctors(responsive),
              SizedBox(height: sectionSpacing),
              _notesSection(responsive),
              SizedBox(height: sectionSpacing),
            ],
          ),
        ),
        bottomNavigationBar: _bottomNavigationBar(responsive),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: const Color(0xff0B8FAC),
          onPressed: () {
            NavigateTo(context, const BooksViewApiRedesigned());
          },
          child: Icon(
            Icons.add,
            size: responsive.getResponsiveSize(32),
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      );
    }
  }

  // Responsive app bar
  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    ResponsiveUtils responsive,
  ) {
    final iconSize = responsive.getResponsiveSize(24);
    final avatarRadius = responsive.getResponsiveSize(22);

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: responsive.getResponsiveSize(60),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu, color: Colors.black, size: iconSize),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_none,
            color: Colors.black,
            size: iconSize,
          ),
        ),
        // Add logout button
        IconButton(
          onPressed: () => _showLogoutDialog(context, responsive),
          icon: Icon(Icons.logout, color: Colors.red.shade300, size: iconSize),
          tooltip: 'Logout',
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(right: responsive.getResponsiveSize(12)),
          child: CircleAvatar(
            radius: avatarRadius,
            backgroundImage: const AssetImage(Imagestyles.DoctorsLogo),
          ),
        ),
      ],
    );
  }

  // Show logout confirmation dialog
  void _showLogoutDialog(BuildContext context, ResponsiveUtils responsive) {
    final dialogTitleStyle = TextStyle(
      fontSize: responsive.fontSize(18),
      fontWeight: FontWeight.bold,
    );

    final dialogContentStyle = TextStyle(fontSize: responsive.fontSize(16));

    final buttonTextStyle = TextStyle(
      fontSize: responsive.fontSize(16),
      fontWeight: FontWeight.bold,
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Logout', style: dialogTitleStyle),
            content: Text(
              'Are you sure you want to logout?',
              style: dialogContentStyle,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: buttonTextStyle.copyWith(color: Colors.grey),
                ),
              ),
              TextButton(
                onPressed: () async {
                  // Close the dialog
                  Navigator.pop(context);

                  // Clear user login state
                  await SessionManager.clearUserLoginState();

                  // Navigate to auth check screen
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AuthCheckScreen(),
                      ),
                      (route) => false,
                    );
                  }
                },
                child: Text(
                  'Logout',
                  style: buttonTextStyle.copyWith(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  // Responsive search bar
  Widget _buildSearchBar(
    BuildContext context,
    ResponsiveUtils responsive,
    ResponsiveFontStyles rFonts,
  ) {
    final height = responsive.getResponsiveSize(40);
    final iconSize = responsive.getResponsiveSize(20);
    final fontSize = responsive.fontSize(14);

    return Card(
      elevation: 10,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: responsive.getResponsiveSize(12),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: responsive.getResponsiveSize(12),
        ),
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey, size: iconSize),
            SizedBox(width: responsive.getResponsiveSize(8)),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search a Doctor',
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: fontSize),
                ),
                style: TextStyle(fontSize: fontSize),
              ),
            ),
            Icon(Icons.mic, color: Colors.grey, size: iconSize),
          ],
        ),
      ),
    );
  }

  // Section title with responsive sizing
  Widget _sectionTitle(
    String title, {
    Widget? action,
    required ResponsiveUtils responsive,
  }) {
    final titleStyle = GoogleFonts.openSans(
      fontSize: responsive.fontSize(16),
      fontWeight: FontWeight.w600,
      color: const Color(0xff333333),
    );

    final actionStyle = GoogleFonts.openSans(
      fontSize: responsive.fontSize(16),
      color: const Color(0xff858585),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: titleStyle),
        action ?? Text('See All', style: actionStyle),
      ],
    );
  }

  // Live doctors section with responsive sizing
  Widget _liveDoctors(ResponsiveUtils responsive) {
    final itemHeight = responsive.getResponsiveSize(160);
    final itemWidth = responsive.getResponsiveSize(120);
    final avatarRadius = responsive.getResponsiveSize(35);
    final iconSize = responsive.getResponsiveSize(16);
    final titleFontSize = responsive.fontSize(12);
    final subtitleFontSize = responsive.fontSize(10);

    return SizedBox(
      height: itemHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
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
                      Icon(
                        Icons.favorite_border,
                        color: const Color(0xff777EA5),
                        size: iconSize,
                      ),
                      const Spacer(),
                      Icon(Icons.star, color: Colors.amber, size: iconSize),
                      SizedBox(width: responsive.getResponsiveSize(4)),
                      Text(
                        '3.7',
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
                  backgroundImage: const AssetImage(Imagestyles.DoctorsLogo),
                  radius: avatarRadius,
                ),
                SizedBox(height: responsive.getResponsiveSize(8)),
                Text(
                  'Dr. Krick',
                  style: GoogleFonts.rubik(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '\$25.00/hour',
                  style: GoogleFonts.rubik(
                    fontSize: subtitleFontSize,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Scheduler card with responsive sizing
  Widget _schedulerCard({
    required int number,
    required String time1,
    required String time2,
    required int finished,
    required ResponsiveUtils responsive,
  }) {
    final cardPadding = responsive.getResponsiveSize(16);
    final titleFontSize = responsive.fontSize(18);
    final subtitleFontSize = responsive.fontSize(14);
    final progressHeight = responsive.getResponsiveSize(8);

    return Container(
      padding: EdgeInsets.all(cardPadding),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$number Surgeries',
                style: GoogleFonts.openSans(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                '$time1 - $time2',
                style: GoogleFonts.openSans(
                  fontSize: subtitleFontSize,
                  color: Colors.grey,
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
                    backgroundColor: Colors.grey.shade200,
                    color: const Color(0xff0B8FAC),
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
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Inpatients card with responsive sizing
  Widget _inpatientsCard(ResponsiveUtils responsive) {
    final cardPadding = responsive.getResponsiveSize(16);
    final imageHeight = responsive.getResponsiveSize(120);
    final titleFontSize = responsive.fontSize(18);
    final subtitleFontSize = responsive.fontSize(14);
    final iconSize = responsive.getResponsiveSize(16);

    return Container(
      padding: EdgeInsets.all(cardPadding),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ward 3, Room 6',
                style: GoogleFonts.openSans(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.getResponsiveSize(8),
                  vertical: responsive.getResponsiveSize(4),
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff0B8FAC).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Critical',
                  style: GoogleFonts.openSans(
                    fontSize: subtitleFontSize,
                    color: const Color(0xff0B8FAC),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: responsive.getResponsiveSize(12)),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              Imagestyles.inpatientImage,
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: responsive.getResponsiveSize(12)),
          Row(
            children: [
              Text(
                'John Doe, 45',
                style: GoogleFonts.openSans(
                  fontSize: subtitleFontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Icon(Icons.access_time, size: iconSize, color: Colors.grey),
              SizedBox(width: responsive.getResponsiveSize(4)),
              Text(
                'Admitted 3 days ago',
                style: GoogleFonts.openSans(
                  fontSize: subtitleFontSize,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: responsive.getResponsiveSize(8)),
          Text(
            'Heart Surgery - Post-op Recovery',
            style: GoogleFonts.openSans(
              fontSize: subtitleFontSize,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // Outpatient scheduler card with responsive sizing
  Widget _schedulerCardOutpatient({
    required int number,
    required String time1,
    required String time2,
    required int finished,
    required bool isDark,
    required ResponsiveUtils responsive,
  }) {
    final cardPadding = responsive.getResponsiveSize(16);
    final titleFontSize = responsive.fontSize(18);
    final subtitleFontSize = responsive.fontSize(14);
    final progressHeight = responsive.getResponsiveSize(8);

    final backgroundColor = isDark ? const Color(0xff0B8FAC) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final subtitleColor = isDark ? Colors.white.withOpacity(0.7) : Colors.grey;
    final progressBackgroundColor =
        isDark ? Colors.white.withOpacity(0.3) : Colors.grey.shade200;
    final progressColor = isDark ? Colors.white : const Color(0xff0B8FAC);

    return Container(
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: backgroundColor,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$number Appointments',
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
    );
  }

  // Intern doctors section with responsive sizing
  Widget _internDoctors(ResponsiveUtils responsive) {
    final itemHeight = responsive.getResponsiveSize(160);
    final itemWidth = responsive.getResponsiveSize(120);
    final avatarRadius = responsive.getResponsiveSize(35);
    final iconSize = responsive.getResponsiveSize(16);
    final titleFontSize = responsive.fontSize(12);
    final subtitleFontSize = responsive.fontSize(10);

    return SizedBox(
      height: itemHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
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
                      Icon(
                        Icons.favorite_border,
                        color: const Color(0xff777EA5),
                        size: iconSize,
                      ),
                      const Spacer(),
                      Icon(Icons.star, color: Colors.amber, size: iconSize),
                      SizedBox(width: responsive.getResponsiveSize(4)),
                      Text(
                        '4.2',
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
                  backgroundImage: const AssetImage(
                    Imagestyles.InternDoctorsLogo,
                  ),
                  radius: avatarRadius,
                ),
                SizedBox(height: responsive.getResponsiveSize(8)),
                Text(
                  'Dr. Smith',
                  style: GoogleFonts.rubik(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '\$15.00/hour',
                  style: GoogleFonts.rubik(
                    fontSize: subtitleFontSize,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Notes section with responsive sizing
  Widget _notesSection(ResponsiveUtils responsive) {
    final cardPadding = responsive.getResponsiveSize(16);
    final titleFontSize = responsive.fontSize(18);
    final contentFontSize = responsive.fontSize(14);
    final iconSize = responsive.getResponsiveSize(20);

    return Container(
      padding: EdgeInsets.all(cardPadding),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.note_alt_outlined,
                size: iconSize,
                color: const Color(0xff0B8FAC),
              ),
              SizedBox(width: responsive.getResponsiveSize(8)),
              Text(
                'Notes',
                style: GoogleFonts.openSans(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: responsive.getResponsiveSize(12)),
          Text(
            'Remember to check on patient in Ward 3 before lunch. Review lab results for Mrs. Johnson.',
            style: GoogleFonts.openSans(
              fontSize: contentFontSize,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: responsive.getResponsiveSize(12)),
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.edit,
              size: iconSize,
              color: const Color(0xff0B8FAC),
            ),
          ),
        ],
      ),
    );
  }

  // Bottom navigation bar with responsive sizing
  Widget _bottomNavigationBar(ResponsiveUtils responsive) {
    final iconSize = responsive.getResponsiveSize(24);
    final barHeight = responsive.getResponsiveSize(60);

    return BottomAppBar(
      height: barHeight,
      shape: const CircularNotchedRectangle(),
      notchMargin: responsive.getResponsiveSize(8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home_outlined, size: iconSize),
            color: const Color(0xff0B8FAC),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.calendar_today_outlined, size: iconSize),
            color: Colors.grey,
            onPressed: () {},
          ),
          const SizedBox(width: 40), // Space for FAB
          IconButton(
            icon: Icon(Icons.chat_bubble_outline, size: iconSize),
            color: Colors.grey,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_outline, size: iconSize),
            color: Colors.grey,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
