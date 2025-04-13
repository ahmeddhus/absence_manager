// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence_cache_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AbsenceCacheModelAdapter extends TypeAdapter<AbsenceCacheModel> {
  @override
  final int typeId = 0;

  @override
  AbsenceCacheModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AbsenceCacheModel()
      ..id = fields[0] as int?
      ..userId = fields[1] as int?
      ..type = fields[2] as String?
      ..startDate = fields[3] as String?
      ..endDate = fields[4] as String?
      ..memberNote = fields[5] as String?
      ..admitterNote = fields[6] as String?
      ..status = fields[7] as String?;
  }

  @override
  void write(BinaryWriter writer, AbsenceCacheModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate)
      ..writeByte(5)
      ..write(obj.memberNote)
      ..writeByte(6)
      ..write(obj.admitterNote)
      ..writeByte(7)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AbsenceCacheModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
