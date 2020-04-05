import 'package:flutter/material.dart';
import 'profile.dart';
import '../Authorization/enter.dart';

List<User> user_list =
    []; // Массив профилей, карточки которых есть у основного пользователя

//Заполнение этого массива.
void fillList() {
  for (String id in main_user.own_cards) {
    User contact = new User();
    getProfileFromCard(id, contact).then((_) => contact.PrintUser());
  }
}

class AccountContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Text("Test for request!"),
        RaisedButton(
          onPressed: () {
            fillList();
          },
          child: Text("Testing button!"),
        ),
      ],
    ));
  }
}
