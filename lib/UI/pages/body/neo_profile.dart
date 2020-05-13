import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobyte_mmcs_cards/blocs/card_bloc/card_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../Helpers/user.dart';
import 'package:styled_text/styled_text.dart';
import '../../../blocs/login_bloc/login_bloc.dart';
import '../../../blocs/profile_bloc/profile_bloc.dart';
import '../authorization/login_screen.dart';
import 'card_contact.dart';
import 'nm_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyNeoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: TextTheme(body1: TextStyle(color: fCL))),
      home: MainCard(),
    );
  }
}

class MainCard extends StatelessWidget {
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      maintainBottomViewPadding: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: mC,
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is MainScreen && state.showQR) {
              double qrsize = MediaQuery.of(context).size.height * 0.24;
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Ваша визитка: ',
                              style: TextStyle(
                                  color: fCL,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: qrsize,
                            height: qrsize,
                            //padding: EdgeInsets.all(qrsize * 0.15),
                            child: QrImage(
                              data: state.user.cardID,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                      contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    );
                  });
            }
            if (state is MainScreen && state.acceptDecline) {
              ProfileBloc profileBloc = BlocProvider.of<ProfileBloc>(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Text(state.card['cardResult'],
                                      style: TextStyle(
                                          fontWeight: FontWeight
                                              .w700) //user.name +" "+ user.patronymic,
                                      ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.room,
                                      color: Color(0xff99D3F4), size: 20),
                                  SizedBox(width: 8),
                                  Flexible(child: Text(state.location)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: FlatButton(
                                        color: Colors.red[400],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Icon(
                                          Icons.clear,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: FlatButton(
                                        color: Colors.green[400],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        onPressed: () {
                                          profileBloc.add(
                                            Accept(
                                                location: state.location,
                                                user: state.user,
                                                card: state.card,
                                                cards: state.cards),
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.done,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ));
            }
            if (state is MainScreen && state.cameraDenied) {
              showDialog(
                  context: context,
                  builder: (context) {
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.of(context).pop(true);
                    });
                    return AlertDialog(
                      title: Text(
                        'Не удалось получить доступ к камере.',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    );
                  });
            }
            if (state is MainScreen && state.failure) {
              showDialog(
                  context: context,
                  builder: (context) {
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.of(context).pop(true);
                    });
                    return AlertDialog(
                      title: Text(
                        'Не удалось добавить нового пользвателя. \nВозможно, он у вас уже есть.',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    );
                  });
            }
            if (state is MainScreen && state.notACard) {
              showDialog(
                  context: context,
                  builder: (context) {
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.of(context).pop(true);
                    });
                    return AlertDialog(
                      title: Text(
                        'Не удалось считать QR-код.',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    );
                  });
            }
            if (state is MainScreen && state.showInfo) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Column(
                        //сканировать визитку и добавить в свой профиль.
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Flexible(
                                  child: StyledText(
                                text:
                                    'Чтобы добавить визитку - нажмите на <add/>.',
                                styles: {
                                  'add': IconStyle(Icons.add),
                                },
                              )),
                              Flexible(
                                  child: StyledText(
                                text:
                                    'Для того, чтобы поделиться визиткой - нажмите на <share/> .',
                                styles: {
                                  'share': IconStyle(Icons.share),
                                },
                              )),
                            ],
                          ),
                        ],
                      ),
                      contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    );
                  });
            }
          },
          child:
              BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            final String surName = state.user.surname + ' ' + state.user.name;
            final String work = state.user.company + '\n' + state.user.position;
            if (state is Proccess) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(state.caption),
                    SizedBox(
                      height: 10,
                    ),
                    CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                      Color(0xff99D3F4),
                    )),
                  ],
                ),
              );
            }
            if (state is MainScreen) {
              return Container(
                child: new Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: NMButton(
                                  icon: Icons.exit_to_app,
                                  event: LoggedOut(state.user)),
                            ),
                          ),
                          AvatarImage(),
                          SizedBox(height: 10),
                          Text(
                            surName,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            'login: ' + state.user.login,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w100),
                          ),
                          SizedBox(height: 10),
                          Text(
                            work,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                NMButton(
                                    icon: Icons.add,
                                    event: StartScan(state.user, state.cards)),
                                NMButton(
                                  icon: Icons.share,
                                  event: ShowQR(
                                      user: state.user, cards: state.cards),
                                ),
                                NMButton(
                                    icon: Icons.info_outline,
                                    event: ShowInfo(
                                        user: state.user, cards: state.cards)),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: cardList(state.cards, state.user),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container(
              color: Colors.green,
            );
          }),
        ),
      ),
    );
  }
}

///Превращает карточки в виджеты. Бьютифул
List<Card> cardList(Map<User, String> userCards, User user) {
  List<Card> result = List<Card>();
  if (userCards == null) // Если лист карточек пуст
    return result;
  for (var card in userCards.entries) {
    result.add(new Card(
      user: card.key,
      location: card.value,
      userID: user.id,
    ));
  }
  return result;
}

//класс для карточки
class Card extends StatelessWidget {
  final User user;
  final String location;
  final String userID;

  const Card({this.user, this.location, this.userID});

  @override
  Widget build(BuildContext context) {
    final surName = user.surname + ' ' + user.name;
    final work = user.company + ': ' + user.position;
    final loc = location == '' ? "Нет данных." : location;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height * 0.048,
        vertical: MediaQuery.of(context).size.height * 0.018,
      ),
      child: Container(
        decoration: nMboxInvertNew,
        child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider<CardBloc>(
                      create: (context) => CardBloc(
                            user: user,
                            location: loc,
                            cardID: user.cardID,
                            userID: userID,
                            profileBloc: BlocProvider.of<ProfileBloc>(context),
                          ),
                      child: CardContact()))),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Text(surName,
                        style: TextStyle(
                            fontWeight: FontWeight
                                .w700) //user.name +" "+ user.patronymic,
                        ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.business, color: Color(0xff99D3F4), size: 20),
                    SizedBox(width: 8),
                    Text(
                      work,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.room, color: Color(0xff99D3F4), size: 20),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        location,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NMButton extends StatelessWidget {
  final IconData icon;
  final ProfileEvent event;
  final ProfileBloc profileBloc;

  NMButton({this.icon, this.event, this.profileBloc});
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height * 0.069;
    return Container(
      width: size,
      height: size,
      decoration: nMbox,
      child: Center(
        child: IconButton(
          onPressed: () {
            if (event is LoggedOut)
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider<LoginBloc>(
                    create: (context) => LoginBloc()..add(Exit()),
                    child: LoginScreen(),
                  ),
                ),
              );
            if (event == null) {
            } else {
              BlocProvider.of<ProfileBloc>(context).add(event);
            }
          },
          iconSize: size * 0.5,
          icon: Icon(
            icon,
            color: fCL,
          ),
        ),
      ),
    );
  }
}

class AvatarImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height * 0.188;

    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(8),
      decoration: nMbox,
      child: Container(
        decoration: nMbox,
        padding: EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('images/avatar.jpg'),
            ),
          ),
        ),
      ),
    );
  }
}
