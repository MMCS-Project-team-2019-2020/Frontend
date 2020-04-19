import 'package:flutter/material.dart';
import 'profile.dart';
import '../Helpers/enter.dart';
import '../Helpers/profile_from_card.dart';

// Массив профилей, карточки которых есть у основного пользователя
Map<User, String> user_list = {};

bool inProcess = true;
//Заполнение этого массива.
Future<void> fillList(Map<User, String> list) async {
  if (main_user.own_cards.length != 0) {
    for (var item in main_user.own_cards.entries) {
      String id = item.key;
      User contact = new User();
      await getProfileFromCard(id, contact).then(
        (_) {
          //contact.PrintUser();
          list[contact] = item.value;
        },
      );
    }
  }
}

class UserButton extends StatelessWidget {
  final double width;
  final double height;
  final double cornerRadius;
  final Color color;
  final Color backgroundColor;
  final User current_user;
  final String geo;

  UserButton(
    this.geo,
    this.current_user, {
    Key key,
    this.cornerRadius = 4,
    this.color,
    this.backgroundColor,
    this.width = 400,
    this.height = 120,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(this.geo);
    var fgColor = color ?? Color(0xFF99D3F7);
    double lineHeight = 30;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(children: <Widget>[
        SizedBox(
          height: 120,
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            child: Container(
              height: height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(cornerRadius),
                  color: backgroundColor ?? Color(0xffDFDFDF)),
              padding: EdgeInsets.all(26),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(right: 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: fgColor),
                      height: 0,
                      width: 0,
                    ),
                  ),

                  //Content Line
                  Container(
                    margin: EdgeInsets.only(right: 50.0),
                    color: Colors.white,
                    height: lineHeight,
                    child: Text(
                        ' ' +
                            current_user.surname +
                            " " +
                            current_user.name +
                            '                                                                                                                                       ',
                        style: TextStyle(fontSize: 22, fontFamily: 'Comic')),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 50.0, top: 35),
                    height: lineHeight,
                    color: Colors.white,
                    child: Text(
                      ' ' +
                          current_user.company +
                          " " +
                          current_user.position +
                          '                                                                                                                                           ',
                      style: TextStyle(fontSize: 18, fontFamily: 'Comic'),
                    ),
                  ),

                  //Content Line
                  Container(
                    margin: EdgeInsets.only(right: 50.0, top: 35),
                    height: lineHeight,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2)),
                  ),

                  Container(
                    margin: EdgeInsets.only(right: 50.0),
                    height: lineHeight,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => Contact(current_user))),
            padding: EdgeInsets.all(3.0),
            color: Colors.black,
            focusColor: Colors.black45,
            splashColor: Colors.black,
          ),
        ),
      ]),
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
    return Scaffold(
      backgroundColor: Color(0xff22313F),
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: new Text(
          'Cохраненные визитки',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
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
                  children: user_list.entries
                      .map((entry) => UserButton(entry.value, entry.key))
                      .toList(),
                ),
              ),
      ),
    );
  }
}
