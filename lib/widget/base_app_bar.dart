import 'package:firebase_authentication_tutorial/route/route.dart' as route;
import 'package:firebase_authentication_tutorial/service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<StatefulWidget> createState() => _BaseAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BaseAppBarState extends State<BaseAppBar>{

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: new InkWell(
          child: Text("learnmate"),
          onTap: () => Navigator.of(context).pushNamed(route.Home)
      ),
      leading: IconButton(
        icon: Icon(Icons.logout),
        onPressed: () {
          context.read<AuthenticationService>().signOut();
          Navigator.of(context).pushNamed(route.SignIn);
        },
      ),
    );
  }
}