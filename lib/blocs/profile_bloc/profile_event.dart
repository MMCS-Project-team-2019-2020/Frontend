part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  final User user;
  const ProfileEvent(this.user);
}

class ProfileUpdate extends ProfileEvent {
  ProfileUpdate(user) : super(user);
  @override
  List<Object> get props => [user];
}

class LoggedOut extends ProfileEvent {
  LoggedOut(user) : super(user);
  @override
  List<Object> get props => [user];
}

class ShowInfo extends ProfileEvent {
  final Map<User, String> cards;
  ShowInfo({user, this.cards}) : super(user);
  @override
  List<Object> get props => [user, cards];
}

class StartScan extends ProfileEvent {
  final Map<User, String> cards;
  const StartScan(user, this.cards) : super(user);
  @override
  List<Object> get props => [user, cards];
}

class FinishedScan extends ProfileEvent {
  final Map<User, String> cards;
  const FinishedScan(user, this.cards) : super(user);
  @override
  List<Object> get props => [user, cards];
}

class Accept extends ProfileEvent {
  final Map<User, String> cards;
  final String location;
  final Map<String, String> card;
  const Accept({user, this.card, this.location, this.cards}) : super(user);
  @override
  List<Object> get props => [user, location, card];
}

class OpenCard extends ProfileEvent {
  OpenCard(user) : super(user);
  @override
  List<Object> get props => [user];
}

class ShowQR extends ProfileEvent {
  final Map<User, String> cards;
  ShowQR({user, this.cards}) : super(user);

  @override
  // TODO: implement props
  List<Object> get props => [user, cards];
}

class DeleteCard extends ProfileEvent {
  final String userID;
  final String cardID;
  const DeleteCard({user, this.userID, this.cardID}) : super(user);
  @override
  List<Object> get props => [userID, cardID];
}
