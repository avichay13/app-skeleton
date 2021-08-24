import 'package:app_name/core/authentication/model/user_data.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final UserData userData;

  const ProfileScreen({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(this.userData.getFullName()),
      centerTitle: true,
    ),
    body: Container(
      height: 200.0,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(this.userData.profilePictureUrl),
          fit: BoxFit.fitWidth,
        ),
        shape: BoxShape.rectangle,
      ),
    )
  );
}