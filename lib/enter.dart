import 'dart:convert';
import 'package:http/http.dart' as http;
import './login_screen.dart';

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
      passController = "Passed";
    } else {
      print("Not passed");
      passController = "Not passed";
    }
  });
}
