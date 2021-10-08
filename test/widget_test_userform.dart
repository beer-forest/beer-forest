// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:firebase_authentication_tutorial/main.dart';
import 'package:firebase_authentication_tutorial/widget/user_form_widget.dart';

void main() {
  testWidgets('See if UserformWidget displays texts', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    String name="testuser1";
    String email="testuser1@test.com";
    bool pref_english=false;
    bool pref_korean_literature=false;
    bool pref_mathematics=false;
    String inviter="testinviter";
    List<String> friendsList=["testuser2"];

    ValueChanged<String> onChangedName = (name) => {name = name};
    final ValueChanged<String> onChangedEmail = (email) => {email = email};
    final ValueChanged<bool> onChangedPrefEnglish = (pref_english) => {pref_english = pref_english};
    final ValueChanged<bool> onChangedPrefKoreanLiterature = (pref_korean_literature) => {pref_korean_literature = pref_korean_literature};
    final ValueChanged<bool> onChangedPrefMathematics = (pref_mathematics) => {pref_mathematics = pref_mathematics};
    final ValueChanged<String> onChangedInviter = (inviter) => {inviter = inviter};
    final ValueChanged<List<String>> onChangedFriends = (friendsList) => {friendsList = friendsList};
    final VoidCallback onSavedUser = saveUser;


    await tester.pumpWidget(
      UserFormWidget(name: name,
                    email: email,
                    pref_english: pref_english,
                    pref_korean_literature: pref_korean_literature,
                    pref_mathematics: pref_mathematics,
                    inviter: inviter,
                    friendsList: friendsList,
                    onChangedName: onChangedName,
                    onChangedEmail: onChangedEmail,
                    onChangedPrefEnglish: onChangedPrefEnglish,
                    onChangedPrefKoreanLiterature: onChangedPrefKoreanLiterature,
                    onChangedPrefMathematics: onChangedPrefMathematics,
                    onChangedInviter: onChangedInviter,
                    onChangedFriends: onChangedFriends,
                    onSavedUser: onSavedUser,)
    );

    //final nameFinder = find.byKey(const ValueKey('buildNameKey'));
    //expect(nameFinder, findsOneWidget);
  });
}
void saveUser() {
   print("SaveUser");
}
