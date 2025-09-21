// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_links_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialLinksModel _$SocialLinksModelFromJson(Map<String, dynamic> json) =>
    SocialLinksModel(
      website: json['website'] as String?,
      facebook: json['facebook'] as String?,
      instagram: json['instagram'] as String?,
      x: json['x'] as String?,
      youtube: json['youtube'] as String?,
    );

Map<String, dynamic> _$SocialLinksModelToJson(SocialLinksModel instance) =>
    <String, dynamic>{
      'website': instance.website,
      'facebook': instance.facebook,
      'instagram': instance.instagram,
      'x': instance.x,
      'youtube': instance.youtube,
    };
