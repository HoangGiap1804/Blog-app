import 'package:share_blog/features/blog/data/models/author_model.dart';
import 'package:share_blog/features/blog/data/models/banner_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:share_blog/features/blog/domain/entities/blog_entity.dart';

part 'blog_model.g.dart';

@JsonSerializable()
class BlogModel {
  @JsonKey(name: "_id", defaultValue: "")
  final String id;
  @JsonKey(name: "title", defaultValue: "")
  final String title;
  @JsonKey(name: "content", defaultValue: "")
  final String content;
  @JsonKey(name: "status", defaultValue: "")
  final String status;
  @JsonKey(name: "banner")
  final BannerModel? bannerModel;
  @JsonKey(name: "author")
  final AuthorModel? authorModel;
  final int? viewsCount;
  final int? likesCount;
  final int? commentCount;
  final String? slug;
  final String? publishedAt;
  final String? updateAt;
  BlogModel({
    required this.id,
    required this.title,
    required this.content,
    required this.status,
    this.authorModel,
    this.bannerModel,
    this.viewsCount,
    this.likesCount,
    this.commentCount,
    this.slug,
    this.publishedAt,
    this.updateAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) =>
      _$BlogModelFromJson(json);

  Map<String, dynamic> toJson() => _$BlogModelToJson(this);

  BlogEntity toEntity() {
    AuthorModel? authorModel = this.authorModel;
    BannerModel? bannerModel = this.bannerModel;

    BlogEntity blogEntity = BlogEntity(
      id: id,
      title: title,
      content: content,
      status: status,
      bannerUrl: (bannerModel != null) ? bannerModel.url : "",
      width: (bannerModel != null) ? bannerModel.width : 0,
      height: (bannerModel != null) ? bannerModel.height : 0,
      idAuth: (authorModel != null) ? authorModel.authorId : "",
      userName: (authorModel != null) ? authorModel.authorId : "",
      viewsCount: viewsCount,
      likesCount: likesCount,
      commentCount: commentCount,
      slug: slug,
      publishedAt: publishedAt,
      updateAt: updateAt,
    );

    return blogEntity;
  }
}
