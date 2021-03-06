import 'package:firebase_authentication_tutorial/page/matched_user_profile_page.dart';
import 'package:firebase_authentication_tutorial/route/route.dart' as route;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_authentication_tutorial/model/userprofile.dart';
import 'package:firebase_authentication_tutorial/provider/users.dart';
import 'package:firebase_authentication_tutorial/util/utils.dart';

class UserPrefWidget extends StatelessWidget {

  final UserProfile user;
  final String pref;

  const UserPrefWidget({
    @required this.user,
    @required this.pref,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: buildUser(context),
    );
  }

  Widget buildUser(BuildContext context) {
    final provider = Provider.of<UsersProvider>(context);
    final pref_to_kor = provider.pref_to_kor;

    return GestureDetector(
      onTap: () => viewUser(context, user),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme
                          .of(context)
                          .primaryColor,
                      fontSize: 22,
                    ),
                  ),
                  if (pref.isNotEmpty)
                    Container(
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                            "https://static.wikia.nocookie.net/meme/images/1/16/Yee.png/revision/latest?cb=20190307094426",
                          ),
                        ),
                      ),
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        "??? " + pref_to_kor[pref] + "???(???) ??????????????????????",
                        style: TextStyle(fontSize: 20, height: 1.5),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  void viewUser(BuildContext context, UserProfile user) =>

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => MatchedUserProfilePage(user: user),
    ),
  );
}
