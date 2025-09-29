import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:share_blog/features/comment/domain/entities/comment_entity.dart';
import 'package:share_blog/features/comment/domain/usecases/create_comment_usecase.dart';
import 'package:share_blog/features/comment/domain/usecases/delete_comment_usecase.dart';
import 'package:share_blog/features/comment/domain/usecases/get_list_comments_usecase.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CreateCommentUsecase _commentUsecase;
  final GetListCommentsUsecase _getListCommentsUsecase;
  final DeleteCommentUsecase _deleteCommentUsecase;

  CommentBloc({
    required CreateCommentUsecase commentUsecase,
    required GetListCommentsUsecase getListCommentsUsecase,
    required DeleteCommentUsecase deleteCommentUsecase,
  }) : _commentUsecase = commentUsecase,
       _getListCommentsUsecase = getListCommentsUsecase,
       _deleteCommentUsecase = deleteCommentUsecase,
       super(CommentInitial()) {
    on<CreateCommentEvent>((event, emit) async {
      emit(CommentLoadingState());

      final response = await _commentUsecase.call(
        event.userCreateCommentParams,
      );

      response.fold(
        (failure) => emit(CommentCreateFailure(message: failure.message)),
        (success) => emit(CommentCreateSuccess(commentEntity: success)),
      );
    });

    on<GetListCommentEvent>((event, emit) async {
      emit(CommentLoadingState());

      final response = await _getListCommentsUsecase.call(
        event.userGetListCommentParams,
      );

      response.fold(
        (failure) => emit(GetListCommentFailure(message: failure.message)),
        (success) => emit(GetListCommentSuccess(commentEntitys: success)),
      );
    });

    on<DeleteCommentEvent>((event, emit) async {
      emit(CommentLoadingState());

      final response = await _deleteCommentUsecase.call(
        event.userDeleteCommentParams,
      );

      response.fold(
        (failure) => emit(DeleteCommentFailure(message: failure.message)),
        (success) {
          if (success) {
            emit(DeleteCommentSuccess());
          } else {
            emit(DeleteCommentFailure(message: "Can not delete comment"));
          }
        },
      );
    });
  }
}
