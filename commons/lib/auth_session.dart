class AuthSession {
  AuthSession._();

  static final AuthSession instance = AuthSession._();

  String? _token;
  int? _userId;

  String? get token => _token;
  int? get userId => _userId;

  void setLoggedUser({required String token, required int userId}) {
    if (token.isEmpty || userId <= 0) {
      throw ArgumentError('tokenInvalido');
    }

    _token = token;
    _userId = userId;
  }
}
