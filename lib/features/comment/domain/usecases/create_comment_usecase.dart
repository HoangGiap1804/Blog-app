import 'package:fpdart/src/either.dart';
import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/core/usecases/usecase.dart';
import 'package:share_blog/features/comment/domain/entities/comment_entity.dart';
import 'package:share_blog/features/comment/domain/repositories/comment_repository.dart';

class CreateCommentUsecase
    implements UseCase<CommentEntity, UserCreateCommentParams> {
  CommentRepository commentRepository;
  CreateCommentUsecase({required this.commentRepository});

  @override
  Future<Either<Failure, CommentEntity>> call(
    UserCreateCommentParams params,
  ) async {
    try {
      final response = commentRepository.createComment(
        blogId: params.blogId,
        accessToken: params.accessToken,
        comment: params.comment,
      );
      return response;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}

class UserCreateCommentParams {
  final String blogId;
  final String accessToken;
  final String comment;
  UserCreateCommentParams({
    required this.blogId,
    required this.accessToken,
    required this.comment,
  });
}
