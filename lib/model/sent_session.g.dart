// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sent_session.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SentSessionAdapter extends TypeAdapter<SentSession> {
  @override
  final int typeId = 1;

  @override
  SentSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SentSession(
      sessionId: fields[0] as int,
      type: fields[1] as Provider,
      createdAt: fields[3] as DateTime,
      imagePath: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SentSession obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.sessionId)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SentSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
