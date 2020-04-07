import 'package:flutter/material.dart';
import 'package:shared/Pages/account.dart';
import 'package:shared/widgets/info_card.dart';
import 'profile.dart';
import '../Authorization/enter.dart'; // taking the "get-profile" function from there
import '../Authorization/login_screen.dart'; // taking user_id var from it.

String _company = '';
String _position = '';
String _surname = '';
String _mail = "";
String _name = '';
String _phone = '';
bool _first_time = true;

Future<void> filling(User fill_user) async {
  await getProfile(user_id, main_user).then((_) {
    _name = fill_user.name;
    _surname = fill_user.surname;
    _phone = fill_user.phone;
    _mail = fill_user.mail;
    _company = fill_user.company;
    _position = fill_user.position;
    fill_user.PrintUser();

    //TODO: Рифат, доделай. Добавь вы присвой им соответствующие поля main_user.Все поля описаны в enter.dart
    //P.S. Логин добавлять не надо, равно как и own_cards. card_id надо в QR запихнуть.ше поля, которые будут в инфокардах и
  });
}

class ICards extends StatefulWidget {
  final User iCUser;
  ICards(this.iCUser);
  @override
  _ICardsState createState() => _ICardsState(iCUser);
}

class _ICardsState extends State<ICards> {
  User iCSUser;
  _ICardsState(this.iCSUser);
  @override
  Widget build(BuildContext context) {
    if (_first_time) {
      filling(iCSUser).then(
        (_) {
          if (mounted) {
            setState(() {
              _first_time = false;
            });
          }
          fillList(user_list).then((_) => inProcess = false);
        },
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //TODO: Рифат, доделай, добавь инфокард на все поля и скролл
        InfoCard(
          text: _phone,
          icon: Icons.phone,
        ),
        InfoCard(
          text: _name,
          icon: Icons.account_circle,
        ),
        InfoCard(
          text: _surname,
          icon: Icons.account_circle,
        ),
        InfoCard(
          text: _mail,
          icon: Icons.web,
        ),
        InfoCard(
          text: _company,
          icon: Icons.business,
        ),
        InfoCard(
          text: _position,
          icon: Icons.business_center,
        ),
      ],
    );
  }
}
