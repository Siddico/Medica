import 'package:medical/Models/doctor.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final Doctor doctor; // تغيير User إلى Doctor
  LoginSuccess(this.doctor);
}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}
