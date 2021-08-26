import 'package:flutter/material.dart';

class UserFormWidget extends StatelessWidget {
  final String name;
  final String email;
  final List<String> preference_ids;
  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedEmail;
  final ValueChanged<List<String>> onChangedPreferenceIds;
  final VoidCallback onSavedUser;
  final TextEditingController myController;

  const UserFormWidget({
    Key key,
    this.name = '',
    this.email = '',
    this.preference_ids,
    @required this.onChangedName,
    @required this.onChangedEmail,
    @required this.onChangedPreferenceIds,
    @required this.onSavedUser,
    this.myController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildName(),
            SizedBox(height: 4),
            buildEmail(),
            SizedBox(height: 4),
            buildPreferenceIds(),
            SizedBox(height: 4),
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

  Widget buildPreferenceIds() => TextFormField(
    maxLines: 1,
    initialValue: "",
    //onChanged: onChangedPreferenceIds,
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Preferences',
    ),
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
