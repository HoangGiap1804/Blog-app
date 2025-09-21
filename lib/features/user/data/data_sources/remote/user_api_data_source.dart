import 'package:share_blog/features/user/data/data_sources/user_data_source.dart';
import 'package:share_blog/features/user/data/models/user_response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api_data_source.g.dart';

@RestApi(
  baseUrl: "http://192.168.1.176:12000/api/v1/",
  parser: Parser.JsonSerializable,
)
abstract class UserApiDataSource implements UserDataSource {
  factory UserApiDataSource(Dio dio) = _UserApiDataSource;

  @override
  @GET('/users/current')
  Future<UserResponseModel> getCurrentUserProfile(
    @Header("Authorization") String accessToken,
  );
}
