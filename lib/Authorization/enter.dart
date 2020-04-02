import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import './login_screen.dart';

class User {
  String id;
  String name;
  String phone;
  List<dynamic> cards;

  User({this.id = "", this.name = "", this.phone = "", this.cards});

  void PrintUser() {
    print(name);
    print(id);
    print(phone);
    print(cards);
  }
}

Future<void> getProfile(String login, User user_profile) async {
  String request =
      "http://www.vvd-rks.ru/proj/?action=get-profile&login=$login";
  await http.get(request).then((response) {
    var answer = json.decode(response.body);
    print("Answer is $answer");
    user_profile.id = answer['response']['id'];
    user_profile.name = answer['response']['name'];
    user_profile.phone = answer['response']['phone'];
    //user_profile.cards = answer['own_cards'];
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
