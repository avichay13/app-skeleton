import 'package:app_name/core/authentication/model/enum/user_type_enum.dart';

class UserData {
  String id;
  String username;
  String email;
  String firstName;
  String lastName;
  String profilePictureUrl;
  UserType userType;

  UserData(this.id, this.username, this.email, this.firstName, this.lastName, this.profilePictureUrl, this.userType);

  factory UserData.fromJson(dynamic json) {
    return UserData(
        json['id'] as String,
        json['username'] as String,
        json['email'] as String,
        json['firstName'] as String,
        json['lastName'] as String,
        json['profilePictureUrl'] as String,
        enumFromString(json['userType']),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'profilePictureUrl': profilePictureUrl,
      'userType': stringRepresentation(userType),
    };
  }

  String getFullName() {
    return '$firstName $lastName';
  }
}