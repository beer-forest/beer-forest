import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_authentication_tutorial/model/user.dart';
import 'package:firebase_authentication_tutorial/provider/users.dart';
import 'package:firebase_authentication_tutorial/widget/user_form_widget.dart';

class AddTodoDialogWidget extends StatefulWidget {
  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Todo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              UserFormWidget(
                onChangedName: (name) => setState(() => this.name = name),
                onChangedEmail: (email) =>
                    setState(() => this.email = email),
                onSavedUser: addUser,
              ),
            ],
          ),
        ),
      );

  void addUser() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final user = User(
        id: DateTime.now().toString(),
        name: name,
        email: email,
        createdTime: DateTime.now(),
      );

      final provider = Provider.of<UsersProvider>(context, listen: false);
      provider.addUser(user);

      Navigator.of(context).pop();
    }
  }
}
