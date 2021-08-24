import 'package:app_name/core/authentication/model/authentication_tokens.dart';

class AuthenticationService {
  Future<AuthenticationTokens?> authenticate(String username, String password) async {
    if (password != 'password') return null;
    return AuthenticationTokens('idToken', 'refreshToken', 3600);
  }

  // we send userId and accessToken
  // our backend trying to make request to facebook using this token
  // if fails -> return not good
  // if userId not exists in our system -> create one and return tokens
  // if userId exists in out system -> we know token is valid return tokens
  Future<AuthenticationTokens?> authenticateFacebook(String userId, String accessToken) async {
    return AuthenticationTokens('idToken', 'refreshToken', 3600);
  }
}