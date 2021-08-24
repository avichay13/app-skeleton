import 'package:app_name/core/authentication/authentication_service.dart';
import 'package:app_name/core/authentication/model/authentication_tokens.dart';
import 'package:app_name/core/authentication/model/enum/user_type_enum.dart';
import 'package:app_name/core/authentication/model/facebook_user_data.dart';
import 'package:app_name/core/authentication/users_service.dart';
import 'package:app_name/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert';

import 'model/user_data.dart';

class SessionManager {
  AuthenticationService _authenticationService = locator<AuthenticationService>();
  UsersService _usersService = locator<UsersService>();
  static const String USER_DATA_STRING_KEY = 'authentication_service_user_data_string_key';
  static const String ID_TOKEN_KEY = 'authentication_service_id_token_key';
  static const String REFRESH_TOKEN_KEY = 'authentication_service_refresh_token_key';
  UserData? _userData;
  late SharedPreferences _sharedPreferencesInstance;
  static final FacebookLogin _facebookLogin = new FacebookLogin();

  Future<void> init() async {
    _sharedPreferencesInstance = await SharedPreferences.getInstance();
    String? userDataString = _sharedPreferencesInstance.getString(USER_DATA_STRING_KEY);
    if (userDataString == null || userDataString.isEmpty) return;
    _userData = UserData.fromJson(json.decode(userDataString));
  }

  void _persistUserData(String? userDataString) {
    if (userDataString == null) {
      _sharedPreferencesInstance.remove(USER_DATA_STRING_KEY);
    } else {
      _sharedPreferencesInstance.setString(USER_DATA_STRING_KEY, userDataString);
    }
  }

  Future<bool> login(String username, String password) async {
    AuthenticationTokens? tokens = await _authenticationService.authenticate(username, password);
    if (tokens == null) return false;
    _sharedPreferencesInstance.setString(ID_TOKEN_KEY, tokens.idToken);
    _sharedPreferencesInstance.setString(REFRESH_TOKEN_KEY, tokens.idToken);
    String? userId = _usersService.getUserIdByUsername(username);
    if (userId == null) return false;
    UserData? userData = await _usersService.getUserData(userId, username, null);
    if (userData == null) return false;
    _userData = userData;
    _persistUserData(json.encode(_userData!.toJson()));
    return true;
  }

  Future<bool> loginWithFacebook() async {
    FacebookLoginResult facebookLoginResult = await _facebookLogin.logIn(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        return false;
      case FacebookLoginStatus.cancelledByUser:
        return false;
      case FacebookLoginStatus.loggedIn:
        FacebookAccessToken token = facebookLoginResult.accessToken;
        AuthenticationTokens? tokens = await _authenticationService.authenticateFacebook(token.userId, token.token);
        if (tokens == null) return false;
        _sharedPreferencesInstance.setString(ID_TOKEN_KEY, tokens.idToken);
        _sharedPreferencesInstance.setString(REFRESH_TOKEN_KEY, tokens.idToken);
        UserData? userData = await _usersService.getUserData(token.userId, null, token.token);
        if (userData == null) return false;
        _userData = userData;
        _persistUserData(json.encode(_userData!.toJson()));
        return true;
    }
    return false;
  }

  Future<void> logout() async {
    if (_userData!.userType == UserType.FACEBOOK_USER) {
      await _facebookLogin.logOut();
    }
    _persistUserData(null);
    _userData = null;
  }

  UserData? getUserData() {
    return _userData;
  }

  bool isLoggedIn() {
    return _userData != null;
  }
}