part of 'blog_bloc.dart';

sealed class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object> get props => [];
}

class CreateBlogEvent extends BlogEvent {
  final UserCreateBlogParams userCreateBlogParams;
  const CreateBlogEvent({required this.userCreateBlogParams});
}

class GetBlogBySlugEvent extends BlogEvent {
  final UserGetBlogBySlugParams userGetBlogBySlugParams;
  const GetBlogBySlugEvent({required this.userGetBlogBySlugParams});
}

class GetListBlogEvent extends BlogEvent {
  final UserGetListBlogPramas userGetListBlogPramas;
  const GetListBlogEvent({required this.userGetListBlogPramas});
}
