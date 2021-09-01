import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_authentication_tutorial/provider/users.dart';
import 'package:firebase_authentication_tutorial/widget/user_widget.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UsersProvider>(context);
    final users = provider.user;

    return users.isEmpty
        ? Center(
            child: Text(
              'NO PROFILE. THIS IS A BUG!!!!',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              return UserWidget(user: user);
            },
          );
  }
}
