part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class Login extends LoginState {
  final bool failed;

  const Login({this.failed = false});

  @override
  List<Object> get props => [];
}

class Check extends LoginState {
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  final User user;
  const LoginSuccess(this.user);

  @override
  List<Object> get props => [];
}

class SwitchToRegState extends LoginState {
  @override
  List<Object> get props => null;
}
