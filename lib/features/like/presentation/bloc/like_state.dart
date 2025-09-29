part of 'like_bloc.dart';

sealed class LikeState extends Equatable {
  const LikeState();

  @override
  List<Object> get props => [];
}

final class LikeInitial extends LikeState {}

final class LikeLoadingState extends LikeState {}

final class LikeBlogSuccessState extends LikeState {}

final class LikeBlogFailureState extends LikeState {
  final String message;
  const LikeBlogFailureState({required this.message});
}

final class UnlikeBlogSuccessState extends LikeState {}

final class UnlikeBlogFailureState extends LikeState {
  final String message;
  const UnlikeBlogFailureState({required this.message});
}
