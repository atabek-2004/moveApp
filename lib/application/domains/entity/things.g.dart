// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'things.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThingsAdapter extends TypeAdapter<Things> {
  @override
  final int typeId = 0;

  @override
  Things read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Things(
      title: fields[0] as String,
      description: fields[1] as String,
      size: fields[2] as String,
      weight: fields[3] as String,
      comment: fields[4] as String?,
      checked: fields[5] as bool? ?? false,
    );
  }

  @override
  void write(BinaryWriter writer, Things obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.size)
      ..writeByte(3)
      ..write(obj.weight)
      ..writeByte(4)
      ..write(obj.comment)
      ..writeByte(5)
      ..write(obj.checked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
