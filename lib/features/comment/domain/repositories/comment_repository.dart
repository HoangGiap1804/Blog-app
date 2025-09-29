import 'package:fpdart/fpdart.dart';
import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/features/comment/domain/entities/comment_entity.dart';

abstract interface class CommentRepository {
  Future<Either<Failure, CommentEntity>> createComment({
    required String blogId,
    required String accessToken,
    required String comment,
  });

  Future<Either<Failure, List<CommentEntity>>> getListCommentOfBlog({
    required String blogId,
    required String accessToken,
  });

  Future<Either<Failure, bool>> deleteComment({
    required String commentId,
    required String accessToken,
  });
}
