import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_authentication_tutorial/model/user.dart';
import 'package:firebase_authentication_tutorial/utils.dart';

class FirebaseApi {
  static Future<String> createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc();

    user.id = docUser.id;
    await docUser.set(user.toJson());

    return docUser.id;
  }

  static Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('user')
      .orderBy(UserField.createdTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(User.fromJson));

  static Future updateUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc(user.id);

    await docUser.update(user.toJson());
  }

  static Future deleteUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc(user.id);

    await docUser.delete();
  }
}
