import 'package:flutter/material.dart';

// Define Routes
import 'package:firebase_authentication_tutorial/page/sign_in_page.dart';
import 'package:firebase_authentication_tutorial/page/sign_up_page.dart';
import 'package:firebase_authentication_tutorial/page/user_home_page.dart';
import 'package:firebase_authentication_tutorial/page/edit_user_page.dart';

// Route Names
const String signinPage    = 'signin';
const String signupPage    = 'signup';
const String homePage     = 'home';
const String settingsPage = 'settings';

// Control our page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case signinPage:
      return MaterialPageRoute(builder: (context) => SignInPage());
    case signupPage:
      return MaterialPageRoute(builder: (context) => SignUpPage());
    case homePage:
      return MaterialPageRoute(builder: (context) => HomePage());
    case settingsPage:
      return MaterialPageRoute(builder: (context) => EditUserPage());
    default:
      throw('This route name does not exit');
  }
}