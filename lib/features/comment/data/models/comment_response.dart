import 'package:json_annotation/json_annotation.dart';
import 'package:share_blog/features/comment/data/models/comment_model.dart';

part 'comment_response.g.dart';

@JsonSerializable()
class CommentResponse {
  @JsonKey(name: "comment")
  final CommentModel comment;
  CommentResponse({required this.comment});

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommentResponseToJson(this);
}
