import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobyte_mmcs_cards/blocs/card_bloc/card_bloc.dart';
import 'neo_profile.dart';
import 'nm_box.dart';

class CardContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height * 0.044;
    double size2 = MediaQuery.of(context).size.height * 0.094;
    return SafeArea(
      maintainBottomViewPadding: true,
      top: true,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: BlocBuilder<CardBloc, CardState>(
          builder: (context, state) {
            if (state is CardScreen)
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: size2,
                        height: size2,
                        decoration: nMbox,
                        child: IconButton(
                          onPressed: () {
                            BlocProvider.of<CardBloc>(context)
                                .add(DeleteCard());
                            Navigator.pop(context);
                          },
                          iconSize: size2 * 0.48,
                          icon: Icon(
                            Icons.delete,
                            color: fCL,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AvatarImage(),
                      SizedBox(height: 10),
                      Text(
                        state.user.surname +
                            ' ' +
                            state.user.name +
                            ' ' +
                            state.user.patronymic,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 10),
                      Text(
                        state.user.company + ': ' + state.user.position,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                      ),
                      SocialBox(
                          category: state.user.phone,
                          icon: Icons.contact_phone,
                          event: MakeACall(phone: state.user.phone)),
                      SocialBox(
                          category: state.user.mail,
                          icon: Icons.contact_mail,
                          event: SendEmail(email: state.user.mail)),
                      SocialBox(category: state.location, icon: Icons.room),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Container(
                          width: size2,
                          height: size2,
                          decoration: nMbox,
                          child: BackButton(
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
          },
        ),
      ),
    );
  }
}

class SocialBox extends StatelessWidget {
  final IconData icon;
  final String category;
  final CardEvent event;
  const SocialBox({this.icon, this.category, this.event = null});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height * 0.03,
        vertical: MediaQuery.of(context).size.height * 0.014,
      ),
      child: FlatButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        onPressed: () =>
            event != null ? BlocProvider.of<CardBloc>(context).add(event) : {},
        child: Container(
          padding: EdgeInsets.all(18),
          decoration: nMboxInvert,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: Color(0xff99D3F4),
                size: MediaQuery.of(context).size.height * 0.025,
              ),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  category,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
