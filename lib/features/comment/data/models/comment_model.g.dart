// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      commentId: json['_id'] as String? ?? '',
      blogId: json['blogId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      commnent: json['comment'] as String? ?? '',
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      '_id': instance.commentId,
      'blogId': instance.blogId,
      'userId': instance.userId,
      'comment': instance.commnent,
    };
