import 'package:flutter/material.dart';

class UserFormWidget extends StatelessWidget {
  final String name;
  final String email;
  final bool pref_english;
  final bool pref_korean_literature;
  final bool pref_mathematics;
  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedEmail;
  final ValueChanged<bool> onChangedPrefEnglish;
  final ValueChanged<bool> onChangedPrefKoreanLiterature;
  final ValueChanged<bool> onChangedPrefMathematics;

  final VoidCallback onSavedUser;
  final TextEditingController myController;

  const UserFormWidget({
    Key key,
    this.name = '',
    this.email = '',
    this.pref_english = false,
    this.pref_korean_literature = false,
    this.pref_mathematics = false,

    @required this.onChangedName,
    @required this.onChangedEmail,
    @required this.onChangedPrefEnglish,
    @required this.onChangedPrefKoreanLiterature,
    @required this.onChangedPrefMathematics,
    @required this.onSavedUser,
    this.myController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildName(),
            buildEmail(),
            buildPrefEnglish(),
            buildPrefKoreanLiterature(),
            buildPrefMathematics(),
            buildButton(),
          ],
        ),
      );

  Widget buildName() => TextFormField(
        maxLines: 1,
        initialValue: name,
        onChanged: onChangedName,
        validator: (title) {
          if (title.isEmpty) {
            return 'The name cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'name',
        ),
      );

  Widget buildEmail() => TextFormField(
        maxLines: 1,
        initialValue: email,
        onChanged: onChangedEmail,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Email',
        ),
      );

  Widget buildPrefEnglish() => CheckboxListTile(
    title: Text("english"),
    value: pref_english,
    onChanged: onChangedPrefEnglish
  );
  Widget buildPrefKoreanLiterature() => CheckboxListTile(
      title: Text("korean literature"),
      value: pref_korean_literature,
      onChanged: onChangedPrefKoreanLiterature
  );

  Widget buildPrefMathematics() => CheckboxListTile(
      title: Text("mathematics"),
      value: pref_mathematics,
      onChanged: onChangedPrefMathematics
  );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: onSavedUser,
          child: Text('Save'),
        ),
      );
}
