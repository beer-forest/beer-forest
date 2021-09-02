import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_authentication_tutorial/provider/users.dart';
import 'package:firebase_authentication_tutorial/widget/user_pref_widget.dart';

class MatchListWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<UsersProvider>(context);
    final map_pref_users = provider.map_pref_users;
    final pref_list = provider.pref_list;
    final pref_size_list = {};
    int each_pref_index = 0;
    int pref_index = 0;

    // size per preference
    for (var i=0; i< pref_list.length; i++) {
         pref_size_list[pref_list[i]]=map_pref_users[pref_list[i]].length;
    }


    int addUserCntFromEachPref(pref_size_list){
      int total_user_cnt = 0;
      pref_size_list.values.forEach((value) {
        total_user_cnt += value;
      });
      return total_user_cnt;
    }
    final total_user_cnt = addUserCntFromEachPref(pref_size_list);

    if (map_pref_users.isEmpty) {
      return Center(
        child: Text(
          'No matches.',
          style: TextStyle(fontSize: 20),
        ),
      );
    }
    else {
      return ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(16),
        separatorBuilder: (context, index) {
          return Container(height: 8);
          },
        itemCount: total_user_cnt,
        itemBuilder: (context, index) {
          //TODO(hschoi1): not showing the last item
          final pref = pref_list[pref_index];
          final users_by_pref = map_pref_users[pref];
          if (! users_by_pref.isEmpty) {
            final user = users_by_pref[each_pref_index];

            if (each_pref_index ==  (pref_size_list[pref]-1)) {
              each_pref_index = 0;
              pref_index += 1;
            }
            else {
              each_pref_index += 1;
            }
            return UserPrefWidget(user: user, pref: pref);
          }
          else{
            pref_index += 1;
          }


        },
      );
    }
  }
}
