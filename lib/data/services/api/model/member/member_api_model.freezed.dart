// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'member_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MemberApiModel {

 int? get id; String? get name; String? get image; int? get userId; int? get crewId;
/// Create a copy of MemberApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemberApiModelCopyWith<MemberApiModel> get copyWith => _$MemberApiModelCopyWithImpl<MemberApiModel>(this as MemberApiModel, _$identity);

  /// Serializes this MemberApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MemberApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.crewId, crewId) || other.crewId == crewId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,image,userId,crewId);

@override
String toString() {
  return 'MemberApiModel(id: $id, name: $name, image: $image, userId: $userId, crewId: $crewId)';
}


}

/// @nodoc
abstract mixin class $MemberApiModelCopyWith<$Res>  {
  factory $MemberApiModelCopyWith(MemberApiModel value, $Res Function(MemberApiModel) _then) = _$MemberApiModelCopyWithImpl;
@useResult
$Res call({
 int? id, String? name, String? image, int? userId, int? crewId
});




}
/// @nodoc
class _$MemberApiModelCopyWithImpl<$Res>
    implements $MemberApiModelCopyWith<$Res> {
  _$MemberApiModelCopyWithImpl(this._self, this._then);

  final MemberApiModel _self;
  final $Res Function(MemberApiModel) _then;

/// Create a copy of MemberApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? image = freezed,Object? userId = freezed,Object? crewId = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,crewId: freezed == crewId ? _self.crewId : crewId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MemberApiModel implements MemberApiModel {
   _MemberApiModel({this.id, this.name, this.image, this.userId, this.crewId});
  factory _MemberApiModel.fromJson(Map<String, dynamic> json) => _$MemberApiModelFromJson(json);

@override final  int? id;
@override final  String? name;
@override final  String? image;
@override final  int? userId;
@override final  int? crewId;

/// Create a copy of MemberApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemberApiModelCopyWith<_MemberApiModel> get copyWith => __$MemberApiModelCopyWithImpl<_MemberApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemberApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MemberApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.crewId, crewId) || other.crewId == crewId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,image,userId,crewId);

@override
String toString() {
  return 'MemberApiModel(id: $id, name: $name, image: $image, userId: $userId, crewId: $crewId)';
}


}

/// @nodoc
abstract mixin class _$MemberApiModelCopyWith<$Res> implements $MemberApiModelCopyWith<$Res> {
  factory _$MemberApiModelCopyWith(_MemberApiModel value, $Res Function(_MemberApiModel) _then) = __$MemberApiModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? name, String? image, int? userId, int? crewId
});




}
/// @nodoc
class __$MemberApiModelCopyWithImpl<$Res>
    implements _$MemberApiModelCopyWith<$Res> {
  __$MemberApiModelCopyWithImpl(this._self, this._then);

  final _MemberApiModel _self;
  final $Res Function(_MemberApiModel) _then;

/// Create a copy of MemberApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? image = freezed,Object? userId = freezed,Object? crewId = freezed,}) {
  return _then(_MemberApiModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,crewId: freezed == crewId ? _self.crewId : crewId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
