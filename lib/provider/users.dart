import 'package:flutter/cupertino.dart';
import 'package:firebase_authentication_tutorial/api/firebase_api_users.dart';
import 'package:firebase_authentication_tutorial/model/user.dart';

class UsersProvider extends ChangeNotifier {
  List<User> _users = [];

  List<User> get users => _users.where((user) => user.isDone == false).toList();

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

  void updateUser(User user, String name, String email, List<String> preference_ids) {
    user.name = name;
    user.email = email;
    user.preference_ids = preference_ids;

    FirebaseApi.updateUser(user);
  }
}
