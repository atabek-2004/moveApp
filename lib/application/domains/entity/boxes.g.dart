// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boxes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BoxesAdapter extends TypeAdapter<Boxes> {
  @override
  final int typeId = 1;

  @override
  Boxes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Boxes(
      title: fields[0] as String,
      dimensions: fields[1] as String,
      weight: fields[3] as String,
      comment: fields[4] as String?,
      thingTitle: (fields[5] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Boxes obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.dimensions)
      ..writeByte(3)
      ..write(obj.weight)
      ..writeByte(4)
      ..write(obj.comment)
      ..writeByte(5)
      ..write(obj.thingTitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoxesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
