// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      id: json['_id'] as String,
      username: json['username'] as String,
      role: json['role'] as String,
      email: json['email'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      socialLinksModel: json['socialLinks'] == null
          ? null
          : SocialLinksModel.fromJson(
              json['socialLinks'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'role': instance.role,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'socialLinks': instance.socialLinksModel,
    };
