import 'package:flutter/material.dart';
import 'package:login_app/models/user.dart';
import 'package:login_app/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = "/register-screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController cUserNameController = TextEditingController();
  TextEditingController cEmailController = TextEditingController();
  //Define Global key
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration Screen"),
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                    controller: cEmailController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please enter your email id";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Enter Email ID",
                    )),
                TextFormField(
                    controller: cUserNameController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please enter your user id";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Enter User ID",
                    )),
                TextFormField(
                    controller: cPasswordController,
                    obscureText: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please enter your password";
                      }
                      if (val.length < 8) {
                        return "password length must be more than 8";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Enter Password",
                    )),
                TextFormField(
                    obscureText: true,
                    validator: (val) {
                      if (val == null ||
                          val.isEmpty ||
                          cPasswordController.text != val) {
                        return "Please re-enter password to confirm";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                    )),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue, minimumSize: Size(200, 50)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      User u = User(cUserNameController.text,
                          cEmailController.text, cPasswordController.text);
                      allUsers.add(u);
                      showToast(
                          "User Account Register Sucessfully.", Colors.green);
                      Navigator.popAndPushNamed(context, LoginScreen.routeName);
                    }
                  },
                  icon: const Icon(Icons.login),
                  label: const Text("Register"),
                ),
              ],
            ),
          )),
    );
  }
}
