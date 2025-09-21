import 'package:json_annotation/json_annotation.dart';

part 'social_links_model.g.dart';

@JsonSerializable()
class SocialLinksModel {
  final String? website;
  final String? facebook;
  final String? instagram;
  final String? x;
  final String? youtube;

  SocialLinksModel({
    this.website,
    this.facebook,
    this.instagram,
    this.x,
    this.youtube,
  });

  factory SocialLinksModel.fromJson(Map<String, dynamic> json) =>
      _$SocialLinksModelFromJson(json);

  Map<String, dynamic> toJson() => _$SocialLinksModelToJson(this);
}
