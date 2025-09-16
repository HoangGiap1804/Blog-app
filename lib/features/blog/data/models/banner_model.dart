import 'package:json_annotation/json_annotation.dart';

part "banner_model.g.dart";

@JsonSerializable()
class BannerModel {
  final String? url;
  final int? width;
  final int? height;

  BannerModel({this.url, this.width, this.height});

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
