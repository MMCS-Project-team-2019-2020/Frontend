part of 'registry_bloc.dart';

abstract class RegistryBlocEvent extends Equatable {
  const RegistryBlocEvent();
}

class CheckFields extends RegistryBlocEvent {
  final String name;
  final String surname;
  final String patronymic;
  final String company;
  final String position;
  final String mail;
  final String phone;
  final String login;
  final String password;
  CheckFields({
    this.name = "",
    this.surname = "",
    this.patronymic = "",
    this.company = "",
    this.position = "",
    this.mail = "",
    this.phone = "",
    this.login = "",
    this.password = "",
  });

  @override
  List<Object> get props => [
        name,
        surname,
        patronymic,
        company,
        position,
        mail,
        phone,
        login,
        password,
      ];
}

class BackToLogin extends RegistryBlocEvent {
  @override
  List<Object> get props => [];
}

class CheckFailed extends RegistryBlocEvent {
  @override
  List<Object> get props => [];
}
