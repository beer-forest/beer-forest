import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserFormWidget extends StatefulWidget {

  const UserFormWidget({
    Key key,
    name,
    email,
    pref_english,
    pref_korean_literature,
    pref_mathematics,
    inviter,
    friendsList,

    @required onChangedName,
    @required onChangedEmail,
    @required onChangedPrefEnglish,
    @required onChangedPrefKoreanLiterature,
    @required onChangedPrefMathematics,
    @required onChangedInviter,
    @required onChangedFriends,
    @required onSavedUser,

    nameController
  }) : super(key: key);

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}
class _UserFormWidgetState extends State<UserFormWidget> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController;
  static List<String> friendsList = [null];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  //String name;
  String name;
  String email;
  bool pref_english = false;
  bool pref_korean_literature = false;
  bool pref_mathematics = false;
  String inviter;

  ValueChanged<String> onChangedName;
  ValueChanged<String> onChangedEmail;
  ValueChanged<bool> onChangedPrefEnglish;
  ValueChanged<bool> onChangedPrefKoreanLiterature;
  ValueChanged<bool> onChangedPrefMathematics;
  ValueChanged<String> onChangedInviter;
  ValueChanged<List<String>> onChangedFriends;

  VoidCallback onSavedUser;



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
            buildInviter(),
            buildFriends(),
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


  Widget buildInviter() => TextFormField(
    maxLines: 1,
    initialValue: inviter,
    onChanged: onChangedInviter,
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'inviter',
    ),
  );

  Widget buildFriends() => Form(
    key: _formKey,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // name textfield
          SizedBox(height: 20,),
          Text('Add Friends', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
          ..._getFriends(),
          SizedBox(height: 40,),
        ],
      ),
    ),
  );


  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
          ),
          onPressed: onSavedUser,
          child: Text('Save'),
        ),
      );

  /// get firends text-fields
  List<Widget> _getFriends(){
    List<Widget> friendsTextFields = [];
    for(int i=0; i<friendsList.length; i++){
      friendsTextFields.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Expanded(child: FriendTextFields(i)),
                SizedBox(width: 16,),
                // we need add button at last friends row
                _addRemoveButton(i == friendsList.length-1, i),
              ],
            ),
          )
      );
    }
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index){
    return InkWell(
      onTap: (){
        if(add){
          // add new text-fields at the top of all friends textfields
          friendsList.insert(0, null);
        }
        else friendsList.removeAt(index);
        setState((){});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon((add) ? Icons.add : Icons.remove, color: Colors.white,),
      ),
    );
  }

}


class FriendTextFields extends StatefulWidget {
  final int index;
  FriendTextFields(this.index);
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = _UserFormWidgetState.friendsList[widget.index] ?? '';
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) => _UserFormWidgetState.friendsList[widget.index] = v,
      decoration: InputDecoration(
          hintText: 'Enter your friend\'s name'
      ),
      validator: (v){
        if(v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}