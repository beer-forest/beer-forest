import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_authentication_tutorial/model/user.dart';
import 'package:firebase_authentication_tutorial/provider/users.dart';
import 'package:firebase_authentication_tutorial/widget/user_form_widget.dart';

class AddUserDialogWidget extends StatefulWidget {
  @override
  _AddUserDialogWidgetState createState() => _AddUserDialogWidgetState();
}

class _AddUserDialogWidgetState extends State<AddUserDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  bool pref_english = false;
  bool pref_korean_literature = false;
  bool pref_mathematics = false;


  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add User',
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
                onChangedPrefEnglish: (bool pref_english) =>
                    setState(() => this.pref_english = pref_english),
                onChangedPrefKoreanLiterature: (bool pref_korean_literature) =>
                    setState(() => this.pref_korean_literature = pref_korean_literature),
                onChangedPrefMathematics: (bool pref_mathematics) =>
                    setState(() => this.pref_mathematics = pref_mathematics),
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
        pref_english: pref_english,
        pref_korean_literature: pref_korean_literature,
        pref_mathematics: pref_mathematics,
        createdTime: DateTime.now(),
      );

      final provider = Provider.of<UsersProvider>(context, listen: false);
      provider.addUser(user);

      Navigator.of(context).pop();
    }
  }
}
