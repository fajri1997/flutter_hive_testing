// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_amount.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SendAmountAdapter extends TypeAdapter<SendAmount> {
  @override
  final int typeId = 4;

  @override
  SendAmount read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SendAmount(
      amount: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SendAmount obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SendAmountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
