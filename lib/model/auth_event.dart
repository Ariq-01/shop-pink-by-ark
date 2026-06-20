abstract class AuthEvent {}

class SignUpSubmitted extends AuthEvent {
  final String email;
  final String password;

  SignUpSubmitted({required this.email, required this.password});
}

class GoogleSignInSubmitted extends AuthEvent {}
