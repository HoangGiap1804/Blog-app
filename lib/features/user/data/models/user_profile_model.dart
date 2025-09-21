import 'package:share_blog/features/user/data/models/social_links_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel {
  @JsonKey(name: "_id")
  final String id;
  final String username;
  final String email;
  final String role;
  final String createdAt;
  final String updatedAt;
  final String? firstName;
  final String? lastName;

  @JsonKey(name: "socialLinks")
  final SocialLinksModel? socialLinksModel;

  UserProfileModel({
    required this.id,
    required this.username,
    required this.role,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    this.firstName,
    this.lastName,
    this.socialLinksModel,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}
