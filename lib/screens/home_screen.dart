import 'dart:io';

import 'package:flutter/material.dart';
import 'package:login_app/function.dart';
import 'package:login_app/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home-screen";
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final userName = routeArgs['username'];
    final password = routeArgs['password'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Column(
            children: [
              Text(
                //when user login than hello admin will show in homescreen
                "Hello $userName",
                style: TextStyle(fontSize: 25),
              ),
              MaterialButton(
                  child: Text("Logout"),
                  onPressed: () async {
                    bool result = await clearUserDetails();
                    if (result) {
                      showToast("User Logged out Successfully", Colors.indigo);

                      Navigator.popAndPushNamed(context, LoginScreen.routeName);
                    } else {
                      showToast("Failed to Logged out", Colors.indigo);
                    }
                  })
            ],
          ))
        ],
      ),
    );
  }
}
