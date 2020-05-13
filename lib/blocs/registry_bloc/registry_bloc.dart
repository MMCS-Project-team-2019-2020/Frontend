import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../Helpers/user.dart';
import '../../Helpers/requests.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'registry_event.dart';
part 'registry_state.dart';

Requests _requests = Requests();

Future<bool> _check(CheckFields event) async {
  bool allFieldsNotNull = event.name != "" &&
      event.surname != "" &&
      event.patronymic != "" &&
      event.company != "" &&
      event.position != "" &&
      event.mail != "" &&
      event.mail.contains('@') &&
      event.phone != "" &&
      event.login != "";
  if (allFieldsNotNull) {
    if (await _requests.loginIsFree(login: event.login)) {
      if (event.password.length > 3) {
        return true;
      }
    }
  }
  return false;
}

Future<User> _reg(CheckFields event) async {
  await _requests.registry(
      name: event.name,
      surname: event.surname,
      patronymic: event.patronymic,
      company: event.company,
      position: event.position,
      mail: event.mail,
      phone: event.phone,
      login: event.login,
      password: event.password);
  String id =
      await _requests.getID(login: event.login, password: event.password);
  await _requests.createCard(
      userID: id,
      surname: event.surname,
      name: event.name,
      company: event.company,
      position: event.position);
  User user = await _requests.getProfileFromID(userID: id);
  return user;
}

class RegistryBloc extends Bloc<RegistryBlocEvent, RegistryBlocState> {
  @override
  RegistryBlocState get initialState => RegistryInitial();

  @override
  Stream<RegistryBlocState> mapEventToState(
    RegistryBlocEvent event,
  ) async* {
    if (event is CheckFields) {
      yield RegProccess();
      if (await _check(event)) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('login', event.login);
        prefs.setString('password', event.password);
        User user = await _reg(event);
        yield GoInside(user: user);
      } else {
        yield RegistryFailed();
      }
    }
    if (event is BackToLogin) {
      yield GoToLogin();
      yield RegistryInitial();
    }
    if (event is CheckFailed) {
      yield RegistryFailed();
    }
  }
}
