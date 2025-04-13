// This is a pure Dart model intended for the domain layer.
// We intentionally avoid using `freezed` or other code generators here
// to keep the domain layer decoupled from dependencies and tooling,
// as per clean architecture principles.

class Member {
  final int? userId;
  final String name;
  final String imageUrl;

  Member({required this.userId, required this.name, required this.imageUrl});
}
