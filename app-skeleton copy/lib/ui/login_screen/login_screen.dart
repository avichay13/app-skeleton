import 'package:app_name/core/authentication/session_manager.dart';
import 'package:app_name/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _username = '', _password = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SessionManager _sessionManager = locator<SessionManager>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
  }

  void _loginPressed() async {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      bool session = await _sessionManager.login(_username, _password);
      if (session) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/home'));
      } else {
        showInSnackBar('Incorrect credentials');
      }
    }
  }

  void _loginWithFacebookPressed() async {
    bool session = await _sessionManager.loginWithFacebook();
    if (session) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/home'));
    } else {
      showInSnackBar('Incorrect credentials');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 300.0,
                    width: double.infinity,
                    decoration: new BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      image: new DecorationImage(
                          image: new AssetImage('assets/images/logo_head.png'),
                          fit: BoxFit.fitWidth
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                    child: Column(
                      children: [
                        TextFormField(
                          key: Key("_mobile"),
                          decoration: InputDecoration(labelText: "Username", labelStyle: Theme.of(context).textTheme.bodyText1),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (String? value) {
                            _username = (value != null) ? value : '';
                          },
                          validator: (value) {
                            return (value!.isEmpty) ? 'Username is required' : null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Password", labelStyle: Theme.of(context).textTheme.bodyText1),
                          obscureText: true,
                          style: Theme.of(context).textTheme.bodyText1,
                          onSaved: (String? value) {
                            _password = (value != null) ? value : '';
                          },
                          validator: (value) {
                            return (value!.isEmpty) ? 'Password is required' : null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: _loginPressed,
                              child: Text('Log In'),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 40),
                                primary: Theme.of(context).primaryColor,
                                textStyle: Theme.of(context).textTheme.button,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                            SignInButton(
                              Buttons.FacebookNew,
                              onPressed: _loginWithFacebookPressed,
                              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 5),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
