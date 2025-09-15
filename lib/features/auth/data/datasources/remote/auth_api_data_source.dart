import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:share_blog/features/auth/data/datasources/auth_data_source.dart';
import 'package:share_blog/features/auth/data/models/auth_response_model.dart';

part 'auth_api_data_source.g.dart';

@RestApi(
  baseUrl: "http://192.168.1.176:12000/api/v1/",
  parser: Parser.JsonSerializable,
)
abstract class AuthApiDataSource implements AuthDataSource {
  factory AuthApiDataSource(Dio dio) = _AuthApiDataSource;

  @override
  @POST('/auth/register')
  Future<AuthResponseModel> signUpWithEmail(@Body() Map<String, dynamic> body);

  @override
  @POST('/auth/login')
  Future<AuthResponseModel> login(@Body() Map<String, dynamic> body);

  @override
  @POST('/auth/refresh-token')
  Future<AuthResponseModel> refreshToken(@Body() Map<String, dynamic> body);

  @override
  @POST('/auth/logout')
  Future<HttpResponse> logout(@Header("Authorization") String token);
}
