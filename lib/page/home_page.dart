import 'package:firebase_authentication_tutorial/service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("HOME"),
            ElevatedButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
                _navigateToFirstPage(context);
              },
              child: Text("Sign out"),
            ),
          ],
        ),
      ),
    );
  }

  // usage: signout in any case
  void _navigateToFirstPage(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
