import 'package:flutter/material.dart';
import './enter.dart';
import '../widgets/info_card.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Contact extends StatelessWidget {
  final User cardOwner;
  Contact(this.cardOwner);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff22313F),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[             
              
              
              Container(
                width: 100,
                margin: EdgeInsets.only(right: 250),
                child: RaisedButton(
                  
                  child: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              
              ),
              
              SizedBox(
                height: 25,
              ),
              InfoCard(
                text: cardOwner.phone,
                icon: Icons.phone,
              ),
              InfoCard(
                text: cardOwner.name,
                icon: Icons.account_circle,
              ),
              InfoCard(
                text: cardOwner.surname,
                icon: Icons.account_circle,
              ),
              InfoCard(
                text: cardOwner.mail,
                icon: Icons.web,
              ),
              InfoCard(
                text: cardOwner.company,
                icon: Icons.business,
              ),
              InfoCard(
                text: cardOwner.position,
                icon: Icons.business_center,
              ),
              SizedBox(
                height: 45,
              ),
              QrImage(
                data: cardOwner.card_id,
                backgroundColor: Colors.white,
                size: 300,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
