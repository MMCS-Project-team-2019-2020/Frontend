import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import './login_screen.dart';

class CardException implements Exception {
  String message;
  CardException(this.message) {
    print("Raised exception with body $message");
  }
}

class User {
  String id;
  String name;
  String phone;
  String surname;
  String patronymic;
  String company;
  String position;
  String mail;
  String login;
  String card_id;
  List<String> own_cards;

  User({
    this.id = "",
    this.name = "",
    this.phone = "",
    this.surname = "",
    this.patronymic = "",
    this.company = "",
    this.position = "",
    this.mail = "",
    this.login = "",
    this.card_id = "",
    this.own_cards = const [""],
  });

  void PrintUser() {
    print(id);
    print(name);
    print(phone);
    print(surname);
    print(patronymic);
    print(company);
    print(position);
    print(mail);
    print(login);
    print(card_id);
    print(own_cards);
  }
}

Future<void> getProfile(String id_user, User user_profile) async {
  String request =
      "http://www.vvd-rks.ru/proj/?action=get-profile&id_user=$id_user";
  await http.get(request).then((response) async {
    var answer = json.decode(response.body)['response'];
    user_profile.id = answer['id'];
    user_profile.name = answer['name'];
    user_profile.phone = answer['phone'];
    user_profile.surname = answer['surname'];
    user_profile.patronymic = answer['patronymic'];
    user_profile.company = answer['company'];
    user_profile.position = answer['position'];
    user_profile.mail = answer['mail'];
    user_profile.login = answer['login'];
    user_profile.card_id = answer['own_cards'];
    request =
        "http://vvd-rks.ru/proj/?action=get-list-card&id_user=$user_profile.card_id";
    await http.get(request).then((response) {
      // Ниже идёт запрос на получение списка визиток, доступных пользователю
      answer = json.decode(response.body)['response'];
      if (answer['status'] == 1) {
        //Если у пользователя есть карточки
        user_profile.own_cards = answer['cards'];
      }
    });
  });
}

Future<void> getCard(String owner_id, String card_id, User user) async {
  String _request =
      "http://vvd-rks.ru/proj/?action=give-card&id_owner=$owner_id&id_recipient=$user.id&id_card=$card_id";
  await http.get(_request).then((response) {
    var answer = json.decode(response.body);
    if (answer['response']['status'] == 0) {
      //  Если не получилось - вызывается исколючение
      throw CardException(answer['response']['id']);
    }
  });
}

Future<void> getProfileFromCard(String card_id, User user) {}

Future<void> logIn(
  String _login,
  String _password,
) async {
  String request = "http://www.vvd-rks.ru/proj/?action=login&login=" +
      _login +
      "&password=" +
      _password;
  print(request);
  await http.get(request).then((response) {
    if (json.decode(response.body)['response']['status'] == 1) {
      print("Passed");
      passController = true;
      user_id = json.decode(response.body)['response']['id_user'];
    } else {
      print("Not passed");
      passController = false;
    }
  });
}
