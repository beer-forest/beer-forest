import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_authentication_tutorial/model/user.dart';
import 'package:firebase_authentication_tutorial/provider/users.dart';
import 'package:firebase_authentication_tutorial/widget/user_form_widget.dart';

class EditUserPage extends StatefulWidget {
  final User user;

  const EditUserPage({Key key, @required this.user}) : super(key: key);

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _formKey = GlobalKey<FormState>();

  String name;
  String email;
  List<String> preference_ids;

  @override
  void initState() {
    super.initState();

    name = widget.user.name;
    email = widget.user.email;
    preference_ids = widget.user.preference_ids;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Edit User'),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                final provider =
                    Provider.of<UsersProvider>(context, listen: false);
                provider.removeUser(widget.user);

                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: UserFormWidget(
              name: name,
              email: email,
              preference_ids: preference_ids,
              onChangedName: (name) => setState(() => this.name = name),
              onChangedEmail: (email) =>
                  setState(() => this.email = email),
              onSavedUser: saveUser,
            ),
          ),
        ),
      );

  void saveUser() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<UsersProvider>(context, listen: false);

      provider.updateUser(widget.user, name, description);

      Navigator.of(context).pop();
    }
  }
}
