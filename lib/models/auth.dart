class AuthResponse {
  String token;
  bool result;
  List<String> errors;

  AuthResponse({
    required this.token,
    required this.result,
    required this.errors,
  });
}
