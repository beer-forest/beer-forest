import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_authentication_tutorial/api/firebase_api_users.dart';
import 'package:firebase_authentication_tutorial/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;

class UsersProvider extends ChangeNotifier {
  List<User> _users = [];
  List<User> prefs_all = [];

  //TODO(hschoi1): hard coded for now. get from api
  Map<String, bool> my_pref_map = {"pref_english":true, "pref_korean_literature":true, "pref_mathematics":true};

  final auth_infouser = fire_auth.FirebaseAuth.instance.currentUser;

  List<User> get user => _users.where((user) => user.email == auth_infouser.email).toList();

  List<User> get users_pref_english => readOtherUserWithPrefEnglish(_users);
  List<User> get users_pref_korean_literature => readOtherUserWithPrefKoreanLiterature(_users);
  List<User> get users_pref_mathematics => readOtherUserWithPrefMathematics(_users);

  List<String> get pref_list => ["pref_english", "pref_korean_literature", "pref_mathematics"];



  // TODO(hschoi) : get map_ref_users using pref_list
  Map<String, List<User>> get map_pref_users => {
    "pref_english": this.users_pref_english,
    "pref_korean_literature": this.users_pref_korean_literature,
    "pref_mathematics": this.users_pref_mathematics
  };


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

   List<User> readOtherUserWithPrefEnglish(List<User> users) {
    if (my_pref_map['pref_english'] == true) {
      return users
          .where((user) => user.email != this.auth_infouser.email)
          .where((user) => user.pref_english == true)
          .toList();
    }
    else {
      return [];
    }
  }
   List<User> readOtherUserWithPrefKoreanLiterature(List<User> users) {
    if (my_pref_map['pref_korean_literature'] == true) {
      return users
          .where((user) => user.email != this.auth_infouser.email)
          .where((user) => user.pref_korean_literature == true)
          .toList();
    }
    else {
      return [];
    }
  }
  List<User> readOtherUserWithPrefMathematics(List<User> users) {
    if (my_pref_map['pref_mathematics'] == true) {
      return users
          .where((user) => user.email != this.auth_infouser.email)
          .where((user) => user.pref_mathematics == true)
          .toList();
    }
    else {
      return [];
    }
  }
}
