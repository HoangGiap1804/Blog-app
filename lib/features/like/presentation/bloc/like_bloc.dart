import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_blog/features/like/domain/usecases/like_blog_usecase.dart';
import 'package:share_blog/features/like/domain/usecases/unlike_blog_usecase.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final LikeBlogUsecase _likeBlogUsecase;
  final UnlikeBlogUsecase _unlikeBlogUsecase;

  LikeBloc({
    required LikeBlogUsecase likeBlogUsecase,
    required UnlikeBlogUsecase unlikeBlogUsecase,
  }) : _likeBlogUsecase = likeBlogUsecase,
       _unlikeBlogUsecase = unlikeBlogUsecase,
       super(LikeInitial()) {
    on<LikeBlogEvent>((event, emit) async {
      emit(LikeLoadingState());

      final response = await _likeBlogUsecase.call(event.userLikeBlogParams);

      response.fold(
        (failure) => emit(LikeBlogFailureState(message: failure.message)),
        (success) => emit(LikeBlogSuccessState()),
      );
    });

    on<UnlikeBlogEvent>((event, emit) async {
      emit(LikeLoadingState());

      final response = await _unlikeBlogUsecase.call(
        event.userUnlikeBlogParams,
      );

      response.fold(
        (failure) => emit(UnlikeBlogFailureState(message: failure.message)),
        (success) => emit(UnlikeBlogSuccessState()),
      );
    });
  }
}
