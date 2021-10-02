import 'package:firebase_authentication_tutorial/route/route.dart' as route;
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:firebase_authentication_tutorial/model/userprofile.dart';
import 'package:firebase_authentication_tutorial/page/edit_profile_page.dart';
import 'package:firebase_authentication_tutorial/provider/users.dart';
import 'package:firebase_authentication_tutorial/util/utils.dart';

class UserWidget extends StatelessWidget {

  final UserProfile user;

  const UserWidget({
    @required this.user,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          key: Key(user.id),
          actions: [
            IconSlideAction(
              color: Colors.green,
              onTap: () => editUser(context, user),
              caption: 'Edit',
              icon: Icons.edit,
            )
          ],
          secondaryActions: [
            IconSlideAction(
              color: Colors.red,
              caption: 'Delete',
              onTap: () => deleteUser(context, user),
              icon: Icons.delete,
            )
          ],
          child: buildUser(context),
        ),
      );

  Widget buildUser(BuildContext context) => GestureDetector(
        onTap: () => editUser(context, user),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    if (user.email.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          user.email,
                          style: TextStyle(fontSize: 20, height: 1.5),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      );


  void deleteUser(BuildContext context, UserProfile user) {
    final provider = Provider.of<UsersProvider>(context, listen: false);
    provider.removeUser(user);

    Utils.showSnackBar(context, 'Deleted the user');
  }


  void editUser(BuildContext context, UserProfile user) =>

      // TODO(chococigar): For some reason, using the command below results in null.
      // Navigator.of(context).pushNamed(route.EditProfile, arguments: {user: user});

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditProfilePage(user: user),
        ),
      );
}
