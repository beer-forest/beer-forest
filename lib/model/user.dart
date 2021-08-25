import 'package:flutter/cupertino.dart';
import 'package:firebase_authentication_tutorial/utils.dart';

class UserField {
  static const createdTime = 'createdTime';
}

class User {
  DateTime createdTime;
  String name;
  String id;
  String email;
  List<String> preference_ids;
  bool isDone;

  User({
    @required this.createdTime,
    @required this.name,
    @required this.email,
    this.id,
    @required this.preference_ids,
    this.isDone = false
  });

  static User fromJson(Map<String, dynamic> json) => User(
        createdTime: Utils.toDateTime(json['createdTime']),
        name: json['name'],
        email: json['email'],
        id: json['id'],
        preference_ids: (json['preference_ids'] as List).cast<String>(),
        isDone: json['isDone']
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'name': name,
        'email': email,
        'id': id,
        'preference_ids': preference_ids,
        'isDone': isDone,
      };
}
