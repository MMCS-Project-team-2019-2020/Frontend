
import 'package:flutter/material.dart';
import 'package:shared/widgets/info_card.dart';
const url = 'http://vk.com/';
const email = 'AkzhigitovRifat@gmail.com';
const phone = '+7928-147-0-371';

class GridContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
            InfoCard(
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
           
          ],
        );
    
}

}
