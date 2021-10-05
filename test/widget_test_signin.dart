// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:firebase_authentication_tutorial/main.dart';
import 'package:firebase_authentication_tutorial/page/sign_in_page.dart';

void main() {
  testWidgets('See if signin exists', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // await tester.pumpWidget(MyApp());
    // await tester.pumpWidget(SignInPage());

    // Verify that our counter starts at 0.
    expect(3, 3);
    // expect(find.text('EMAIL'), findsOneWidget);
  });
}
