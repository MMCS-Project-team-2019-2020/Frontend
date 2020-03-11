import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void log_in(
  String login,
  String password,
) {
  String request = "https://json.flutter.su/echo";

  http.get(request).then((response) {
    print("there!");
    if (json.decode(response.body)['response'] == 1) {
      Center(
          child: Text(
        "It works!",
        style: TextStyle(fontSize: 24),
      ));
    } else {
      Center(
          child: Text(
        "It works!",
        style: TextStyle(fontSize: 24),
      ));
      ;
    }
  });
}
