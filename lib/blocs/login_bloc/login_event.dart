part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class CheckLogin extends LoginEvent {
  final String login;
  final String password;

  CheckLogin({this.login, this.password});

  @override
  String toString() => 'Check login: $login, password: $password';

  @override
  List<Object> get props => [login, password];
}

class SwitchToReg extends LoginEvent {
  List<Object> get props => [];
}

class CheckSavedData extends LoginEvent {
  List<Object> get props => [];
}

class Exit extends LoginEvent {
  List<Object> get props => [];
}
