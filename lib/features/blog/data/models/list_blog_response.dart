import 'package:json_annotation/json_annotation.dart';
import 'package:share_blog/features/blog/data/models/blog_model.dart';

part "list_blog_response.g.dart";

@JsonSerializable()
class ListBlogResponse {
  @JsonKey(name: "limit", defaultValue: 0)
  final int limit;
  @JsonKey(name: "offset", defaultValue: 0)
  final int offset;
  @JsonKey(name: "total", defaultValue: 0)
  final int total;
  @JsonKey(name: "blogResponse", defaultValue: [])
  final List<BlogModel> listBlog;
  ListBlogResponse({
    required this.limit,
    required this.offset,
    required this.total,
    required this.listBlog,
  });

  factory ListBlogResponse.fromJson(Map<String, dynamic> json) =>
      _$ListBlogResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListBlogResponseToJson(this);
}
