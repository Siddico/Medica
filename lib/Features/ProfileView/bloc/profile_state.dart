import 'package:medical/Models/doctor.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Doctor doctor;

  ProfileLoaded(this.doctor);
}

class ProfileUpdateSuccess extends ProfileState {}

class ProfileFailure extends ProfileState {
  final String error;

  ProfileFailure(this.error);
}
