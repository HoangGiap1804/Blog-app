part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSucessfuly extends UserState {
  final UserProfileEntity userProfileEntity;
  const UserSucessfuly({required this.userProfileEntity});
}

final class UserFaile extends UserState {
  final String failure;
  const UserFaile({required this.failure});
}
