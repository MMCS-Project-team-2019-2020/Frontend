import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobyte_mmcs_cards/Helpers/user.dart';

class PlaceholderCardShort extends StatelessWidget {
  final double width;
  final double height;
  final double cornerRadius;
  final Color color;
  final Color backgroundColor;
  final User current_user;

  const PlaceholderCardShort(this.current_user,
      {Key key,
      this.cornerRadius = 4,
      this.color,
      this.backgroundColor,
      this.width = 400,
      this.height = 90})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var r = Random();
    var fgColor = color ?? Color(0xfff2f2f2);
    double lineHeight = 16;
    return Container(
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: backgroundColor ?? Color(0xFFC7EAFF)),
      padding: EdgeInsets.all(26),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(right: 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: fgColor),
              height: 32,
              width: 32,
            ),
          ),

          //Content Line
          Container(
            margin: EdgeInsets.only(right: 50.0),
            color: fgColor,
            height: lineHeight,
            child: Text(
                current_user.surname +
                    " " +
                    current_user.name +
                    '                               ',
                style: TextStyle(
                  fontSize: 20,
                )),
          ),
          //Content Line
          Container(
            margin: EdgeInsets.only(right: 50.0, top: lineHeight + 6),
            color: fgColor,
            height: lineHeight,
            child: Text(
              current_user.company +
                  " " +
                  current_user.position +
                  '                               ',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
