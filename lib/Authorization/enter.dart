import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import './login_screen.dart';

class User {
  int id;
  String name;
  String phone;
  List<int> cards;

  User({this.id, this.name, this.phone, this.cards});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: int.parse(json['id']),
        name: json['name'],
        phone: json['phone'],
        cards: json['own_cards'].map(int.parse).toList());
  }
}

Future<User> getProfile(String login) async {
  String request =
      "http://www.vvd-rks.ru/proj/?action=get-profile&login=$login";
  await http.get(request).then((response) {
    var answer = json.decode(response.body)['response'];
    return User(
        id: int.parse((answer['id'])),
        name: answer['name'],
        phone: answer['phone'],
        cards: answer[['own_cards'].map(int.parse).toList()]);
  });
}

Future<void> logIn(
  String login,
  String password,
) async {
  String request = "http://www.vvd-rks.ru/proj/?action=login&login=" +
      login +
      "&password=" +
      password;
  print(request);
  await http.get(request).then((response) {
    print("there!");
    if (json.decode(response.body)['response']['status'] == 1) {
      print("Passed");
      passController = true;
    } else {
      print("Not passed");
      passController = false;
    }
  });
}
