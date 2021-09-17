import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_authentication_tutorial/provider/users.dart';
import 'package:firebase_authentication_tutorial/widget/avatar.dart';
import 'package:firebase_authentication_tutorial/widget/user_widget.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UsersProvider>(context);
    // final users = provider.user;
    final _currentUser = provider.user[0];

    /*
    return users.isEmpty
        ? Center(
            child: Text(
              'NO PROFILE. THIS IS A BUG!!!!',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              return UserWidget(user: user);
            },
          );
    */
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Avatar(
                    // avatarUrl: _currentUser?.avatarUrl,
                    // avatarUrl: "https://static.wikia.nocookie.net/meme/images/1/16/Yee.png/revision/latest?cb=20190307094426",
                    onTap: () {},
                  ),
                  Text(
                      "Hello " + _currentUser.name,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5,
                  ),
                      // "Hi ${_currentUser?.displayName ??
                      //     'nice to see you here.'}"),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(hintText: "Username"),
                    ),
                    SizedBox(height: 20.0),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Manage Password",
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline6,
                          ),
                          TextFormField(
                            decoration: InputDecoration(hintText: "Password"),
                          ),
                          TextFormField(
                            decoration:
                            InputDecoration(hintText: "New Password"),
                          ),
                          TextFormField(
                            decoration:
                            InputDecoration(hintText: "Repeat Password"),
                          )
                        ],
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        // TODO: Save somehow
                        Navigator.pop(context);
                      },
                      child: Text("Save Profile"),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
