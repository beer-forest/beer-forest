import 'package:firebase_authentication_tutorial/route/route.dart' as route;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_tutorial/service/authentication_service.dart';
import 'package:firebase_authentication_tutorial/provider/users.dart';
import 'package:firebase_authentication_tutorial/service/locator.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  setupServices();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'learnmate';
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
        ),
        ChangeNotifierProvider<UsersProvider >(
          create: (_) => UsersProvider(),
        ),
      ],

      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: AuthenticationWrapper(),
        onGenerateRoute: route.controller,
        // TODO(chococigar@), DEVTEST remove after dev testing
        initialRoute: route.Home, // initialRoute: route.SignIn,

      ),
    );
  }
}


/*
class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    // print("main.dart auth wrapper");
    Navigator.of(context).popUntil(ModalRoute.withName("/"));
    // Navigator.of(context).pushReplacement(ModalRoute.withName("/"));
    /*
    if (firebaseUser != null) {
      print("USER EXISTS!!!!!!");
      return HomePage();
    }
    return SignInPage();
    */
  }
}
*/