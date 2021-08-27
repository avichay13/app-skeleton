class FacebookPictureData {
  int height;
  int width;
  bool isSilhouette;
  String url;

  FacebookPictureData(this.height, this.width, this.isSilhouette, this.url);

  factory FacebookPictureData.fromJson(dynamic json) {
    return FacebookPictureData(
      json['height'] as int,
      json['width'] as int,
      json['is_silhouette'] as bool,
      json['url'] as String,
    );
  }
}

class FacebookPicture {
  FacebookPictureData data;

  FacebookPicture(this.data);

  factory FacebookPicture.fromJson(dynamic json) {
    return FacebookPicture(FacebookPictureData.fromJson(json['data']));
  }
}

class FacebookUserData {
  String name;
  String firstName;
  String lastName;
  String email;
  FacebookPicture picture;
  String id;

  FacebookUserData(this.name, this.firstName, this.lastName, this.email, this.picture, this.id);

  factory FacebookUserData.fromJson(dynamic json) {
    return FacebookUserData(
        json['name'] as String,
        json['first_name'] as String,
        json['last_name'] as String,
        json['email'] as String,
        FacebookPicture.fromJson(json['picture']),
        json['id'] as String,
    );
  }

  String toUserDataString() {
    return '{"id": "$id", "username": "$email", "email": "$email", "firstName": "$firstName", "lastName": "$lastName", "profilePictureUrl": "${picture.data.url}", "userType": "FACEBOOK_USER"}';
  }
}