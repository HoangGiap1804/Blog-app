import 'package:retrofit/retrofit.dart';
import 'package:share_blog/features/auth/data/models/auth_response_model.dart';

abstract interface class AuthDataSource {
  Future<AuthResponseModel> signUpWithEmail(Map<String, dynamic> body);
  Future<AuthResponseModel> login(Map<String, dynamic> body);
  Future<AuthResponseModel> refreshToken(Map<String, dynamic> body);
  Future<HttpResponse> logout(String token);
}
