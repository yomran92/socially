// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReactionsModelAdapter extends TypeAdapter<ReactionsModel> {
  @override
  final int typeId = 5;

  @override
  ReactionsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReactionsModel(
      likes: fields[0] as int?,
      dislikes: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ReactionsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.likes)
      ..writeByte(1)
      ..write(obj.dislikes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReactionsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
