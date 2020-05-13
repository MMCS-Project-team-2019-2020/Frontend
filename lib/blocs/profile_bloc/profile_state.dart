part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  final User user;
  final Map<User, String> cards;
  const ProfileState(this.user, this.cards);
}

class MainScreen extends ProfileState {
  final bool acceptDecline;
  final bool success;
  final bool showInfo;
  final bool failure;
  final bool notACard;
  final bool cameraDenied;
  final bool showQR;
  final Map<String, String> card;
  final String location;
  MainScreen({
    user,
    cards,
    this.acceptDecline = false,
    this.card = const {},
    this.location = '',
    this.success = false,
    this.failure = false,
    this.notACard = false,
    this.cameraDenied = false,
    this.showQR = false,
    this.showInfo = false,
  }) : super(user, cards);
  @override
  List<Object> get props => [user, cards];
}

class Proccess extends ProfileState {
  final String caption;
  const Proccess(user, cards, this.caption) : super(user, cards);
  @override
  List<Object> get props => [user, cards];
}

class AcceptDeclineCard extends ProfileState {
  final String location;
  final Map<String, String> card;
  const AcceptDeclineCard(user, cards, this.card, this.location)
      : super(user, cards);
  @override
  List<Object> get props => [user, cards, card];
}

class Scaned extends ProfileState {
  Scaned(user, cards) : super(user, cards);
  @override
  List<Object> get props => [user, cards];
}

class CameraDenied extends ProfileState {
  CameraDenied(user, cards) : super(user, cards);
  List<Object> get props => [user, cards];
}

class NotACard extends ProfileState {
  NotACard(user, cards) : super(user, cards);
  @override
  List<Object> get props => [user, cards];
}

class CardProfile extends ProfileState {
  CardProfile(user, cards) : super(user, cards);
  @override
  List<Object> get props => [user, cards];
}
