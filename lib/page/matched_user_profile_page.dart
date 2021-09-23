import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_authentication_tutorial/model/user.dart';
import 'package:firebase_authentication_tutorial/provider/users.dart';
import 'package:firebase_authentication_tutorial/widget/matched_user_widget.dart';

class MatchedUserProfilePage extends StatefulWidget {
  final UserModel user;

  const MatchedUserProfilePage({Key key, @required this.user}) : super(key: key);

  @override
  _MatchedUserProfilePageState createState() => _MatchedUserProfilePageState();
}

class _MatchedUserProfilePageState extends State<MatchedUserProfilePage> {
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
          title: Text('Matched User Profile'),
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
            child: MatchedUserWidget(
              name: name,
              email: email,
              pref_english: pref_english,
              pref_korean_literature: pref_korean_literature,
              pref_mathematics: pref_mathematics,
              onInviteUser: inviteUser,
            ),
          ),
        ),
      );

  //TODO(hschoi1) : add google invite functionality
  void inviteUser() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<UsersProvider>(context, listen: false);

      //provider.updateUser(widget.user, name, email,
      //    pref_english, pref_korean_literature, pref_mathematics);

      Navigator.of(context).pop();
    }
  }
}
