import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_authentication_tutorial/model/user.dart';
import 'package:firebase_authentication_tutorial/util/utils.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;

class FirebaseApi {

  static Future<String> createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc();
    user.id = docUser.id;
    await docUser.set(user.toJson());

    return docUser.id;
  }

  static Stream<List<User>> readUsers() =>
      FirebaseFirestore.instance
          .collection('user')
          .orderBy(UserField.createdTime, descending: true)
          .snapshots()
          .transform(Utils.transformer(User.fromJson));

  static Stream<List<User>> readMine() {
    final user = fire_auth.FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('user')
        .where("email", isEqualTo: user.email)
        .snapshots()
        .transform(Utils.transformer(User.fromJson));
  }

  static Future readMyPreference() async {
    final user = fire_auth.FirebaseAuth.instance.currentUser;
    bool my_pref_english;
    bool my_pref_korean_literature;
    bool my_pref_mathematics;
    User myself;
    DocumentSnapshot my_doc;
    my_doc = await FirebaseFirestore.instance
        .collection('user')
        .where("email", isEqualTo: user.email)
        .get()
        .then((snapshot) => snapshot.docs[0]);

    myself = User.fromJson(my_doc.data());
    my_pref_english = myself.pref_english;
    my_pref_korean_literature = myself.pref_korean_literature;
    my_pref_mathematics = myself.pref_mathematics;

    return {"pref_english": my_pref_english,
    "pref_korean_literature": my_pref_korean_literature,
    "pref_mathematics": my_pref_mathematics
    };
  }


  static Stream<List<User>> readOtherUserWithPrefEnglish() =>
    FirebaseFirestore.instance
        .collection('user')
        .where("pref_english", isEqualTo: true)
        .snapshots()
        .transform(Utils.transformer(User.fromJson));


  static Stream<List<User>> readOtherUserWithPrefKoreanLiterature() =>
    FirebaseFirestore.instance
        .collection('user')
        .where("pref_korean_literature", isEqualTo: true)
        .snapshots()
        .transform(Utils.transformer(User.fromJson));


  static Stream<List<User>> readOtherUserWithPrefMathematics() =>
    FirebaseFirestore.instance
        .collection('user')
        .where("pref_mathematics", isEqualTo: true)
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
