// Obtain shared preferences.
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';

void saveUserDetails(User u) async {
  final prefs = await SharedPreferences.getInstance();
  // Save an String value to 'action' key.
  await prefs.setString('username', u.name);
  await prefs.setString('email', u.email);
  await prefs.setBool('isLoggedIn', true);
  print("Data Saved Sucessfully");
}

provideUserDetails() async {
  final prefs = await SharedPreferences.getInstance();
// Try reading data from the 'action' key. If it doesn't exist, returns null.
  final String? username = prefs.getString('username');
  final String? email = prefs.getString('email');
  final bool? isLoggedIn = prefs.getBool('isLoggedIn');

  return [username, email, isLoggedIn];
}

Future<bool> clearUserDetails() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    // Save an String value to 'action' key.
    await prefs.setString('username', '');
    await prefs.setString('email', '');
    await prefs.setBool('isLoggedIn', false);
    return true;
  } catch (e) {
    return false;
  }
}
