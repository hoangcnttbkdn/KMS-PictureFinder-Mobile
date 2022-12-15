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
      provider: fields[1] as Provider,
      data: fields[2] as String,
      createdAt: fields[3] as DateTime,
      findType: fields[4] as FindType,
    );
  }

  @override
  void write(BinaryWriter writer, SentSession obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.sessionId)
      ..writeByte(1)
      ..write(obj.provider)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.findType);
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
