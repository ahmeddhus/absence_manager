// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'absence_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AbsenceApiModel {

 int? get id; int? get userId; String? get type; String? get startDate; String? get endDate; String? get memberNote; String? get admitterNote; String? get status; int? get admitterId; String? get confirmedAt; String? get createdAt; String? get rejectedAt; int? get crewId;
/// Create a copy of AbsenceApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AbsenceApiModelCopyWith<AbsenceApiModel> get copyWith => _$AbsenceApiModelCopyWithImpl<AbsenceApiModel>(this as AbsenceApiModel, _$identity);

  /// Serializes this AbsenceApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AbsenceApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.memberNote, memberNote) || other.memberNote == memberNote)&&(identical(other.admitterNote, admitterNote) || other.admitterNote == admitterNote)&&(identical(other.status, status) || other.status == status)&&(identical(other.admitterId, admitterId) || other.admitterId == admitterId)&&(identical(other.confirmedAt, confirmedAt) || other.confirmedAt == confirmedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.rejectedAt, rejectedAt) || other.rejectedAt == rejectedAt)&&(identical(other.crewId, crewId) || other.crewId == crewId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,type,startDate,endDate,memberNote,admitterNote,status,admitterId,confirmedAt,createdAt,rejectedAt,crewId);

@override
String toString() {
  return 'AbsenceApiModel(id: $id, userId: $userId, type: $type, startDate: $startDate, endDate: $endDate, memberNote: $memberNote, admitterNote: $admitterNote, status: $status, admitterId: $admitterId, confirmedAt: $confirmedAt, createdAt: $createdAt, rejectedAt: $rejectedAt, crewId: $crewId)';
}


}

/// @nodoc
abstract mixin class $AbsenceApiModelCopyWith<$Res>  {
  factory $AbsenceApiModelCopyWith(AbsenceApiModel value, $Res Function(AbsenceApiModel) _then) = _$AbsenceApiModelCopyWithImpl;
@useResult
$Res call({
 int? id, int? userId, String? type, String? startDate, String? endDate, String? memberNote, String? admitterNote, String? status, int? admitterId, String? confirmedAt, String? createdAt, String? rejectedAt, int? crewId
});




}
/// @nodoc
class _$AbsenceApiModelCopyWithImpl<$Res>
    implements $AbsenceApiModelCopyWith<$Res> {
  _$AbsenceApiModelCopyWithImpl(this._self, this._then);

  final AbsenceApiModel _self;
  final $Res Function(AbsenceApiModel) _then;

/// Create a copy of AbsenceApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = freezed,Object? type = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? memberNote = freezed,Object? admitterNote = freezed,Object? status = freezed,Object? admitterId = freezed,Object? confirmedAt = freezed,Object? createdAt = freezed,Object? rejectedAt = freezed,Object? crewId = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,memberNote: freezed == memberNote ? _self.memberNote : memberNote // ignore: cast_nullable_to_non_nullable
as String?,admitterNote: freezed == admitterNote ? _self.admitterNote : admitterNote // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,admitterId: freezed == admitterId ? _self.admitterId : admitterId // ignore: cast_nullable_to_non_nullable
as int?,confirmedAt: freezed == confirmedAt ? _self.confirmedAt : confirmedAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,rejectedAt: freezed == rejectedAt ? _self.rejectedAt : rejectedAt // ignore: cast_nullable_to_non_nullable
as String?,crewId: freezed == crewId ? _self.crewId : crewId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AbsenceApiModel implements AbsenceApiModel {
   _AbsenceApiModel({this.id, this.userId, this.type, this.startDate, this.endDate, this.memberNote, this.admitterNote, this.status, this.admitterId, this.confirmedAt, this.createdAt, this.rejectedAt, this.crewId});
  factory _AbsenceApiModel.fromJson(Map<String, dynamic> json) => _$AbsenceApiModelFromJson(json);

@override final  int? id;
@override final  int? userId;
@override final  String? type;
@override final  String? startDate;
@override final  String? endDate;
@override final  String? memberNote;
@override final  String? admitterNote;
@override final  String? status;
@override final  int? admitterId;
@override final  String? confirmedAt;
@override final  String? createdAt;
@override final  String? rejectedAt;
@override final  int? crewId;

/// Create a copy of AbsenceApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AbsenceApiModelCopyWith<_AbsenceApiModel> get copyWith => __$AbsenceApiModelCopyWithImpl<_AbsenceApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AbsenceApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AbsenceApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.memberNote, memberNote) || other.memberNote == memberNote)&&(identical(other.admitterNote, admitterNote) || other.admitterNote == admitterNote)&&(identical(other.status, status) || other.status == status)&&(identical(other.admitterId, admitterId) || other.admitterId == admitterId)&&(identical(other.confirmedAt, confirmedAt) || other.confirmedAt == confirmedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.rejectedAt, rejectedAt) || other.rejectedAt == rejectedAt)&&(identical(other.crewId, crewId) || other.crewId == crewId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,type,startDate,endDate,memberNote,admitterNote,status,admitterId,confirmedAt,createdAt,rejectedAt,crewId);

@override
String toString() {
  return 'AbsenceApiModel(id: $id, userId: $userId, type: $type, startDate: $startDate, endDate: $endDate, memberNote: $memberNote, admitterNote: $admitterNote, status: $status, admitterId: $admitterId, confirmedAt: $confirmedAt, createdAt: $createdAt, rejectedAt: $rejectedAt, crewId: $crewId)';
}


}

/// @nodoc
abstract mixin class _$AbsenceApiModelCopyWith<$Res> implements $AbsenceApiModelCopyWith<$Res> {
  factory _$AbsenceApiModelCopyWith(_AbsenceApiModel value, $Res Function(_AbsenceApiModel) _then) = __$AbsenceApiModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, int? userId, String? type, String? startDate, String? endDate, String? memberNote, String? admitterNote, String? status, int? admitterId, String? confirmedAt, String? createdAt, String? rejectedAt, int? crewId
});




}
/// @nodoc
class __$AbsenceApiModelCopyWithImpl<$Res>
    implements _$AbsenceApiModelCopyWith<$Res> {
  __$AbsenceApiModelCopyWithImpl(this._self, this._then);

  final _AbsenceApiModel _self;
  final $Res Function(_AbsenceApiModel) _then;

/// Create a copy of AbsenceApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = freezed,Object? type = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? memberNote = freezed,Object? admitterNote = freezed,Object? status = freezed,Object? admitterId = freezed,Object? confirmedAt = freezed,Object? createdAt = freezed,Object? rejectedAt = freezed,Object? crewId = freezed,}) {
  return _then(_AbsenceApiModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,memberNote: freezed == memberNote ? _self.memberNote : memberNote // ignore: cast_nullable_to_non_nullable
as String?,admitterNote: freezed == admitterNote ? _self.admitterNote : admitterNote // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,admitterId: freezed == admitterId ? _self.admitterId : admitterId // ignore: cast_nullable_to_non_nullable
as int?,confirmedAt: freezed == confirmedAt ? _self.confirmedAt : confirmedAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,rejectedAt: freezed == rejectedAt ? _self.rejectedAt : rejectedAt // ignore: cast_nullable_to_non_nullable
as String?,crewId: freezed == crewId ? _self.crewId : crewId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
