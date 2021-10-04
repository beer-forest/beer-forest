import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_authentication_tutorial/api/firebase_api_users.dart';
import 'package:firebase_authentication_tutorial/model/userprofile.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;

class UsersProvider extends ChangeNotifier {

  List<UserProfile> _users = [];
  List<UserProfile> prefs_all = [];

  //TODO(hschoi1): hard coded for now. get from api
  Map<String, bool> my_pref_map = {"pref_english":true, "pref_korean_literature":true, "pref_mathematics":true};

  final auth_infouser = fire_auth.FirebaseAuth.instance.currentUser;


  List<UserProfile> get user => _users.where((user) => user.email == auth_infouser.email).toList();

  List<UserProfile> get users_pref_english => readOtherUserWithPrefEnglish(_users);
  List<UserProfile> get users_pref_korean_literature => readOtherUserWithPrefKoreanLiterature(_users);
  List<UserProfile> get users_pref_mathematics => readOtherUserWithPrefMathematics(_users);

  List<String> get pref_list => ["pref_english", "pref_korean_literature", "pref_mathematics"];
  Map<String, String> get pref_to_kor => {"pref_english":"영어",
                                          "pref_korean_literature": "한국어",
                                          "pref_mathematics": "수학"};



  // TODO(hschoi) : get map_ref_users using pref_list

  Map<String, List<UserProfile>> get map_pref_users => {
    "pref_english": this.users_pref_english,
    "pref_korean_literature": this.users_pref_korean_literature,
    "pref_mathematics": this.users_pref_mathematics
  };


  void setUsers(List<UserProfile> users) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _users = users;
        notifyListeners();
      });

  void addUser(UserProfile user) => FirebaseApi.createUser(user);

  void removeUser(UserProfile user) => FirebaseApi.deleteUser(user);

  void updateUser(UserProfile user, String name, String email,
      bool pref_english, bool pref_korean_literature, bool pref_mathematics,
      inviter, friendsList) {
    user.name = name;
    user.email = email;
    user.pref_english = pref_english;
    user.pref_korean_literature = pref_korean_literature;
    user.pref_mathematics = pref_mathematics;
    user.inviter = inviter;
    user.friendsList = friendsList;

    FirebaseApi.updateUser(user);
  }

   List<UserProfile> readOtherUserWithPrefEnglish(List<UserProfile> users) {
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

   List<UserProfile> readOtherUserWithPrefKoreanLiterature(List<UserProfile> users) {
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

  List<UserProfile> readOtherUserWithPrefMathematics(List<UserProfile> users) {
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
