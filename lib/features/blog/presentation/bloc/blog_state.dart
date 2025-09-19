part of 'blog_bloc.dart';

sealed class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogSuccess extends BlogState {
  final BlogEntity blogEntity;
  const BlogSuccess({required this.blogEntity});
}

final class BlogFailure extends BlogState {
  final String message;
  const BlogFailure({required this.message});
}

final class GetBlogSuccess extends BlogState {
  final BlogEntity blogEntity;
  const GetBlogSuccess({required this.blogEntity});
}

final class GetBlogFailure extends BlogState {
  final String message;
  const GetBlogFailure({required this.message});
}

final class GetListBlogSuccess extends BlogState {
  final List<BlogEntity> listBlogEntity;
  const GetListBlogSuccess({required this.listBlogEntity});
}

final class GetListBlogFailure extends BlogState {
  final String message;
  const GetListBlogFailure({required this.message});
}
