import 'package:flutter/cupertino.dart';
import 'package:firebase_authentication_tutorial/api/firebase_api_users.dart';
import 'package:firebase_authentication_tutorial/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;

class UsersProvider extends ChangeNotifier {
  List<User> _users = [];
  final auth_infouser = fire_auth.FirebaseAuth.instance.currentUser;

  List<User> get user => _users.where((user) => user.email == auth_infouser.email).toList();

  List<User> get usersCompleted =>
      _users.where((user) => user.isDone == true).toList();

  void setUsers(List<User> users) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _users = users;
        notifyListeners();
      });

  void addUser(User user) => FirebaseApi.createUser(user);

  void removeUser(User user) => FirebaseApi.deleteUser(user);

  bool toggleUserStatus(User user) {
    user.isDone = !user.isDone;
    FirebaseApi.updateUser(user);

    return user.isDone;
  }

  void updateUser(User user, String name, String email,
      bool pref_english, bool pref_korean_literature, bool pref_mathematics) {
    user.name = name;
    user.email = email;
    user.pref_english = pref_english;
    user.pref_korean_literature = pref_korean_literature;
    user.pref_mathematics = pref_mathematics;

    FirebaseApi.updateUser(user);
  }
}
