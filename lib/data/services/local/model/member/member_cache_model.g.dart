// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_cache_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemberCacheModelAdapter extends TypeAdapter<MemberCacheModel> {
  @override
  final int typeId = 1;

  @override
  MemberCacheModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemberCacheModel(
      userId: fields[0] as int?,
      name: fields[1] as String,
      imageUrl: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MemberCacheModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberCacheModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
