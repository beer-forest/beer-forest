import 'package:flutter/material.dart';

class MatchedUserWidget extends StatelessWidget {
  final String name;
  final String email;
  final bool pref_english;
  final bool pref_korean_literature;
  final bool pref_mathematics;

  final VoidCallback onInviteUser;
  final TextEditingController myController;

  const MatchedUserWidget({
    Key key,
    this.name = '',
    this.email = '',
    this.pref_english = false,
    this.pref_korean_literature = false,
    this.pref_mathematics = false,

    @required this.onInviteUser,
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
        enabled: false,
        maxLines: 1,
        initialValue: name,
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
        enabled: false,
        maxLines: 1,
        initialValue: email,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Email',
        ),
      );

  Widget buildPrefEnglish() => CheckboxListTile(
    title: Text("english"),
    value: pref_english,
  );
  Widget buildPrefKoreanLiterature() => CheckboxListTile(
      title: Text("korean literature"),
      value: pref_korean_literature,
  );

  Widget buildPrefMathematics() => CheckboxListTile(
      title: Text("mathematics"),
      value: pref_mathematics,
  );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
          ),
          onPressed: onInviteUser,
          child: Text('Send Meet Invite'),
        ),
      );
}
