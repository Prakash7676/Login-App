import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_app/function.dart';
import 'package:login_app/models/user.dart';
import 'package:login_app/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login-screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController cUsername = TextEditingController();

  TextEditingController cPassword = TextEditingController();
  bool showPassword = false;
  var users;
  @override
  void initState() {
    getDetails();

    super.initState();
  }

  void getDetails() async {
    var users = await provideUserDetails();
    if (users[2] == true) {
      Navigator.popAndPushNamed(context, HomeScreen.routeName, arguments: {
        'username': users[0].toString(),
        'password': "" //no need
      });
    }
  }

//Let say this is our uername and password.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const FlutterLogo(
              size: 100,
            ),
            const Text(
              "Welcome to Circle",
              style: TextStyle(fontSize: 22),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: cUsername,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 17),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(width: 8.0)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide:
                        const BorderSide(width: 0.8, color: Colors.green),
                  ),
                  hintText: "Enter Username",
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: cPassword,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 17),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(width: 0.8)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide:
                        const BorderSide(width: 0.8, color: Colors.green),
                  ),
                  hintText: "Enter Password",
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: const Icon(Icons.visibility)),
                  prefixIcon: const Icon(Icons.password),
                ),
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue, minimumSize: Size(200, 50)),
              onPressed: () {
                if (allUsers.isEmpty) {
                  showToast("No User Available. Create Account First.",
                      Colors.yellow);
                  return;
                }
                if (cUsername.text.isNotEmpty && cPassword.text.isNotEmpty) {
                  // ignore: avoid_function_literals_in_foreach_calls
                  allUsers.forEach((user) {
                    String username = user.name;
                    String password = user.password;

                    if (cUsername.text == username &&
                        cPassword.text == password) {
                      Navigator.popAndPushNamed(context, HomeScreen.routeName,
                          arguments: {
                            'username': cUsername.text,
                            'password': cPassword.text,
                          });
                      //TODO:Write save code

                      showToast("Sucessfully logged in", Colors.green);
                      saveUserDetails(user);
                    }
                  });

                  // showToast("Invalid username or password");
                } else {
                  showToast("Enter username or password", Colors.red);
                }
              },
              icon: const Icon(Icons.login),
              label: const Text("Login"),
            ),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.password_rounded),
                label: const Text("Forget Password")),
            TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.routeName);
                },
                icon: const Icon(Icons.person_add),
                label: const Text("Create New User"))
          ],
        ),
      ),
    );
  }
}

showToast(String msg, Color color) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}
