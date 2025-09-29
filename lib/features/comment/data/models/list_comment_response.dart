import 'package:json_annotation/json_annotation.dart';
import 'package:share_blog/features/comment/data/models/comment_model.dart';

part 'list_comment_response.g.dart';

@JsonSerializable()
class ListCommentResponse {
  @JsonKey(name: "comments")
  final List<CommentModel> comments;
  ListCommentResponse({required this.comments});

  factory ListCommentResponse.fromJson(Map<String, dynamic> json) =>
      _$ListCommentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListCommentResponseToJson(this);
}
