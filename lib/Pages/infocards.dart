import 'package:flutter/material.dart';
import 'package:shared/widgets/info_card.dart';
import '../Authorization/enter.dart';
import '../Authorization/login_screen.dart';

String url = 'http://vk.com/';
String name = 'TestMail';
String phone = '+7928-147-0-371';
bool first_time = true;
User user = new User();

Future<void> filling() async {
  await getProfile(login, user).then((_) {
    name = user.name;
    phone = user.phone;
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
