import 'package:fpdart/src/either.dart';
import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/core/usecases/usecase.dart';
import 'package:share_blog/features/comment/domain/repositories/comment_repository.dart';

class DeleteCommentUsecase implements UseCase<bool, UserDeleteCommentParams> {
  final CommentRepository commentRepository;
  DeleteCommentUsecase({required this.commentRepository});

  @override
  Future<Either<Failure, bool>> call(UserDeleteCommentParams params) async {
    try {
      final response = commentRepository.deleteComment(
        commentId: params.commentId,
        accessToken: params.accessToken,
      );
      return response;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}

class UserDeleteCommentParams {
  final String commentId;
  final String accessToken;
  UserDeleteCommentParams({required this.commentId, required this.accessToken});
}
