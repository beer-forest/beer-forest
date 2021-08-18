import 'package:firebase_authentication_tutorial/service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: "Name",
            ),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "Password",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Back to login"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationService>().signUp(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              );
              _navigateToHomePage(context);
            },
            child: Text("Sign up"),
          )
        ],
      ),
    );
  }

  // signed out --> signin in any case
  void _navigateToHomePage(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => HomePage()
        )
    );
  }
}
