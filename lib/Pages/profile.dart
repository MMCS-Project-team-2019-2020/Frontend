import 'package:flutter/material.dart';
import 'package:shared/Pages/infocards.dart';
import '../Authorization/enter.dart';

User main_user = new User();

class GridContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (content, index) {
          return Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 35,
                ),
                Text(
                  'Ваш Профиль',
                  style: TextStyle(
                    fontSize: 60.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'мои визитки',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.teal[50],
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                  width: 200,
                  child: Divider(
                    color: Colors.teal.shade700,
                  ),
                ),
                ICards(main_user),
                SizedBox(
                  height: 65,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/*InfoCard(
              text: phone,
              icon: Icons.phone,
            ),
            InfoCard(
              text: email,
              icon: Icons.email,
            ),
            InfoCard(
              text: url,
              icon: Icons.web,
            ),
            InfoCard(
              text: 'Rostov-on-Don, Russia',
              icon: Icons.location_city,
            ),
           */
