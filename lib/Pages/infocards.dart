import 'package:flutter/material.dart';
import 'package:shared/widgets/info_card.dart';
import 'profile.dart';
import '../Authorization/enter.dart'; // taking the "get-profile" function from there
import '../Authorization/login_screen.dart'; // taking user_id var from it.

String mail = "";
String name = 'TestMail';
String phone = '+7928-147-0-371';
bool first_time = true;

Future<void> filling() async {
  await getProfile(user_id, main_user).then((_) {
    name = main_user.name;
    phone = main_user.phone;
    mail = main_user.mail;
    main_user.PrintUser();
    //TODO: Рифат, доделай. Добавь выше поля, которые будут в инфокардах и присвой им соответствующие поля main_user.Все поля описаны в enter.dart
    //P.S. Логин добавлять не надо, равно как и own_cards. card_id надо в QR запихнуть.
  });
}

class ICards extends StatefulWidget {
  @override
  _ICardsState createState() => _ICardsState();
}

class _ICardsState extends State<ICards> {
  @override
  Widget build(BuildContext context) {
    if (first_time) {
      filling().then(
        (_) {
          first_time = false;
          setState(() {});
        },
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //TODO: Рифат, доделай, добавь инфокард на все поля и скролл
        InfoCard(
          text: phone,
          icon: Icons.phone,
        ),
        InfoCard(
          text: name,
          icon: Icons.account_circle,
        ),
        InfoCard(
          text: url,
          icon: Icons.web,
        ),
        InfoCard(
          text: 'Rostov-on-Don, Russia',
          icon: Icons.location_city,
        ),
      ],
    );
  }
}
