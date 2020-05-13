import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../Helpers/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Helpers/requests.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Requests requests = Requests();
  @override
  LoginState get initialState => Login();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is Exit) {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('login');
      prefs.remove('password');
    }
    if (event is CheckSavedData) {
      yield Check();
      final prefs = await SharedPreferences.getInstance();
      final password = prefs.getString('password') ?? 0;
      final login = prefs.getString('login') ?? 0;
      if (password == 0) {
        yield Login();
      } else {
        String id = await requests.getID(login: login, password: password);
        User user = await requests.getProfileFromID(userID: id);
        yield LoginSuccess(user);
        yield Login();
      }
    }
    if (event is CheckLogin) {
      yield Check();
      final bool token = await requests.userExist(
          login: event.login, password: event.password);
      if (token) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('login', event.login);
        prefs.setString('password', event.password);
        String id =
            await requests.getID(login: event.login, password: event.password);
        User user = await requests.getProfileFromID(userID: id);
        yield LoginSuccess(user);
        yield Login();
      } else {
        yield Login(failed: true);
      }
    }
    if (event is SwitchToReg) {
      yield SwitchToRegState();
      yield Login();
    }
  }
}
