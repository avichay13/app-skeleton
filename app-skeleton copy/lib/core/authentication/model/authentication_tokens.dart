class AuthenticationTokens {
  final String idToken;
  final String refreshToken;
  final int expiration;

  AuthenticationTokens(this.idToken, this.refreshToken, this.expiration);
}