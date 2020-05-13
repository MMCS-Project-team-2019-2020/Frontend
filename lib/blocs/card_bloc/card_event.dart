part of 'card_bloc.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();
}

class MakeACall extends CardEvent {
  final String phone;
  const MakeACall({this.phone});
  @override
  List<Object> get props => [phone];
}

class SendEmail extends CardEvent {
  final String email;
  const SendEmail({this.email});
  @override
  List<Object> get props => [email];
}

class DeleteCard extends CardEvent {
  @override
  List<Object> get props => [];
}
