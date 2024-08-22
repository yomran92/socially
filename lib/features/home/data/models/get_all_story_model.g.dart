// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_story_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetAllStoryModelAdapter extends TypeAdapter<GetAllStoryModel> {
  @override
  final int typeId = 1;

  @override
  GetAllStoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetAllStoryModel(
      storys: (fields[0] as List?)?.cast<StoryModel>(),
      total: fields[1] as int?,
      skip: fields[2] as int?,
      limit: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, GetAllStoryModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.storys)
      ..writeByte(1)
      ..write(obj.total)
      ..writeByte(2)
      ..write(obj.skip)
      ..writeByte(3)
      ..write(obj.limit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetAllStoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
