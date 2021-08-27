import 'package:app_name/core/authentication/model/user_data.dart';
import 'package:app_name/core/authentication/session_manager.dart';
import 'package:app_name/service_locator.dart';
import 'package:app_name/theme/custom_theme.dart';
import 'package:app_name/ui/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawerWidget> {
  SessionManager _sessionManager = locator<SessionManager>();
  UserData? _userData;


  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() {
    UserData? userData = _sessionManager.getUserData();
    setState(() {
      _userData = userData;
    });
  }

  String getName() {
    return (_userData == null) ? 'loading...' : _userData!.getFullName();
  }

  String getUserName() {
    return (_userData == null) ? 'loading...' : _userData!.username;
  }

  String getProfilePictureUrl() {
    return (_userData == null) ? '' : _userData!.profilePictureUrl;
  }

  String getEmail() {
    return (_userData == null) ? 'loading...' : _userData!.email;
  }

  void _handleLogout() async {
    await _sessionManager.logout();
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }

  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: getProfilePictureUrl(),
              name: getName(),
              email: getEmail(),
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  userData: _userData!,
                ),
              )),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  buildMenuItem(
                    text: 'People',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Favourites',
                    icon: Icons.favorite_border,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Settings',
                    icon: Icons.settings,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.logout,
                    onClicked: () => _handleLogout(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: CustomTheme.overColorTextColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: CustomTheme.overColorTextColor),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
      // Navigator.of(context).push(MaterialPageRoute(
      // builder: (context) => PeoplePage(),
      // ));
        break;
      case 1:
      // Navigator.of(context).push(MaterialPageRoute(
      // builder: (context) => FavouritesPage(),
      // ));
        break;
    }
  }
}
