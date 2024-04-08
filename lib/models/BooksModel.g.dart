// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BooksModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BooksModelAdapter extends TypeAdapter<BooksModel> {
  @override
  final int typeId = 0;

  @override
  BooksModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BooksModel(
      title: fields[0] as String,
      author: fields[1] as String,
      description: fields[2] as String,
      epubFilePath: fields[3] as String,
      imagePath: fields[4] as String,
      genre: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BooksModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.epubFilePath)
      ..writeByte(4)
      ..write(obj.imagePath)
      ..writeByte(5)
      ..write(obj.genre);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BooksModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
