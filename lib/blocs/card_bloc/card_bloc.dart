import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobyte_mmcs_cards/Helpers/requests.dart';
import 'package:mobyte_mmcs_cards/blocs/profile_bloc/profile_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Helpers/user.dart';

part 'card_event.dart';
part 'card_state.dart';

Requests _requests = Requests();

Future<void> _launchCaller(String number) async {
  String url = "tel:$number";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    return;
  }
}

Future<void> _sendEmail(String email) async {
  String url = "mailto:$email?subject=&body=";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    return;
  }
}

class CardBloc extends Bloc<CardEvent, CardState> {
  User user;
  String location;
  String cardID;
  String userID;
  ProfileBloc profileBloc;
  CardBloc(
      {this.user, this.location, this.cardID, this.profileBloc, this.userID});
  @override
  CardState get initialState =>
      CardScreen(user: user, location: location, profileBloc: profileBloc);

  @override
  Stream<CardState> mapEventToState(
    CardEvent event,
  ) async* {
    if (event is MakeACall) {
      await _launchCaller(event.phone);
    }
    if (event is SendEmail) {
      await _sendEmail(event.email);
    }
    if (event is DeleteCard) {
      await _requests.deleteCard(userID, cardID);
      profileBloc.add(ProfileUpdate(profileBloc.user));
    }
  }
}
