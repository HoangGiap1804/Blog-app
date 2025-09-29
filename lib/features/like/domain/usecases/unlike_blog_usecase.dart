import 'package:fpdart/src/either.dart';
import 'package:get/get.dart';
import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/core/usecases/usecase.dart';
import 'package:share_blog/features/like/domain/repositories/like_repository.dart';

class UnlikeBlogUsecase implements UseCase<bool, UserUnlikeBlogParams> {
  final LikeRepository likeRepository;

  UnlikeBlogUsecase({required this.likeRepository});

  @override
  Future<Either<Failure, bool>> call(UserUnlikeBlogParams params) async {
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

class UserUnlikeBlogParams {
  final String blogId;
  final String accessToken;
  UserUnlikeBlogParams({required this.blogId, required this.accessToken});
}
