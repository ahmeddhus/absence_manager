import 'package:hive/hive.dart';

part 'member_cache_model.g.dart';

@HiveType(typeId: 1)
class MemberCacheModel extends HiveObject {
  @HiveField(0)
  int? userId;

  @HiveField(1)
  String name;

  @HiveField(2)
  String imageUrl;

  MemberCacheModel({required this.userId, required this.name, required this.imageUrl});
}
