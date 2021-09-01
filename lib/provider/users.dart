import 'package:flutter/cupertino.dart';
import 'package:firebase_authentication_tutorial/api/firebase_api_users.dart';
import 'package:firebase_authentication_tutorial/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;

class UsersProvider extends ChangeNotifier {
  List<User> _users = [];
  List<User> prefs_all = [];

  final auth_infouser = fire_auth.FirebaseAuth.instance.currentUser;

  List<User> get user => _users.where((user) => user.email == auth_infouser.email).toList();

  List<User> get users_pref_english => readOtherUserWithPrefEnglish(_users);
  List<User> get users_pref_korean_literature => readOtherUserWithPrefKoreanLiterature(_users);
  List<User> get users_pref_mathematics => readOtherUserWithPrefMathematics(_users);

  List<User> get usersMatched {
    prefs_all.addAll(this.users_pref_english);
    prefs_all.addAll(this.users_pref_korean_literature);
    prefs_all.addAll(this.users_pref_mathematics);
    return prefs_all;
  }


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

  static List<User> readOtherUserWithPrefEnglish(List<User> users) {
    return users.where((user) =>  user.pref_english == true).toList();
  }
  static List<User> readOtherUserWithPrefKoreanLiterature(List<User> users) {
    return users.where((user) =>  user.pref_korean_literature == true).toList();
  }
  static List<User> readOtherUserWithPrefMathematics(List<User> users) {
    return users.where((user) =>  user.pref_mathematics == true).toList();
  }

}
