// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FindTypeAdapter extends TypeAdapter<FindType> {
  @override
  final int typeId = 3;

  @override
  FindType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FindType.face;
      case 1:
        return FindType.bib;
      case 2:
        return FindType.clothes;
      default:
        return FindType.face;
    }
  }

  @override
  void write(BinaryWriter writer, FindType obj) {
    switch (obj) {
      case FindType.face:
        writer.writeByte(0);
        break;
      case FindType.bib:
        writer.writeByte(1);
        break;
      case FindType.clothes:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FindTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
