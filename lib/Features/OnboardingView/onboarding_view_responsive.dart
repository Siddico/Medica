import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical/Constants/fontStyles.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/personsView/persons_view_responsive.dart';
import 'package:medical/Models/onboardingViewModel.dart';
import 'package:medical/Utils/session_manager.dart';

class OnboardingViewResponsive extends StatefulWidget {
  const OnboardingViewResponsive({super.key});

  @override
  State<OnboardingViewResponsive> createState() =>
      _OnboardingViewResponsiveState();
}

class _OnboardingViewResponsiveState extends State<OnboardingViewResponsive>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  late final List<OnboardingModel> onboardingData;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    onboardingData = [
      OnboardingModel(
        image: Imagestyles.image1,
        title: 'Find Trusted Doctors',
        description:
            'Easily search for experienced and verified doctors based on specialty, availability, and patient reviews.',
        mode: 0,
      ),
      OnboardingModel(
        image: Imagestyles.logo2,
        title: 'Doctor\'s Calendar & Availability Management',
        description: 'Doctor Schedules & Appointment Slots',
        mode: 1,
      ),
      OnboardingModel(
        image: Imagestyles.logo3,
        title: 'Easy Appointments',
        description:
            'Schedule doctor visits effortlessly with a user-friendly booking system. Choose your preferred date, time, and doctor with just a few clicks.',
        mode: 0,
      ),
      OnboardingModel(
        image: Imagestyles.logo4,
        title: 'Choose Best Doctors',
        description:
            'Find highly rated and trusted doctors based on specialty, experience, and patient reviews.',
        mode: 1,
      ),
      OnboardingModel(
        image: Imagestyles.logo5,
        title: 'Smart Inpatient',
        description:
            'Streamline hospital stays with real-time bed management, patient monitoring, and automated care updates. Ensure a smooth and efficient inpatient experience with digital tracking and seamless communication between medical staff and patients.',
        mode: 0,
      ),
      OnboardingModel(
        image: Imagestyles.logo6,
        title: 'Digital Health Records',
        description:
            '– Securely store and access medical history, prescriptions, test results, and treatment plans in one place. Patients and doctors can easily retrieve past records for accurate diagnoses and better healthcare decisions.',
        mode: 1,
      ),
      OnboardingModel(
        image: Imagestyles.logo7,
        title: 'Fast Billing',
        description:
            'implify payments with a quick and hassle-free billing system. Generate invoices instantly, track payments, and process transactions efficiently for a seamless checkout experience.',
        mode: 0,
      ),
      OnboardingModel(
        image: Imagestyles.logo8,
        title: 'LabPro',
        description:
            'Access reliable medical testing services with ease. Book lab tests online, track your test status, and receive accurate reports digitally.',
        mode: 1,
      ),
      OnboardingModel(
        image: Imagestyles.logo9,
        title: 'Patient Portal',
        description:
            '– Your personalized healthcare hub. Access medical records, track appointments, communicate with doctors, and manage prescriptions',
        mode: 0,
      ),
      OnboardingModel(
        image: Imagestyles.logo10,
        title: 'Queue Manager',
        description:
            'Streamline patient flow with an efficient queue management system. Track waiting times, manage appointments in real time, and ensure a smooth and organized experience for both patients and healthcare providers.',
        mode: 1,
      ),
      OnboardingModel(
        image: Imagestyles.logo11,
        title: 'Auto Reminders',
        description:
            'Never miss an appointment with automated reminders. Patients receive timely notifications via SMS or email for upcoming visits, medication schedules, and follow-ups, ensuring better healthcare management.',
        mode: 0,
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _pageController,
        itemCount: onboardingData.length,
        itemBuilder: (context, index) {
          return OnboardingPageResponsive(
            model: onboardingData[index],
            controller: _pageController,
            currentIndex: index,
            totalPages: onboardingData.length,
          );
        },
      ),
    );
  }
}

class OnboardingPageResponsive extends StatefulWidget {
  final int currentIndex;
  final int totalPages;
  final OnboardingModel model;
  final PageController controller;

  const OnboardingPageResponsive({
    super.key,
    required this.model,
    required this.controller,
    required this.currentIndex,
    required this.totalPages,
  });

  @override
  State<OnboardingPageResponsive> createState() =>
      _OnboardingPageResponsiveState();
}

class _OnboardingPageResponsiveState extends State<OnboardingPageResponsive>
    with TickerProviderStateMixin {
  late AnimationController _imageController;
  late Animation<Offset> _imageAnimation;

  late AnimationController _textController;
  late Animation<Offset> _textAnimation;

  @override
  void initState() {
    super.initState();

    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _imageAnimation = Tween<Offset>(
      begin:
          widget.model.mode == 0 ? const Offset(-1.5, 0) : const Offset(1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _imageController, curve: Curves.easeOut));

    _textAnimation = Tween<Offset>(
      begin:
          widget.model.mode == 0 ? const Offset(0, 1.5) : const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    _imageController.forward();
    _textController.forward();
  }

  @override
  void dispose() {
    _imageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mode = widget.model.mode;
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;

    // Calculate responsive sizes
    final circleSize = responsive.getResponsiveSize(350);
    final imageSize = responsive.getResponsiveSize(300);
    final circleOffset = responsive.getResponsiveSize(180);
    final imageTopPadding = responsive.getResponsiveSize(80);
    final imageHorizontalPadding = responsive.getResponsiveSize(55);
    final contentTopPadding = responsive.getResponsiveSize(400);
    final contentHorizontalPadding = responsive.getResponsiveSize(24);
    final buttonHeight = responsive.getResponsiveSize(48);
    final spacingBetweenElements = responsive.getResponsiveSize(12);

    // Adjust layout for different screen sizes
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final isTablet = responsive.isTablet;

    if (isLandscape) {
      // Landscape layout adjustments
      return SafeArea(
        child: Row(
          children: [
            // Left side with image and circle
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  // Background circle
                  Positioned(
                    top: -circleOffset / 2,
                    left: mode == 0 ? -circleOffset : null,
                    right: mode == 1 ? -circleOffset : null,
                    child: buildCircle(context, mode, circleSize),
                  ),

                  // Main image
                  Center(
                    child: SlideTransition(
                      position: _imageAnimation,
                      child: Container(
                        height: imageSize,
                        width: imageSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(widget.model.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Right side with content
            Expanded(
              flex: 5,
              child: SlideTransition(
                position: _textAnimation,
                child: Padding(
                  padding: EdgeInsets.all(contentHorizontalPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.model.title,
                        style: rFonts.style28wight500,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: spacingBetweenElements),
                      Text(
                        widget.model.description,
                        style: rFonts.style14wight400,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: spacingBetweenElements * 2),
                      _buildNavigationButtons(
                        context,
                        buttonHeight,
                        spacingBetweenElements,
                        rFonts,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // Portrait layout
      return SafeArea(
        child: Stack(
          children: [
            // Background circle
            Positioned(
              top: -circleOffset / 2,
              left: mode == 0 ? -circleOffset : null,
              right: mode == 1 ? -circleOffset : null,
              child: buildCircle(context, mode, circleSize),
            ),

            // Main image
            Positioned(
              top: imageTopPadding,
              left: mode == 0 ? imageHorizontalPadding : null,
              right: mode == 1 ? imageHorizontalPadding : null,
              child: SlideTransition(
                position: _imageAnimation,
                child: Container(
                  height: imageSize,
                  width: imageSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(widget.model.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            // Content
            Positioned(
              top: contentTopPadding,
              left: contentHorizontalPadding,
              right: contentHorizontalPadding,
              child: SlideTransition(
                position: _textAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        widget.model.title,
                        style: rFonts.style28wight500,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: spacingBetweenElements),
                    Center(
                      child: Text(
                        widget.model.description,
                        style: rFonts.style14wight400,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: spacingBetweenElements * 2),
                    _buildNavigationButtons(
                      context,
                      buttonHeight,
                      spacingBetweenElements,
                      rFonts,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildNavigationButtons(
    BuildContext context,
    double buttonHeight,
    double spacing,
    ResponsiveFontStyles rFonts,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (widget.currentIndex == widget.totalPages - 1) {
              // Last page: mark onboarding as completed and navigate
              _completeOnboardingAndNavigate();
            } else {
              // Otherwise: go to next page
              widget.controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          },
          child: Container(
            width: double.infinity,
            height: buttonHeight,
            decoration: BoxDecoration(
              color: const Color(0xFF0B8FAC),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                widget.currentIndex == widget.totalPages - 1
                    ? 'Get Started'
                    : 'Next',
                style: rFonts.style18weight800,
              ),
            ),
          ),
        ),
        SizedBox(height: spacing),
        GestureDetector(
          onTap: () {
            // Skip button: mark onboarding as completed and navigate
            _completeOnboardingAndNavigate();
          },
          child: Text(
            'Skip',
            style: rFonts.style14wight400.copyWith(color: Colors.black38),
          ),
        ),
      ],
    );
  }

  /// Mark onboarding as completed and navigate to the persons view
  Future<void> _completeOnboardingAndNavigate() async {
    // Save onboarding completion status
    await SessionManager.setOnboardingCompleted(true);

    // Navigate to persons view
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PersonsViewResponsive()),
      );
    }
  }
}

Widget buildCircle(BuildContext context, int mode, double size) {
  return Container(
    height: size,
    width: size,
    decoration: const BoxDecoration(
      color: Color(0xFF0B8FAC),
      shape: BoxShape.circle,
    ),
  );
}
