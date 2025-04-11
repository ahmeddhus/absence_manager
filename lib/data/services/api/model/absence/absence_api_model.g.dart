// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AbsenceApiModel _$AbsenceApiModelFromJson(Map<String, dynamic> json) =>
    _AbsenceApiModel(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      type: json['type'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      memberNote: json['memberNote'] as String?,
      admitterNote: json['admitterNote'] as String?,
      status: json['status'] as String?,
      admitterId: (json['admitterId'] as num?)?.toInt(),
      confirmedAt: json['confirmedAt'] as String?,
      createdAt: json['createdAt'] as String?,
      rejectedAt: json['rejectedAt'] as String?,
      crewId: (json['crewId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AbsenceApiModelToJson(_AbsenceApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': instance.type,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'memberNote': instance.memberNote,
      'admitterNote': instance.admitterNote,
      'status': instance.status,
      'admitterId': instance.admitterId,
      'confirmedAt': instance.confirmedAt,
      'createdAt': instance.createdAt,
      'rejectedAt': instance.rejectedAt,
      'crewId': instance.crewId,
    };
