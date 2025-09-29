import 'package:retrofit/dio.dart';
import 'package:share_blog/features/comment/data/models/comment_response.dart';
import 'package:share_blog/features/comment/data/models/list_comment_response.dart';

abstract interface class CommentDataSource {
  Future<CommentResponse> createComment(
    String blogId,
    String accessToken,
    Map<String, dynamic> body,
  );

  Future<ListCommentResponse> getListCommentOfBlog(
    String blogId,
    String accessToken,
  );

  Future<HttpResponse<void>> deleteComment(
    String commentId,
    String accessToken,
  );
}
