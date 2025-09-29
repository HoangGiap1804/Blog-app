import 'package:retrofit/retrofit.dart';

abstract interface class LikeDataSource {
  Future<HttpResponse<void>> likeBlog(String blogId, String accessToken);
  Future<HttpResponse<void>> unLikeBlog(String blogId, String accessToken);
}
