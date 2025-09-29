import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:share_blog/features/like/data/sources/like_data_source.dart';

part 'like_api_data_source.g.dart';

@RestApi(
  baseUrl: "http://192.168.1.176:12000/api/v1/",
  parser: Parser.JsonSerializable,
)
abstract class LikeApiDataSource implements LikeDataSource {
  factory LikeApiDataSource(Dio dio) = _LikeApiDataSource;

  @override
  @POST("/likes/blog/{blogId}")
  Future<HttpResponse<void>> likeBlog(
    @Path("blogId") String blogId,
    @Header("Authorization") String accessToken,
  );

  @override
  @DELETE("/likes/blog/{blogId}")
  Future<HttpResponse<void>> unLikeBlog(
    @Path("blogId") String blogId,
    @Header("Authorization") String accessToken,
  );
}
