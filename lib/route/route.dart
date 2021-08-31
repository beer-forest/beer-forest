import 'package:flutter/material.dart';

// Define Routes
import 'package:firebase_authentication_tutorial/page/sign_in_page.dart';
import 'package:firebase_authentication_tutorial/page/sign_up_page.dart';
import 'package:firebase_authentication_tutorial/page/home_page.dart';
import 'package:firebase_authentication_tutorial/page/edit_profile_page.dart';
import 'package:firebase_authentication_tutorial/page/edit_profile_first_page.dart';

// Route Names
const String SignIn            = 'SignInPage';
const String SignUp            = 'SignUpPage';
const String Home              = 'HomePage';
const String EditProfile       = 'EditProfilePage';
const String EditProfileFirst  = 'EditProfileFirstPage';
// const String settingsPage = 'settings';

// Control our page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case SignIn:
      return MaterialPageRoute(builder: (context) => SignInPage());
    case SignUp:
      return MaterialPageRoute(builder: (context) => SignUpPage());
    case Home:
      return MaterialPageRoute(builder: (context) => HomePage());
    case EditProfile:
      return MaterialPageRoute(builder: (context) => EditProfilePage());
    case EditProfileFirst:
      return MaterialPageRoute(builder: (context) => EditProfileFirstPage());
    default:
      throw('This route name does not exit');
  }
}