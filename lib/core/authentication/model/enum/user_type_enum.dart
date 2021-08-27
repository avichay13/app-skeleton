enum UserType {
  APP_USER,
  FACEBOOK_USER,
}

String stringRepresentation(UserType userType) {
  switch (userType) {
    case UserType.APP_USER:
      return 'APP_USER';
    case UserType.FACEBOOK_USER:
      return 'FACEBOOK_USER';
  }
}

UserType enumFromString(String stringValue) {
  switch (stringValue) {
    case 'FACEBOOK_USER':
      return UserType.FACEBOOK_USER;
    case 'APP_USER':
    default:
      return UserType.APP_USER;
  }
}