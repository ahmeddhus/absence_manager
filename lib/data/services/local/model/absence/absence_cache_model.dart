import 'package:hive/hive.dart';

part 'absence_cache_model.g.dart';

@HiveType(typeId: 0)
class AbsenceCacheModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? userId;

  @HiveField(2)
  String? type;

  @HiveField(3)
  String? startDate;

  @HiveField(4)
  String? endDate;

  @HiveField(5)
  String? memberNote;

  @HiveField(6)
  String? admitterNote;

  @HiveField(7)
  String? status;

  AbsenceCacheModel();
}
