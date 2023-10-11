import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mcbike/auth/auth_service.dart';

class ClaimService {
  late Map<String, dynamic> _decodedToken;
  late int userID;
  late String username;

  ClaimService() {
    final jwtToken = AuthService.jwtToken;
    if (jwtToken != null) {
      _decodedToken = JwtDecoder.decode(jwtToken);
      userID = int.parse(_decodedToken['userid']);
      username = _decodedToken['username'];
    }
  }
}
