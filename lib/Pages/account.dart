//import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared/widgets/placeholder_card_short.dart';
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
  final double width;
  final double height;
  final double cornerRadius;
  final Color color;
  final Color backgroundColor;
  final User current_user;

  UserButton(this.current_user, {Key key, this.cornerRadius = 4, this.color, this.backgroundColor, this.width = 400, this.height = 120, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
  var fgColor = color ?? Color(0xFF99D3F7);
    double lineHeight = 30; 
    return Padding(
      padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
               
        SizedBox(
        height: 120,
        width: MediaQuery.of(context).size.width,
      

        child: RaisedButton(
          child: Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cornerRadius),
        color: backgroundColor ?? Color(0xFFC7EAFF)
      ),
      
      padding: EdgeInsets.all(26),
      child: Stack(
        children: <Widget>[
          
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(right: 0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: fgColor),
              height: 32,
              width: 32,
            ),
          ),

          //Content Line
          Container(margin: EdgeInsets.only(right: 50.0), 
          color: fgColor, height: lineHeight, 
          child: Text(current_user.surname + " " + current_user.name + '                               ',
           style: TextStyle(
             fontSize: 20,    
           )
          
          ),
          ),  
      //Content Line
          Container(
            margin: EdgeInsets.only(right: 50.0, top: lineHeight + 6), 
            color: fgColor, height: lineHeight, 
            child: Text(current_user.company + " " + current_user.position + '                               ',
            style: TextStyle(
              fontSize: 20,
            ),
            ),
          ),
        ],
      ),
   ),
          onPressed: () => current_user.PrintUser(),
          padding: EdgeInsets.all(3.0),
          color: Color(0xFF75B7E1),
          focusColor: Colors.black45,
          splashColor: Color(0xFF75B7E1),
        ),
        
        
        
      ),
              ]
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
