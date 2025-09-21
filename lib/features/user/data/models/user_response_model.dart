import 'package:share_blog/features/user/data/models/user_profile_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response_model.g.dart';

@JsonSerializable()
class UserResponseModel {
  final UserProfileModel user;

  UserResponseModel({required this.user});

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);
}
