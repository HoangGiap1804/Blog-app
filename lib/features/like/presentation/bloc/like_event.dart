part of 'like_bloc.dart';

sealed class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object> get props => [];
}

class LikeBlogEvent extends LikeEvent {
  final UserLikeBlogParams userLikeBlogParams;
  const LikeBlogEvent({required this.userLikeBlogParams});
}

class UnlikeBlogEvent extends LikeEvent {
  final UserUnlikeBlogParams userUnlikeBlogParams;
  const UnlikeBlogEvent({required this.userUnlikeBlogParams});
}
