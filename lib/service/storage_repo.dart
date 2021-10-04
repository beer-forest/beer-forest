import 'dart:io';

import 'package:firebase_authentication_tutorial/provider/users.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_authentication_tutorial/service/locator.dart';
import 'package:firebase_authentication_tutorial/model/userprofile.dart';
// import 'package:firebaseprofiletutorial/repository/auth_repo.dart';

class StorageRepo {

/*
  FirebaseStorage _storage =
  FirebaseStorage(storageBucket: "gs://profiletutorial-c5ed1.appspot.com");
  // AuthRepo _authRepo = locator.get<AuthRepo>();

  Future<String> uploadFile(File file) async {
    // UserModel user = await _authRepo.getUser();
    final provider = Provider.of<UsersProvider>(context);
    final user = provider.user[0];
    var userId = user.uid;

    var storageRef = _storage.ref().child("user/profile/$userId");
    var uploadTask = storageRef.putFile(file);
    var completedTask = await uploadTask.onComplete;
    String downloadUrl = await completedTask.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> getUserProfileImage(String uid) async {
    return await _storage.ref().child("user/profile/$uid").getDownloadURL();
  }
 */
}