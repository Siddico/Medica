// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:medical/Constants/constants.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/BooksView/books_view_api_redesigned.dart';
import 'package:medical/Widgets/Common/responsive_bottom_nav_bar.dart';
import 'package:medical/Widgets/Common/responsive_section_title.dart';
import 'package:medical/Widgets/Home/doctor_card.dart';
import 'package:medical/Widgets/Home/responsive_app_bar.dart';
import 'package:medical/Widgets/Home/responsive_search_bar.dart';
import 'package:medical/Widgets/Home/scheduler_card.dart';

class HomeViewRefactored extends StatefulWidget {
  const HomeViewRefactored({super.key});

  @override
  State<HomeViewRefactored> createState() => _HomeViewRefactoredState();
}

class _HomeViewRefactoredState extends State<HomeViewRefactored> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);

    // Determine if we're in landscape mode
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // Responsive spacing values
    final horizontalPadding = responsive.getResponsiveSize(16);
    final verticalPadding = responsive.getResponsiveSize(16);
    final sectionSpacing = responsive.getResponsiveSize(24);
    final itemSpacing = responsive.getResponsiveSize(16);
    final titleTopPadding = responsive.getResponsiveSize(20);
    // ignore: duplicate_ignore
    // ignore: unused_local_variable
    final gridSpacing = responsive.getResponsiveSize(16);

    // Determine grid layout based on screen size and orientation
    final crossAxisCount = isLandscape ? 2 : 1;

    // Bottom navigation items
    final navItems = [
      const ResponsiveBottomNavItem(icon: Icons.home, label: 'Home'),
      const ResponsiveBottomNavItem(
        icon: Icons.calendar_today,
        label: 'Calendar',
      ),
      const ResponsiveBottomNavItem(icon: Icons.message, label: 'Messages'),
      const ResponsiveBottomNavItem(icon: Icons.person, label: 'Profile'),
    ];

    if (isLandscape && responsive.isTablet) {
      // Landscape tablet layout with two columns
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: const ResponsiveAppBar(),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: titleTopPadding),
                    _buildSearchBar(context, responsive),
                    SizedBox(height: sectionSpacing),
                    ResponsiveSectionTitle(
                      title: 'Live Doctors',
                      action: Icon(
                        Icons.add,
                        size: responsive.getResponsiveSize(20),
                      ),
                    ),
                    SizedBox(height: itemSpacing),
                    _buildLiveDoctors(responsive),
                    SizedBox(height: sectionSpacing),
                    const ResponsiveSectionTitle(title: 'Surgery Scheduler'),
                    SizedBox(height: itemSpacing),
                    SchedulerCard(
                      number: 4,
                      time1: '11:00 am',
                      time2: '02:00 pm',
                      finished: 2,
                    ),
                    SizedBox(height: sectionSpacing),
                    const ResponsiveSectionTitle(title: 'Intern Doctor'),
                    SizedBox(height: itemSpacing),
                    _buildInternDoctors(responsive),
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
                    const ResponsiveSectionTitle(title: 'Inpatients Check'),
                    SizedBox(height: itemSpacing),
                    _buildInpatientsCard(responsive),
                    SizedBox(height: sectionSpacing),
                    const ResponsiveSectionTitle(
                      title: 'Outpatient Appointment',
                    ),
                    SizedBox(height: itemSpacing),
                    SchedulerCard(
                      number: 11,
                      time1: '3:00 am',
                      time2: '4:30 pm',
                      finished: 4,
                      isDark: true,
                      title: 'Appointments',
                    ),
                    SizedBox(height: sectionSpacing),
                    _buildNotesSection(responsive),
                    SizedBox(height: sectionSpacing),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: ResponsiveBottomNavBar(
          currentIndex: _currentIndex,
          items: navItems,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
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
        appBar: const ResponsiveAppBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: itemSpacing),
              _buildSearchBar(context, responsive),
              SizedBox(height: sectionSpacing),
              ResponsiveSectionTitle(
                title: 'Live Doctors',
                action: Icon(Icons.add, size: responsive.getResponsiveSize(20)),
              ),
              SizedBox(height: itemSpacing),
              _buildLiveDoctors(responsive),
              SizedBox(height: sectionSpacing),
              const ResponsiveSectionTitle(title: 'Surgery Scheduler'),
              SizedBox(height: itemSpacing),
              SchedulerCard(
                number: 4,
                time1: '11:00 am',
                time2: '02:00 pm',
                finished: 2,
              ),
              SizedBox(height: sectionSpacing),
              const ResponsiveSectionTitle(title: 'Inpatients Check'),
              SizedBox(height: itemSpacing),
              _buildInpatientsCard(responsive),
              SizedBox(height: sectionSpacing),
              const ResponsiveSectionTitle(title: 'Outpatient Appointment'),
              SizedBox(height: itemSpacing),
              SchedulerCard(
                number: 11,
                time1: '3:00 am',
                time2: '4:30 pm',
                finished: 4,
                isDark: true,
                title: 'Appointments',
              ),
              SizedBox(height: sectionSpacing),
              const ResponsiveSectionTitle(title: 'Intern Doctor'),
              SizedBox(height: itemSpacing),
              _buildInternDoctors(responsive),
              SizedBox(height: sectionSpacing),
              _buildNotesSection(responsive),
              SizedBox(height: sectionSpacing),
            ],
          ),
        ),
        bottomNavigationBar: ResponsiveBottomNavBar(
          currentIndex: _currentIndex,
          items: navItems,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
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

  // Responsive search bar
  Widget _buildSearchBar(BuildContext context, ResponsiveUtils responsive) {
    return ResponsiveSearchBar(
      onSearchPressed: () {
        // Handle search
      },
      onVoicePressed: () {
        // Handle voice search
      },
    );
  }

  // Live doctors section with responsive sizing
  Widget _buildLiveDoctors(ResponsiveUtils responsive) {
    return SizedBox(
      height: responsive.getResponsiveSize(160),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return DoctorCard(
            name: 'Dr. Krick',
            hourlyRate: '\$25.00/hour',
            rating: '3.7',
            imagePath: Imagestyles.DoctorsLogo,
            isFavorite: index == 1, // Just for demo
          );
        },
      ),
    );
  }

  // Intern doctors section with responsive sizing
  Widget _buildInternDoctors(ResponsiveUtils responsive) {
    return SizedBox(
      height: responsive.getResponsiveSize(160),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return DoctorCard(
            name: 'Dr. Smith',
            hourlyRate: '\$15.00/hour',
            rating: '4.2',
            imagePath: Imagestyles.InternDoctorsLogo,
            isFavorite: index == 2, // Just for demo
          );
        },
      ),
    );
  }

  // Inpatients card with responsive sizing
  Widget _buildInpatientsCard(ResponsiveUtils responsive) {
    return Container(
      padding: EdgeInsets.all(responsive.getResponsiveSize(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(26), // Equivalent to opacity 0.1
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
                style: TextStyle(
                  fontSize: responsive.fontSize(18),
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
                  color: const Color(
                    0xff0B8FAC,
                  ).withAlpha(26), // Equivalent to opacity 0.1
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Critical',
                  style: TextStyle(
                    fontSize: responsive.fontSize(14),
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
              height: responsive.getResponsiveSize(120),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: responsive.getResponsiveSize(12)),
          Row(
            children: [
              Text(
                'John Doe, 45',
                style: TextStyle(
                  fontSize: responsive.fontSize(14),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.access_time,
                size: responsive.getResponsiveSize(16),
                color: Colors.grey,
              ),
              SizedBox(width: responsive.getResponsiveSize(4)),
              Text(
                'Admitted 3 days ago',
                style: TextStyle(
                  fontSize: responsive.fontSize(14),
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: responsive.getResponsiveSize(8)),
          Text(
            'Heart Surgery - Post-op Recovery',
            style: TextStyle(
              fontSize: responsive.fontSize(14),
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // Notes section with responsive sizing
  Widget _buildNotesSection(ResponsiveUtils responsive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResponsiveSectionTitle(title: 'Notes'),
        SizedBox(height: responsive.getResponsiveSize(12)),
        Container(
          padding: EdgeInsets.all(responsive.getResponsiveSize(16)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(26), // Equivalent to opacity 0.1
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Patient Follow-ups',
                style: TextStyle(
                  fontSize: responsive.fontSize(16),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: responsive.getResponsiveSize(8)),
              Text(
                'Remember to check on Room 302 patient\'s vitals before lunch.',
                style: TextStyle(
                  fontSize: responsive.fontSize(14),
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: responsive.getResponsiveSize(12)),
              Text(
                'Schedule lab tests for new admissions in Ward 4.',
                style: TextStyle(
                  fontSize: responsive.fontSize(14),
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
