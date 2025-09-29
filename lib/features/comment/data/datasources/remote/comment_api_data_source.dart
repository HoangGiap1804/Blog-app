import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:share_blog/features/comment/data/datasources/comment_data_source.dart';
import 'package:share_blog/features/comment/data/models/comment_response.dart';
import 'package:share_blog/features/comment/data/models/list_comment_response.dart';

part 'comment_api_data_source.g.dart';

@RestApi(
  baseUrl: "http://192.168.1.176:12000/api/v1/",
  parser: Parser.JsonSerializable,
)
abstract class CommentApiDataSource implements CommentDataSource {
  factory CommentApiDataSource(Dio dio) = _CommentApiDataSource;

  @override
  @POST('/comments/blog/{blogId}')
  Future<CommentResponse> createComment(
    @Path("blogId") String blogId,
    @Header("Authorization") String accessToken,
    @Body() Map<String, dynamic> body,
  );

  @override
  @GET('/comments/blog/{blogId}')
  Future<ListCommentResponse> getListCommentOfBlog(
    @Path("blogId") String blogId,
    @Header("Authorization") String accessToken,
  );

  @override
  @DELETE('/comments/{commentId}')
  Future<HttpResponse<void>> deleteComment(
    @Path("commentId") String commentId,
    @Header("Authorization") String accessToken,
  );
}
