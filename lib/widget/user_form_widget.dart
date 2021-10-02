import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserFormWidget extends StatefulWidget {

  UserFormWidget({
    Key key,
    this.name,
    this.email,
    this.pref_english,
    this.pref_korean_literature,
    this.pref_mathematics,
    this.inviter,
    this.friendsList,

    @required this.onChangedName,
    @required this.onChangedEmail,
    @required this.onChangedPrefEnglish,
    @required this.onChangedPrefKoreanLiterature,
    @required this.onChangedPrefMathematics,
    @required this.onChangedInviter,
    @required this.onChangedFriends,
    @required this.onSavedUser,

  }) : super(key: key);

  final String name;
  final String email;
  final bool pref_english;
  final bool pref_korean_literature;
  final bool pref_mathematics;
  final String inviter;
  // final List<String> friendsList;
  List<String> friendsList = [null];

  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedEmail;
  final ValueChanged<bool> onChangedPrefEnglish;
  final ValueChanged<bool> onChangedPrefKoreanLiterature;
  final ValueChanged<bool> onChangedPrefMathematics;
  final ValueChanged<String> onChangedInviter;
  final ValueChanged<List<String>> onChangedFriends;

  final VoidCallback onSavedUser;


  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}
class _UserFormWidgetState extends State<UserFormWidget> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController;
  static List<String> friendsList;


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
            buildFriendsList(),
            buildFriends(),
            buildButton(),
          ],
        ),
      );

  Widget buildName() => TextFormField(
        maxLines: 1,
        initialValue: widget.name,
        onChanged: widget.onChangedName,
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
        initialValue: widget.email,
        onChanged: widget.onChangedEmail,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Email',
        ),
      );

  Widget buildPrefEnglish() => CheckboxListTile(
    title: Text("english"),
    value: widget.pref_english,
    onChanged: widget.onChangedPrefEnglish
  );
  Widget buildPrefKoreanLiterature() => CheckboxListTile(
      title: Text("korean literature"),
      value: widget.pref_korean_literature,
      onChanged: widget.onChangedPrefKoreanLiterature
  );

  Widget buildPrefMathematics() => CheckboxListTile(
      title: Text("mathematics"),
      value: widget.pref_mathematics,
      onChanged: widget.onChangedPrefMathematics
  );


  Widget buildInviter() => TextFormField(
    maxLines: 1,
    initialValue: widget.inviter,
    onChanged: widget.onChangedInviter,
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'inviter',
    ),
  );

  Widget buildFriendsList() => TextFormField(
    maxLines: 1,
    initialValue: widget.friendsList.join(",  "),
    onChanged: widget.onChangedInviter,
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Total friends',
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
          onPressed: widget.onSavedUser,
          child: Text('Save'),
        ),
      );

  /// get firends text-fields
  List<Widget> _getFriends(){
    List<Widget> friendsTextFields = [];
    for(int i=0; i<widget.friendsList.length; i++){
      friendsTextFields.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Expanded(child: Text(widget.friendsList[i])),
                SizedBox(width: 16,),
                // we need add button at last friends row
                _addRemoveButton(false, i),
              ],
            ),
          )
      );
    }
    friendsTextFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(child: FriendTextFields(widget.friendsList.length)),
              SizedBox(width: 16,),
              _addRemoveButton(true, widget.friendsList.length),
            ],
          ),
        )
    );
    return friendsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index){
    return InkWell(
      onTap: (){
        if(add){
          // add new text-fields at the top of all friends textfields
          widget.friendsList.insert(index, "asdf");
        }
        else widget.friendsList.removeAt(index);
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