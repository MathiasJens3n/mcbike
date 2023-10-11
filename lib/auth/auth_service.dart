class AuthService {
  static String? _jwtToken;
  static String? get jwtToken => _jwtToken;

  static void setToken(String token) {
    _jwtToken = token;
  }

  static void clearToken() {
    _jwtToken = null;
  }
}
