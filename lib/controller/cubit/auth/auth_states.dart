abstract class AuthState {}

class AuthInitial extends AuthState {}

class ChangeObscure extends AuthState {}

class AuthLoadingLogin extends AuthState {}

class AuthSuccessLogin extends AuthState {}

class AuthFailureLogin extends AuthState {
  final String errorMessage;

  AuthFailureLogin({required this.errorMessage});
}

class AuthLoadingRegister extends AuthState {}

class AuthSuccessRegister extends AuthState {}

class AuthFailureRegister extends AuthState {
  final String errorMessage;

  AuthFailureRegister({required this.errorMessage});
}
