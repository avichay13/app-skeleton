import 'dart:collection';
import 'dart:convert';
import 'package:app_name/core/authentication/model/facebook_user_data.dart';
import 'package:http/http.dart' as http;

import 'package:app_name/core/authentication/model/user_data.dart';

class UsersService {
  final Map<String, String> _users = {
    'ran_emuna_user_id': '{"id": "ran_emuna_user_id", "username": "ran.emuna", "email": "ran.emuna@email.com", "firstName": "Ran", "lastName": "Emuna", "profilePictureUrl": "https://scontent.ftlv1-1.fna.fbcdn.net/v/t31.18172-8/856554_4023405958512_1629729008_o.jpg?_nc_cat=103&ccb=1-4&_nc_sid=de6eea&_nc_ohc=iCLcSwVkbwoAX_joFDD&_nc_ht=scontent.ftlv1-1.fna&oh=3931921b7b539d1d832909b3b63ec89c&oe=613BF13B", "userType": "APP_USER"}',
    'aviv_alush_user_id': '{"id": "aviv_alush_user_id", "username": "aviv.alush", "email": "aviv.alush@email.com", "firstName": "Aviv", "lastName": "Alush", "profilePictureUrl": "https://scontent.ftlv1-1.fna.fbcdn.net/v/t31.18172-8/1074591_10153058161065392_1098245529_o.jpg?_nc_cat=108&ccb=1-4&_nc_sid=174925&_nc_ohc=zFnzwRYZkdMAX8oT32d&tn=cnx977307eb4QIXl&_nc_ht=scontent.ftlv1-1.fna&oh=474f0d5c421fe2f64618a282160b34e6&oe=613B8F15", "userType": "APP_USER"}',
    'adi_attlan_user_id': '{"id": "adi_attlan_user_id", "username": "adi.attlan", "email": "adi.attlan@email.com", "firstName": "Adi", "lastName": "Attlan", "profilePictureUrl": "https://scontent.ftlv1-1.fna.fbcdn.net/v/t1.18169-9/480010_422178841205084_1296397035_n.jpg?_nc_cat=109&ccb=1-4&_nc_sid=de6eea&_nc_ohc=H6nRpWRqJisAX9dDFqW&_nc_ht=scontent.ftlv1-1.fna&oh=fb11554c578857cc832932735128f758&oe=61394280", "userType": "APP_USER"}',
    'avichay_attlan_user_id': '{"id": "avichay_attlan_user_id", "username": "avichay.attlan", "email": "avichay.attlan@email.com", "firstName": "avichay", "lastName": "Attlan", "profilePictureUrl": "https://scontent.ftlv1-1.fna.fbcdn.net/v/t1.18169-9/643994_10152131970075136_701978243_n.jpg?_nc_cat=104&ccb=1-4&_nc_sid=de6eea&_nc_ohc=axTuDTqwqm8AX_Kcl38&tn=cnx977307eb4QIXl&_nc_ht=scontent.ftlv1-1.fna&oh=2f37b3371d92b9eb24d9a4e903c74a2a&oe=613C0361", "userType": "APP_USER"}',
  };
  // username and facebook access token are temporary until we have a backend
  Future<UserData?> getUserData(String userId, String? username, String? facebookAccessToken) async {
    String? userDataString = '';
    if (username != null) { // APP_USER case
      userDataString = _getUserData(userId);
    } else if (facebookAccessToken != null) { // FACEBOOK_USER case
      final graphResponse = await http.get(Uri.parse('https://graph.facebook.com/v11.0/me?fields=name,first_name,last_name,email,picture.width(800).height(800)&access_token=$facebookAccessToken'));
      String facebookUserDataString = graphResponse.body;
      FacebookUserData userData = FacebookUserData.fromJson(json.decode(facebookUserDataString));
      userDataString = userData.toUserDataString();
    }
    if (userDataString == null) return null;
    return UserData.fromJson(json.decode(userDataString));
  }

  String? getUserIdByUsername(String username) {
    for (String userData in _users.values) {
      final userDataJson = json.decode(userData);
      if (userDataJson['username'] == username) return userDataJson['id'];
    }
    return null;
  }

  String? _getUserData(String userId) {
    if (!_users.containsKey(userId)) return null;
    return _users[userId];
  }
}