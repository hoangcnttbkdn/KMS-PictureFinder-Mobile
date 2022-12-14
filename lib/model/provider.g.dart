// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProviderAdapter extends TypeAdapter<Provider> {
  @override
  final int typeId = 2;

  @override
  Provider read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Provider.drive;
      case 1:
        return Provider.facebook;
      default:
        return Provider.drive;
    }
  }

  @override
  void write(BinaryWriter writer, Provider obj) {
    switch (obj) {
      case Provider.drive:
        writer.writeByte(0);
        break;
      case Provider.facebook:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProviderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
