import 'package:app_name/core/authentication/model/user_data.dart';
import 'package:app_name/core/authentication/model/user_data.dart';
import 'package:app_name/core/authentication/session_manager.dart';
import 'package:app_name/service_locator.dart';
import 'package:app_name/ui/navigation_drawer_widget/navigation_drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  void _handleLogout() async {
    await _sessionManager.logout();
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }

  String _username() {
    return (_userData == null) ? 'loading...' : _userData!.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_username(), style: Theme.of(context).textTheme.bodyText1),
          ElevatedButton(
            onPressed: _handleLogout,
            child: Text('Logout'),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              textStyle: Theme.of(context).textTheme.button,
            ),
          )
        ],
      ),
      drawer: NavigationDrawerWidget(),
    );
  }
}
