part of 'comment_bloc.dart';

sealed class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

final class CommentInitial extends CommentState {}

final class CommentLoadingState extends CommentState {}

final class CommentCreateSuccess extends CommentState {
  final CommentEntity commentEntity;
  const CommentCreateSuccess({required this.commentEntity});
}

final class CommentCreateFailure extends CommentState {
  final String message;
  const CommentCreateFailure({required this.message});
}

final class GetListCommentSuccess extends CommentState {
  final List<CommentEntity> commentEntitys;
  const GetListCommentSuccess({required this.commentEntitys});
}

final class GetListCommentFailure extends CommentState {
  final String message;
  const GetListCommentFailure({required this.message});
}

final class DeleteCommentSuccess extends CommentState {
  const DeleteCommentSuccess();
}

final class DeleteCommentFailure extends CommentState {
  final String message;
  const DeleteCommentFailure({required this.message});
}
