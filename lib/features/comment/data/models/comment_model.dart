import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  @JsonKey(name: "_id", defaultValue: "")
  final String commentId;
  @JsonKey(name: "blogId", defaultValue: "")
  final String blogId;
  @JsonKey(name: "userId", defaultValue: "")
  final String userId;
  @JsonKey(name: "comment", defaultValue: "")
  final String commnent;
  CommentModel({
    required this.commentId,
    required this.blogId,
    required this.userId,
    required this.commnent,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
