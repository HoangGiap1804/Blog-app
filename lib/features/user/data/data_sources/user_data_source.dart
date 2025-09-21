import 'package:share_blog/features/user/data/models/user_response_model.dart';

abstract interface class UserDataSource {
  Future<UserResponseModel> getCurrentUserProfile(String accessToken);
}
