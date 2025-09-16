// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogModel _$BlogModelFromJson(Map<String, dynamic> json) => BlogModel(
      id: json['_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      status: json['status'] as String? ?? '',
      authorModel: json['author'] == null
          ? null
          : AuthorModel.fromJson(json['author'] as Map<String, dynamic>),
      bannerModel: json['banner'] == null
          ? null
          : BannerModel.fromJson(json['banner'] as Map<String, dynamic>),
      viewsCount: (json['viewsCount'] as num?)?.toInt(),
      likesCount: (json['likesCount'] as num?)?.toInt(),
      commentCount: (json['commentCount'] as num?)?.toInt(),
      slug: json['slug'] as String?,
      publishedAt: json['publishedAt'] as String?,
      updateAt: json['updateAt'] as String?,
    );

Map<String, dynamic> _$BlogModelToJson(BlogModel instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'status': instance.status,
      'banner': instance.bannerModel,
      'author': instance.authorModel,
      'viewsCount': instance.viewsCount,
      'likesCount': instance.likesCount,
      'commentCount': instance.commentCount,
      'slug': instance.slug,
      'publishedAt': instance.publishedAt,
      'updateAt': instance.updateAt,
    };
