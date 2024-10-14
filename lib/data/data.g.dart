// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TradesAdapter extends TypeAdapter<Trades> {
  @override
  final int typeId = 1;

  @override
  Trades read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trades(
      stockName: fields[0] as String,
      buyPrice: fields[1] as double,
      sellPrice: fields[2] as double,
      qnty: fields[3] as int,
      date: fields[4] as DateTime,
      isBuy: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Trades obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.stockName)
      ..writeByte(1)
      ..write(obj.buyPrice)
      ..writeByte(2)
      ..write(obj.sellPrice)
      ..writeByte(3)
      ..write(obj.qnty)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.isBuy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TradesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
