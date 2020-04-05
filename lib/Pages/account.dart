import 'package:flutter/material.dart';
import 'profile.dart';
import '../Authorization/enter.dart';

String _prof;
String _id;

class AccountContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Text("Test for request!"),
        RaisedButton(
          onPressed: () {
            getCard("1005", "10011", main_user);
            getProfile(main_user.id, main_user);
          },
          child: Text("Testing button!"),
        ),
      ],
    ));
  }
}
