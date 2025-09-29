import 'package:fpdart/fpdart.dart';
import 'package:share_blog/core/error/failure.dart';

abstract interface class LikeRepository {
  Future<Either<Failure, bool>> likeRespository({
    required String blogId,
    required String accessToken,
  });

  Future<Either<Failure, bool>> unLikeRespository({
    required String blogId,
    required String accessToken,
  });
}
