import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:mobyte_mmcs_cards/Helpers/requests.dart';
import 'package:mobyte_mmcs_cards/Helpers/scan.dart';
import 'package:mobyte_mmcs_cards/Helpers/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

Requests _requests = Requests();

///Словарь контактов основного профиля с их геолокацией.
Future<Map<User, String>> _getCards(Map<String, String> cards) async {
  Map<User, String> result = Map<User, String>();
  if (cards.length != 0) {
    for (var item in cards.entries) {
      String id = item.key;
      User contact = await _requests.getUserFromCard(id);
      result[contact] = item.value;
    }
  }
  return result;
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  User user;
  ProfileBloc({this.user});
  @override
  ProfileState get initialState => MainScreen(user: user, cards: null);

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is Accept) {
      if (await accept(event.user, event.location, event.card)) {
        yield Proccess(event.user, null, 'Идёт добавление карточки...');
        final user = await _requests.update(event.user);
        final _cards = await _getCards(user.ownCards);
        yield MainScreen(user: user, cards: _cards);
      } else {
        yield Proccess(event.user, event.cards, "Попытка добавить карточку...");
        yield MainScreen(
          user: event.user,
          cards: event.cards,
          failure: true,
        ); // Если не получилось добавить карточку.
      }
    }
    if (event is ShowQR) {
      yield Proccess(event.user, event.cards, "");
      yield MainScreen(user: event.user, cards: event.cards, showQR: true);
      yield Proccess(event.user, event.cards, "");
      yield MainScreen(user: event.user, cards: event.cards, showQR: false);
    }
    if (event is ShowInfo) {
      yield Proccess(event.user, event.cards, "");
      yield MainScreen(user: event.user, cards: event.cards, showInfo: true);
      yield Proccess(event.user, event.cards, "");
      yield MainScreen(user: event.user, cards: event.cards, showInfo: false);
    }
    if (event is ProfileUpdate) {
      yield Proccess(event.user, null,
          'Идёт обновление данных аккаунта.\nПожалуйста, подождите.');
      final user = await _requests.update(event.user);
      final _cards = await _getCards(user.ownCards);
      yield MainScreen(user: user, cards: _cards);
    }
    if (event is StartScan) {
      print("there");
      String scanResult = '';
      try {
        scanResult = await scan();
        Map<String, String> card = await _requests
            .getCard(scanResult); // Получение карточки по ID со скана.
        bool isCard =
            (card['cardResult'] != "error" && card['cardResult'] != "");
        if (isCard) {
          yield Proccess(event.user, event.cards,
              'Идёт получение данных геопозиции.\nПожалуйста, подождите.');
          String location = await getLocation(); // Получить геолокацию.
          yield MainScreen(
              user: event.user,
              cards: event.cards,
              acceptDecline: true,
              card: card,
              location: location);
        } else {
          yield Proccess(event.user, event.cards, "");
          yield MainScreen(
              user: event.user,
              cards: event.cards,
              notACard: true); // Если отсканированное - не карточка.
        }
      } on FormatException {
        yield Proccess(event.user, event.cards, "");
        yield MainScreen(
            user: event.user,
            cards: event.cards); // Если юзер нажал "назад" на телефоне.

      } on PlatformException {
        yield Proccess(event.user, event.cards, "");
        yield MainScreen(
            user: event.user,
            cards: event.cards,
            cameraDenied: true); // Если нет доступа к камере.
      }
    }
  }
}
