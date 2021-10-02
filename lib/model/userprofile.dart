import 'package:flutter/cupertino.dart';
import 'package:firebase_authentication_tutorial/util/utils.dart';

class UserField {
  static const createdTime = 'createdTime';
}

class UserProfile {
  DateTime createdTime;
  String name;
  String id;
  String email;
  bool pref_english;
  bool pref_korean_literature;
  bool pref_mathematics;
  String inviter;
  List<String> friendsList;

  UserProfile({
    @required this.createdTime,
    @required this.name,
    @required this.email,
    this.id,
    this.pref_english = false,
    this.pref_korean_literature = false,
    this.pref_mathematics = false,
    this.inviter,
    this.friendsList
  });

  static UserProfile fromJson(Map<String, dynamic> json) => UserProfile(
        createdTime: Utils.toDateTime(json['createdTime']),
        name: json['name'],
        email: json['email'],
        id: json['id'],
        pref_english: json['pref_english'],
        pref_korean_literature: json['pref_korean_literature'],
        pref_mathematics: json['pref_mathematics'],
        inviter: json['inviter'],
        friendsList: new List<String>.from(json['friendsList'])
      );


  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'name': name,
        'email': email,
        'id': id,
        'pref_english': pref_english,
        'pref_korean_literature': pref_korean_literature,
        'pref_mathematics': pref_mathematics,
        'inviter': inviter,
        'friendsList': friendsList,
      };
}
