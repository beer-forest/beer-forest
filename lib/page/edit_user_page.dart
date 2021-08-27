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
  bool pref_english;
  bool pref_korean_literature;
  bool pref_mathematics;

  @override
  void initState() {
    super.initState();

    name = widget.user.name;
    email = widget.user.email;
    pref_english = widget.user.pref_english;
    pref_korean_literature = widget.user.pref_korean_literature;
    pref_mathematics = widget.user.pref_mathematics;
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
              pref_english: pref_english,
              pref_korean_literature: pref_korean_literature,
              pref_mathematics: pref_mathematics,
              onChangedName: (name) => setState(() => this.name = name),
              onChangedEmail: (email) =>
                  setState(() => this.email = email),
              onChangedPrefEnglish: (pref_english) =>
                  setState(() => this.pref_english = pref_english),
              onChangedPrefKoreanLiterature: (pref_korean_literature) =>
                  setState(() => this.pref_korean_literature = pref_korean_literature),
              onChangedPrefMathematics: (pref_mathematics) =>
                  setState(() => this.pref_mathematics = pref_mathematics),
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

      provider.updateUser(widget.user, name, email,
          pref_english, pref_korean_literature, pref_mathematics);

      Navigator.of(context).pop();
    }
  }
}
