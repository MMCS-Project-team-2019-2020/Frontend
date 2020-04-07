//import 'dart:html';
import 'package:flutter/material.dart';
import 'profile.dart';
import '../Authorization/enter.dart';

// Массив профилей, карточки которых есть у основного пользователя
List<User> user_list = [];

bool inProcess = true;
//Заполнение этого массива.
Future<void> fillList(List<User> list) async {
  for (String id in main_user.own_cards) {
    User contact = new User();
    await getProfileFromCard(id, contact).then(
      (_) {
        //contact.PrintUser();
        list.add(contact);
      },
    );
  }
}

class UserButton extends StatelessWidget {
  final User current_user;
  UserButton(this.current_user);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        height: 75,
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          child: Text(current_user.surname + " " + current_user.name),
          onPressed: () => current_user.PrintUser(),
          padding: EdgeInsets.all(3.0),
          color: Colors.grey,
          focusColor: Colors.black45,
          splashColor: Colors.grey,
        ),
      ),
    );
  }
}

class AccountContent extends StatefulWidget {
  @override
  _AccountContentState createState() => _AccountContentState();
}

class _AccountContentState extends State<AccountContent> {
  @override
  Widget build(BuildContext context) {
    print("Out of everything!");
    print(user_list.length);
    return Center(
      child: inProcess
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Идёт загрузка визиток..."),
                CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                ),
              ],
            )
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Column(
                children: user_list.map((user) => UserButton(user)).toList(),
              ),
            ),
    );
  }
}
