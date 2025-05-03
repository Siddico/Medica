import 'package:bloc/bloc.dart';
import 'package:medical/Features/ProfileView/bloc/profile_state.dart';
import 'package:medical/Models/doctor.dart';
import 'package:medical/Services/auth_service.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthService _authService;

  ProfileCubit(this._authService) : super(ProfileInitial());

  // Load user profile
  Future<void> loadUserProfile() async {
    emit(ProfileLoading());
    try {
      final doctor = await _authService.getCurrentUserProfile();
      if (doctor != null) {
        emit(ProfileLoaded(doctor));
      } else {
        emit(ProfileFailure('Failed to load profile'));
      }
    } catch (e) {
      emit(ProfileFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  // Update user profile
  Future<void> updateUserProfile({
    required String fullName,
    required String specialization,
    required String experienceYears,
  }) async {
    emit(ProfileLoading());
    try {
      await _authService.updateUserProfile(
        fullName: fullName,
        specialization: specialization,
        experienceYears: experienceYears,
      );
      
      // Reload the profile after update
      final doctor = await _authService.getCurrentUserProfile();
      if (doctor != null) {
        emit(ProfileUpdateSuccess());
        emit(ProfileLoaded(doctor));
      } else {
        emit(ProfileFailure('Failed to reload profile after update'));
      }
    } catch (e) {
      emit(ProfileFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
