import 'package:bloc/bloc.dart';
import 'package:medical/Features/ForgetPasswordView/bloc/password_reset_state.dart';
import 'package:medical/Services/auth_service.dart';

class PasswordResetCubit extends Cubit<PasswordResetState> {
  final AuthService _authService;
  String? _email;
  String? _actionCode;

  PasswordResetCubit(this._authService) : super(PasswordResetInitial());

  // Get the email that was used for password reset
  String? get email => _email;

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    emit(PasswordResetLoading());
    try {
      // Validate email format
      if (!_isValidEmail(email)) {
        emit(PasswordResetFailure('Please enter a valid email address'));
        return;
      }

      // Send password reset email
      await _authService.sendPasswordResetEmail(email);
      _email = email;

      // Emit success state
      emit(EmailSent(email));
    } catch (e) {
      emit(PasswordResetFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  // Verify password reset code from email
  Future<void> verifyActionCode(String code) async {
    emit(PasswordResetLoading());
    try {
      if (code.isEmpty) {
        emit(PasswordResetFailure('Please enter the code from the email'));
        return;
      }

      // Verify the code with Firebase
      bool isValid = await _authService.checkActionCode(code);

      if (!isValid) {
        emit(PasswordResetFailure('Invalid or expired reset link'));
        return;
      }

      // Store the action code for later use
      _actionCode = code;
      emit(CodeVerified(code));
    } catch (e) {
      emit(PasswordResetFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  // Reset password with code from email
  Future<void> confirmPasswordReset(
    String newPassword,
    String confirmPassword,
  ) async {
    emit(PasswordResetLoading());
    try {
      // Validate password
      if (!_isValidPassword(newPassword)) {
        emit(PasswordResetFailure('Password must be at least 6 characters'));
        return;
      }

      // Check if passwords match
      if (newPassword != confirmPassword) {
        emit(PasswordResetFailure('Passwords do not match'));
        return;
      }

      if (_actionCode == null) {
        emit(PasswordResetFailure('Reset code not found. Please start over.'));
        return;
      }

      // Reset the password using Firebase Auth
      await _authService.confirmPasswordReset(_actionCode!, newPassword);

      emit(PasswordChanged());
    } catch (e) {
      emit(PasswordResetFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  // Resend password reset email
  Future<void> resendPasswordResetEmail() async {
    if (_email == null) {
      emit(PasswordResetFailure('Email not found. Please start over.'));
      return;
    }

    emit(PasswordResetLoading());
    try {
      await _authService.sendPasswordResetEmail(_email!);
      emit(PasswordResetSuccess('Password reset email sent'));
      emit(EmailSent(_email!));
    } catch (e) {
      emit(PasswordResetFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  // Reset the state
  void reset() {
    _email = null;
    _actionCode = null;
    emit(PasswordResetInitial());
  }

  // Validate email format
  bool _isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }

  // Validate password strength
  bool _isValidPassword(String password) {
    return password.length >= 6;
  }
}
