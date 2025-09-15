import 'package:json_annotation/json_annotation.dart';
import 'package:share_blog/features/auth/data/models/auth_model.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponseModel {
  final AuthModel? user;
  final String? accessToken;
  final String? refreshToken;

  AuthResponseModel({required this.user, this.accessToken, this.refreshToken});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);
}
