// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogResponse _$BlogResponseFromJson(Map<String, dynamic> json) => BlogResponse(
      blogModel: json['blogResponse'] == null
          ? null
          : BlogModel.fromJson(json['blogResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BlogResponseToJson(BlogResponse instance) =>
    <String, dynamic>{
      'blogResponse': instance.blogModel,
    };
