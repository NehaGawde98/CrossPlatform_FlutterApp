import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AuthService {

  Future<ParseUser?> signUp(String email, String password) async {
      final user = ParseUser(email, password, email); // username, password, email

      final response = await user.signUp();

      if (response.success && response.results != null) {
        return response.results!.first as ParseUser;
      } else {
        print('SignUp Error: ${response.error?.message}');
        return null;
      }
    }

    //Login method
    Future<ParseUser?> login(String email, String password) async {
      final user = ParseUser(email, password, null);
      final response = await user.login();

      if (response.success && response.results != null) {
        return response.results!.first as ParseUser;
      } else {
        print('Login Error: ${response.error?.message}');
        return null;
      }
    }

  Future<void> logout() async {
    final user = await ParseUser.currentUser() as ParseUser;
    await user.logout();
  }

  Future<bool> isUserLoggedIn() async {
    final user = await ParseUser.currentUser();
    return user != null;
  }
}
