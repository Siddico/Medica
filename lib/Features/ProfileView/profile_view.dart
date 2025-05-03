import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medical/Constants/imageStyles.dart';
import 'package:medical/Constants/responsive_font_styles.dart';
import 'package:medical/Constants/responsive_utils.dart';
import 'package:medical/Features/ProfileView/bloc/profile_cubit.dart';
import 'package:medical/Features/ProfileView/bloc/profile_state.dart';
import 'package:medical/Services/auth_service.dart';
import 'package:medical/Widgets/Common/responsive_button.dart';
import 'package:medical/Widgets/Common/responsive_text_field.dart';
import 'package:medical/Widgets/Common/responsive_wrapper.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _experienceYearsController =
      TextEditingController();

  bool _isEditing = false;
  bool _fullNameError = false;
  bool _specializationError = false;
  bool _experienceYearsError = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _specializationController.dispose();
    _experienceYearsController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;

      // Reset validation errors when toggling edit mode
      _fullNameError = false;
      _specializationError = false;
      _experienceYearsError = false;
    });
  }

  bool _validateFields() {
    setState(() {
      _fullNameError = _fullNameController.text.trim().isEmpty;
      _specializationError = _specializationController.text.trim().isEmpty;
      _experienceYearsError = _experienceYearsController.text.trim().isEmpty;
    });

    return !_fullNameError && !_specializationError && !_experienceYearsError;
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    final rFonts = context.responsiveFontStyles;

    return BlocProvider(
      create: (context) => ProfileCubit(AuthService())..loadUserProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileFailure) {
            Fluttertoast.showToast(
              msg: state.error,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          } else if (state is ProfileUpdateSuccess) {
            Fluttertoast.showToast(
              msg: "Profile updated successfully",
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
            _toggleEditMode(); // Exit edit mode after successful update
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading && _fullNameController.text.isEmpty) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is ProfileLoaded && !_isEditing) {
            // Update controllers with the loaded data
            _fullNameController.text = state.doctor.fullName;
            _emailController.text = state.doctor.email;
            _specializationController.text = state.doctor.specialization;
            _experienceYearsController.text = state.doctor.experience;
          }

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: SvgPicture.asset(
                  Imagestyles.goBack,
                  width: responsive.getResponsiveSize(24),
                  height: responsive.getResponsiveSize(24),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text('Profile', style: rFonts.style22weight600),
              centerTitle: true,
              actions: [
                if (!_isEditing)
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xffD9D9D9),
                    ),
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: const Color(0xff0B8FAC),
                          size: responsive.getResponsiveSize(24),
                        ),
                        onPressed: _toggleEditMode,
                      ),
                    ),
                  ),
                if (_isEditing)
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                      size: responsive.getResponsiveSize(24),
                    ),
                    onPressed: () {
                      // Reset controllers to original values if in ProfileLoaded state
                      if (state is ProfileLoaded) {
                        _fullNameController.text = state.doctor.fullName;
                        _specializationController.text =
                            state.doctor.specialization;
                        _experienceYearsController.text =
                            state.doctor.experience;
                      }
                      _toggleEditMode();
                    },
                  ),

                SizedBox(width: 16),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: ResponsiveStack(
                  mainContent: Padding(
                    padding: responsive.getPadding(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile avatar
                        Center(
                          child: CircleAvatar(
                            radius: responsive.getResponsiveSize(50),
                            backgroundColor: const Color(
                              0xff0B8FAC,
                            ).withOpacity(0.2),
                            child: Icon(
                              Icons.person,
                              size: responsive.getResponsiveSize(50),
                              color: const Color(0xff0B8FAC),
                            ),
                          ),
                        ),
                        responsive.verticalSpace(30),

                        // Full Name
                        Text('Full Name', style: rFonts.style22weight600),
                        SizedBox(height: responsive.getResponsiveSize(8)),
                        ResponsiveTextField(
                          controller: _fullNameController,
                          hintText: 'Enter Your Full Name',
                          enabled: _isEditing,
                          hasError: _fullNameError,
                          errorText: 'Full name is required',
                        ),
                        responsive.verticalSpace(25),

                        // Email
                        Text('Email', style: rFonts.style22weight600),
                        SizedBox(height: responsive.getResponsiveSize(8)),
                        ResponsiveTextField(
                          controller: _emailController,
                          hintText: 'Enter Your Email',
                          enabled: false, // Email cannot be changed
                        ),
                        responsive.verticalSpace(25),

                        // Specialization
                        Text('Specialization', style: rFonts.style22weight600),
                        SizedBox(height: responsive.getResponsiveSize(8)),
                        ResponsiveTextField(
                          controller: _specializationController,
                          hintText: 'Enter Your Specialization',
                          enabled: _isEditing,
                          hasError: _specializationError,
                          errorText: 'Specialization is required',
                        ),
                        responsive.verticalSpace(25),

                        // Experience Years
                        Text(
                          'Years of Experience',
                          style: rFonts.style22weight600,
                        ),
                        SizedBox(height: responsive.getResponsiveSize(8)),
                        ResponsiveTextField(
                          controller: _experienceYearsController,
                          hintText: 'Enter Your Years of Experience',
                          keyboardType: TextInputType.number,
                          enabled: _isEditing,
                          hasError: _experienceYearsError,
                          errorText: 'Years of experience is required',
                        ),
                        responsive.verticalSpace(25),

                        // Update button (only visible in edit mode)
                        if (_isEditing)
                          ResponsiveButton(
                            text: 'Update Profile',
                            isLoading: state is ProfileLoading,
                            onPressed: () {
                              if (_validateFields()) {
                                context.read<ProfileCubit>().updateUserProfile(
                                  fullName: _fullNameController.text.trim(),
                                  specialization:
                                      _specializationController.text.trim(),
                                  experienceYears:
                                      _experienceYearsController.text.trim(),
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Please fix the validation errors",
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                );
                              }
                            },
                          ),

                        // Change Password button
                        responsive.verticalSpace(20),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/forgot-password');
                            },
                            child: Container(
                              height: 45,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Color(0xffD9D9D9),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text(
                                  'Change Password',
                                  style: rFonts.style16weight700.copyWith(
                                    color: const Color(0xff0B8FAC),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        responsive.verticalSpace(20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
