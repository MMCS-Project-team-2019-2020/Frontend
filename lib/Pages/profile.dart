import 'package:flutter/material.dart';
import 'package:shared/Helpers/cards.dart';
import '../Helpers/enter.dart';

User main_user = new User();

class GridContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF75B7E1),
        appBar: new AppBar(
          title: new Text('Ваш Профиль'),
        ),
      body: Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (content, index) {
          return Container(
            child: Column(
              children: <Widget>[
                ICards(main_user),
                SizedBox(
                  height: 65,
                ),
              ],
            ),
          );
        },
      ),
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
