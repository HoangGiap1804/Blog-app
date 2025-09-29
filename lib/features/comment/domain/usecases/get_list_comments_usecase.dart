import 'package:fpdart/src/either.dart';
import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/core/usecases/usecase.dart';
import 'package:share_blog/features/comment/domain/entities/comment_entity.dart';
import 'package:share_blog/features/comment/domain/repositories/comment_repository.dart';

class GetListCommentsUsecase
    implements UseCase<List<CommentEntity>, UserGetListCommentParams> {
  final CommentRepository commentRepository;
  GetListCommentsUsecase({required this.commentRepository});

  @override
  Future<Either<Failure, List<CommentEntity>>> call(
    UserGetListCommentParams params,
  ) async {
    try {
      final response = commentRepository.getListCommentOfBlog(
        blogId: params.blogId,
        accessToken: params.accessToken,
      );
      return response;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}

class UserGetListCommentParams {
  final String blogId;
  final String accessToken;
  UserGetListCommentParams({required this.blogId, required this.accessToken});
}
