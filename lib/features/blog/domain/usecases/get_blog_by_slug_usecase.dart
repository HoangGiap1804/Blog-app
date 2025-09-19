import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/core/usecases/usecase.dart';
import 'package:share_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:share_blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class GetBlogBySlugUsecase
    implements UseCase<BlogEntity, UserGetBlogBySlugParams> {
  final BlogRepository blogRepository;
  GetBlogBySlugUsecase({required this.blogRepository});

  @override
  Future<Either<Failure, BlogEntity>> call(
    UserGetBlogBySlugParams params,
  ) async {
    try {
      final res = await blogRepository.getBlogBySlug(
        slug: params.slug,
        accessToken: params.accessToken,
      );

      return res;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}

class UserGetBlogBySlugParams {
  final String slug;
  final String accessToken;
  UserGetBlogBySlugParams({required this.slug, required this.accessToken});
}
