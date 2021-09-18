import 'package:firebase_authentication_tutorial/route/route.dart' as route;
import 'package:firebase_authentication_tutorial/widget/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_authentication_tutorial/model/userprofile.dart';
import 'package:firebase_authentication_tutorial/provider/users.dart';
import 'package:firebase_authentication_tutorial/widget/user_form_widget.dart';

class EditProfileFirstPage extends StatefulWidget {
  @override
  _EditProfileFirstPageState createState() => _EditProfileFirstPageState();
}

class _EditProfileFirstPageState extends State<EditProfileFirstPage> {
  final _formKey = GlobalKey<FormState>();

  String name;
  String email;
  bool pref_english;
  bool pref_korean_literature;
  bool pref_mathematics;
  String inviter;
  List<String> friendsList;

  @override
  void initState() {
    super.initState();

    name = 'name';
    email = '';
    pref_english = false;
    pref_korean_literature = false;
    pref_mathematics = false;
    inviter = '';
    friendsList = [''];
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: BaseAppBar(),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: UserFormWidget(
          onChangedName: (name) => setState(() => this.name = name),
          onChangedEmail: (email) =>
              setState(() => this.email = email),
          onChangedPrefEnglish: (pref_english) =>
              setState(() => this.pref_english = pref_english),
          onChangedPrefKoreanLiterature: (pref_korean_literature) =>
              setState(() => this.pref_korean_literature = pref_korean_literature),
          onChangedPrefMathematics: (pref_mathematics) =>
              setState(() => this.pref_mathematics = pref_mathematics),
          onChangedInviter: (inviter) =>
              setState(() => this.inviter = inviter),
          onChangedFriends: (friendsList) =>
              setState(() => this.friendsList = friendsList),
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
      final user = UserProfile(
        id: DateTime.now().toString(),
        name: name,
        email: email,
        pref_english: pref_english,
        pref_korean_literature: pref_korean_literature,
        pref_mathematics: pref_mathematics,
        createdTime: DateTime.now(),
        inviter: inviter,
        friendsList: friendsList
      );

      final provider = Provider.of<UsersProvider>(context, listen: false);
      provider.addUser(user);
      Navigator.of(context).pushNamed(route.Home);
    }
  }
}