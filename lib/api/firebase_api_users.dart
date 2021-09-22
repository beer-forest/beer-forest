import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_authentication_tutorial/model/userprofile.dart';
import 'package:firebase_authentication_tutorial/util/utils.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;

class FirebaseApi {

  static Future<String> createUser(UserProfile user) async {
    final docUser = FirebaseFirestore.instance.collection('userprofile').doc();
    user.id = docUser.id;
    await docUser.set(user.toJson());

    return docUser.id;
  }

  static Stream<List<UserProfile>> readUsers() =>
      FirebaseFirestore.instance
          .collection('userprofile')
          .orderBy(UserField.createdTime, descending: true)
          .snapshots()
          .transform(Utils.transformer(UserProfile.fromJson));

  static Stream<List<UserProfile>> readMine() {
    final user = fire_auth.FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('userprofile')
        .where("email", isEqualTo: user.email)
        .snapshots()
        .transform(Utils.transformer(UserProfile.fromJson));
  }

  static Future readMyPreference() async {
    final user = fire_auth.FirebaseAuth.instance.currentUser;
    bool my_pref_english;
    bool my_pref_korean_literature;
    bool my_pref_mathematics;
    UserProfile myself;
    DocumentSnapshot my_doc;
    my_doc = await FirebaseFirestore.instance
        .collection('userprofile')
        .where("email", isEqualTo: user.email)
        .get()
        .then((snapshot) => snapshot.docs[0]);

    myself = UserProfile.fromJson(my_doc.data());
    my_pref_english = myself.pref_english;
    my_pref_korean_literature = myself.pref_korean_literature;
    my_pref_mathematics = myself.pref_mathematics;

    return {"pref_english": my_pref_english,
    "pref_korean_literature": my_pref_korean_literature,
    "pref_mathematics": my_pref_mathematics
    };
  }


  static Future updateUser(UserProfile user) async {
    final docUser = FirebaseFirestore.instance.collection('userprofile').doc(user.id);

    await docUser.update(user.toJson());
  }

  static Future deleteUser(UserProfile user) async {
    final docUser = FirebaseFirestore.instance.collection('userprofile').doc(user.id);

    await docUser.delete();
  }
}
