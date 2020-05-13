part of 'registry_bloc.dart';

abstract class RegistryBlocState extends Equatable {
  const RegistryBlocState();
}

class RegistryInitial extends RegistryBlocState {
  @override
  List<Object> get props => [];
}

class RegistrySuccess extends RegistryBlocState {
  @override
  List<Object> get props => [];
}

class RegistryFailed extends RegistryBlocState {
  final String reason;
  RegistryFailed({this.reason = ''});
  @override
  List<Object> get props => [];
}

class GoInside extends RegistryBlocState {
  final User user;
  GoInside({this.user});
  @override
  List<Object> get props => [];
}

class GoToLogin extends RegistryBlocState {
  @override
  List<Object> get props => [];
}

class RegProccess extends RegistryBlocState {
  @override
  List<Object> get props => [];
}

class RegAndGo extends RegistryBlocState {
  @override
  List<Object> get props => [];
}
