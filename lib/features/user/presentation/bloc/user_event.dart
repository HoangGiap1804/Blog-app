part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentProfileEvent extends UserEvent {
  final String accessToken;
  GetCurrentProfileEvent({required this.accessToken});
}
