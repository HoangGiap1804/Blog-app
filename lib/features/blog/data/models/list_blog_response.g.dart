// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_blog_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListBlogResponse _$ListBlogResponseFromJson(Map<String, dynamic> json) =>
    ListBlogResponse(
      limit: (json['limit'] as num?)?.toInt() ?? 0,
      offset: (json['offset'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
      listBlog: (json['blogResponse'] as List<dynamic>?)
              ?.map((e) => BlogModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ListBlogResponseToJson(ListBlogResponse instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
      'blogResponse': instance.listBlog,
    };
