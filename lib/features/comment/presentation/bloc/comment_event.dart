part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class CreateCommentEvent extends CommentEvent {
  final UserCreateCommentParams userCreateCommentParams;
  const CreateCommentEvent({required this.userCreateCommentParams});
}

class GetListCommentEvent extends CommentEvent {
  final UserGetListCommentParams userGetListCommentParams;
  const GetListCommentEvent({required this.userGetListCommentParams});
}

class DeleteCommentEvent extends CommentEvent {
  final UserDeleteCommentParams userDeleteCommentParams;
  const DeleteCommentEvent({required this.userDeleteCommentParams});
}
