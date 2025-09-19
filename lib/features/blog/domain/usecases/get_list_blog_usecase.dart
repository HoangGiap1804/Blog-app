import 'package:fpdart/src/either.dart';
import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/core/usecases/usecase.dart';
import 'package:share_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:share_blog/features/blog/domain/repositories/blog_repository.dart';

class GetListBlogUsecase
    implements UseCase<List<BlogEntity>, UserGetListBlogPramas> {
  final BlogRepository blogRepository;
  GetListBlogUsecase({required this.blogRepository});

  @override
  Future<Either<Failure, List<BlogEntity>>> call(
    UserGetListBlogPramas params,
  ) async {
    try {
      final res = await blogRepository.getListBlog(
        limit: params.limit,
        offset: params.offset,
        accessToken: params.accessToken,
      );

      return res;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}

class UserGetListBlogPramas {
  final int limit;
  final int offset;
  final String accessToken;
  UserGetListBlogPramas({
    required this.limit,
    required this.offset,
    required this.accessToken,
  });
}
