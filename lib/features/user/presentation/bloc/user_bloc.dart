import 'package:bloc/bloc.dart';
import 'package:share_blog/features/user/domain/enitities/user_profile_entity.dart';
import 'package:share_blog/features/user/domain/usecases/get_current_user_usecase.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCurrentUserUsecase _getCurrentUserUsecase;

  UserBloc({required GetCurrentUserUsecase getCurrentUserUsecase})
    : _getCurrentUserUsecase = getCurrentUserUsecase,
      super(UserInitial()) {
    on<GetCurrentProfileEvent>((event, emit) async {
      emit(UserLoading());

      final res = await _getCurrentUserUsecase.call(
        UserTokenParam(accessToken: event.accessToken),
      );

      res.fold(
        (failure) {
          emit(UserFaile(failure: failure.message));
        },
        (success) {
          emit(UserSucessfuly(userProfileEntity: success));
        },
      );
    });
  }
}
