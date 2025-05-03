abstract class PasswordResetState {}

class PasswordResetInitial extends PasswordResetState {}

class PasswordResetLoading extends PasswordResetState {}

class PasswordResetSuccess extends PasswordResetState {
  final String message;
  PasswordResetSuccess(this.message);
}

class PasswordResetFailure extends PasswordResetState {
  final String error;
  PasswordResetFailure(this.error);
}

class EmailSent extends PasswordResetState {
  final String email;
  EmailSent(this.email);
}

class CodeVerified extends PasswordResetState {
  final String code;
  CodeVerified(this.code);
}

class PasswordChanged extends PasswordResetState {}
