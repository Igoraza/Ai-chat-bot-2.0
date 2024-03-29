// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatHistoryModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatHistoryModelAdapter extends TypeAdapter<ChatHistoryModel> {
  @override
  final int typeId = 2;

  @override
  ChatHistoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatHistoryModel(
      category: fields[0] as String,
      instance: fields[1] as int,
      lastMessageTime: fields[2] as String,
      lastMessage: fields[3] == null ? '' : fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ChatHistoryModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.instance)
      ..writeByte(2)
      ..write(obj.lastMessageTime)
      ..writeByte(3)
      ..write(obj.lastMessage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatHistoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
