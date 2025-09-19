import 'package:json_annotation/json_annotation.dart';
import 'package:share_blog/features/blog/data/models/blog_model.dart';

part 'blog_response.g.dart';

@JsonSerializable()
class BlogResponse {
  @JsonKey(name: "blogResponse")
  final BlogModel? blogModel;
  BlogResponse({this.blogModel});

  factory BlogResponse.fromJson(Map<String, dynamic> json) =>
      _$BlogResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BlogResponseToJson(this);
}
