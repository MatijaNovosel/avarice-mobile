class AuthResponse {
  String token;
  bool result;
  List<String> errors;

  AuthResponse({
    this.token,
    this.result,
    this.errors,
  });
}
