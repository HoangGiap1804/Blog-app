import 'package:fpdart/src/either.dart';
import 'package:get/get.dart';
import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/core/usecases/usecase.dart';
import 'package:share_blog/features/like/domain/repositories/like_repository.dart';

class LikeBlogUsecase implements UseCase<bool, UserLikeBlogParams> {
  final LikeRepository likeRepository;

  LikeBlogUsecase({required this.likeRepository});

  @override
  Future<Either<Failure, bool>> call(UserLikeBlogParams params) async {
    try {
      final response = await likeRepository.likeRespository(
        blogId: params.blogId,
        accessToken: params.accessToken,
      );

      return response;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}

class UserLikeBlogParams {
  final String blogId;
  final String accessToken;
  UserLikeBlogParams({required this.blogId, required this.accessToken});
}
