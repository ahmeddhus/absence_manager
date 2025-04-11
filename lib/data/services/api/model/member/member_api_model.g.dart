// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MemberApiModel _$MemberApiModelFromJson(Map<String, dynamic> json) =>
    _MemberApiModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      image: json['image'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
      crewId: (json['crewId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MemberApiModelToJson(_MemberApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'userId': instance.userId,
      'crewId': instance.crewId,
    };
