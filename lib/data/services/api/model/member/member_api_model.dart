import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_api_model.freezed.dart';
part 'member_api_model.g.dart';

@freezed
abstract class MemberApiModel with _$MemberApiModel {
  factory MemberApiModel({int? id, String? name, String? image, int? userId, int? crewId}) =
      _MemberApiModel;

  factory MemberApiModel.fromJson(Map<String, dynamic> json) => _$MemberApiModelFromJson(json);
}
