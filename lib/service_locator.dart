import 'package:app_name/core/authentication/authentication_service.dart';
import 'package:app_name/core/authentication/session_manager.dart';
import 'package:app_name/core/authentication/users_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(AuthenticationService());
  locator.registerSingleton(UsersService());
  locator.registerSingleton(SessionManager());
}