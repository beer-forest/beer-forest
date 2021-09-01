import 'package:firebase_authentication_tutorial/route/route.dart' as route;
import 'package:firebase_authentication_tutorial/service/authentication_service.dart';
import 'package:firebase_authentication_tutorial/widget/fake_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_authentication_tutorial/api/firebase_api_users.dart';
import 'package:firebase_authentication_tutorial/model/user.dart';
import 'package:firebase_authentication_tutorial/provider/users.dart';
import 'package:firebase_authentication_tutorial/widget/add_user_dialog_widget.dart';
import 'package:firebase_authentication_tutorial/widget/match_list_widget.dart';
import 'package:firebase_authentication_tutorial/widget/profile_widget.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      MatchListWidget(),
      FakeWidget(),
      ProfileWidget(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
        leading: IconButton (
          icon: Icon(Icons.logout),
          onPressed: () {
            context.read<AuthenticationService>().signOut();
            Navigator.of(context).pushNamed(route.SignIn);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined, size: 28),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'fake',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
      body: StreamBuilder<List<User>>(
        stream: FirebaseApi.readUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final users = snapshot.data;

                final provider = Provider.of<UsersProvider>(context);
                provider.setUsers(users);

                return tabs[selectedIndex];
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.black,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddUserDialogWidget(),
          barrierDismissible: false,
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
