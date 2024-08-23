// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_post_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetAllPostModelAdapter extends TypeAdapter<GetAllPostModel> {
  @override
  final int typeId = 3;

  @override
  GetAllPostModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetAllPostModel(
      posts: (fields[0] as List?)?.cast<PostModel>(),
      total: fields[1] as int?,
      skip: fields[2] as int?,
      limit: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, GetAllPostModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.posts)
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
      other is GetAllPostModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
