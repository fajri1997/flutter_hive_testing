// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CreditCardInfoAdapter extends TypeAdapter<CreditCardInfo> {
  @override
  final int typeId = 1;

  @override
  CreditCardInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CreditCardInfo(
      cardNumber: fields[0] as String,
      expiryDate: fields[1] as String,
      cardHolderName: fields[2] as String,
      cvvCode: fields[3] as String,
      transactionHistory: (fields[4] as List).cast<History>(),
    );
  }

  @override
  void write(BinaryWriter writer, CreditCardInfo obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.cardNumber)
      ..writeByte(1)
      ..write(obj.expiryDate)
      ..writeByte(2)
      ..write(obj.cardHolderName)
      ..writeByte(3)
      ..write(obj.cvvCode)
      ..writeByte(4)
      ..write(obj.transactionHistory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreditCardInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
