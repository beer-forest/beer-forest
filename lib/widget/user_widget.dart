import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:firebase_authentication_tutorial/model/user.dart';
import 'package:firebase_authentication_tutorial/page/edit_user_page.dart';
import 'package:firebase_authentication_tutorial/provider/users.dart';
import 'package:firebase_authentication_tutorial/util/utils.dart';

class UserWidget extends StatelessWidget {
  final User user;

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
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                value: user.isDone,
                onChanged: (_) {
                  final provider =
                      Provider.of<UsersProvider>(context, listen: false);
                  final isDone = provider.toggleUserStatus(user);

                  Utils.showSnackBar(
                    context,
                    isDone ? 'User completed' : 'User marked incomplete',
                  );
                },
              ),
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

  void deleteUser(BuildContext context, User user) {
    final provider = Provider.of<UsersProvider>(context, listen: false);
    provider.removeUser(user);

    Utils.showSnackBar(context, 'Deleted the user');
  }

  void editUser(BuildContext context, User user) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditUserPage(user: user),
        ),
      );
}
