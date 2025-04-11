import 'package:freezed_annotation/freezed_annotation.dart';

part 'absence_api_model.freezed.dart';
part 'absence_api_model.g.dart';

@freezed
abstract class AbsenceApiModel with _$AbsenceApiModel {
  factory AbsenceApiModel({
    int? id,
    int? userId,
    String? type,
    String? startDate,
    String? endDate,
    String? memberNote,
    String? admitterNote,
    String? status,
    int? admitterId,
    String? confirmedAt,
    String? createdAt,
    String? rejectedAt,
    int? crewId,
  }) = _AbsenceApiModel;

  factory AbsenceApiModel.fromJson(Map<String, dynamic> json) => _$AbsenceApiModelFromJson(json);
}
