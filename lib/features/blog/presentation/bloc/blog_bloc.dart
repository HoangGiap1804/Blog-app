import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:share_blog/features/blog/domain/usecases/create_blog_usecase.dart';
import 'package:share_blog/features/blog/domain/usecases/get_blog_by_slug_usecase.dart';
import 'package:share_blog/features/blog/domain/usecases/get_list_blog_usecase.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final CreateBlogUsecase _createBlogUsecase;
  final GetBlogBySlugUsecase _getBlogBySlugUsecase;
  final GetListBlogUsecase _getListBlogUsecase;

  BlogBloc({
    required CreateBlogUsecase createBlogUsecase,
    required GetBlogBySlugUsecase getBlogBySlugUsecase,
    required GetListBlogUsecase getListBlogUsecase,
  }) : _createBlogUsecase = createBlogUsecase,
       _getBlogBySlugUsecase = getBlogBySlugUsecase,
       _getListBlogUsecase = getListBlogUsecase,
       super(BlogInitial()) {
    on<CreateBlogEvent>((event, emit) async {
      emit(BlogLoading());

      final res = await _createBlogUsecase.call(event.userCreateBlogParams);

      res.fold(
        (failure) => emit(BlogFailure(message: failure.message)),
        (success) => emit(BlogSuccess(blogEntity: success)),
      );
    });

    on<GetBlogBySlugEvent>((event, emit) async {
      emit(BlogLoading());

      final res = await _getBlogBySlugUsecase.call(
        event.userGetBlogBySlugParams,
      );

      res.fold(
        (failure) => emit(GetBlogFailure(message: failure.message)),
        (success) => emit(GetBlogSuccess(blogEntity: success)),
      );
    });

    on<GetListBlogEvent>((event, emit) async {
      emit(BlogLoading());

      final res = await _getListBlogUsecase.call(event.userGetListBlogPramas);

      res.fold(
        (failure) => emit(GetListBlogFailure(message: failure.message)),
        (success) => emit(GetListBlogSuccess(listBlogEntity: success)),
      );
    });
  }
}
