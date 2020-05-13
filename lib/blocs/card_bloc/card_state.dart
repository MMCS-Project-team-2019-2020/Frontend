part of 'card_bloc.dart';

abstract class CardState extends Equatable {
  const CardState();
}

class CardScreen extends CardState {
  final User user;
  final String location;
  final String cardID;
  final ProfileBloc profileBloc;
  const CardScreen({this.user, this.location, this.cardID, this.profileBloc});
  @override
  List<Object> get props => [user, location, cardID, profileBloc];
}
