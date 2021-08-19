import 'package:flutter/material.dart';
import 'package:firebase_authentication_tutorial/page/sign_in_page.dart';
import 'package:firebase_authentication_tutorial/page/sign_up_page.dart';
import 'package:firebase_authentication_tutorial/page/home_page.dart';

class Routes {
  Routes() {
    runApp(new MaterialApp(
      title: "Routes",
      debugShowCheckedModeBanner: false,
      home: new SignInPage(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/signin':
            return new MyCustomRoute(
              builder: (_) => new SignInPage(),
              settings: settings,
            );
          case '/signup':
            return new MyCustomRoute(
              builder: (_) => new SignUpPage(),
              settings: settings,
            );
        }
      },
    ));
  }
}


class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // if (settings.arguments) return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}