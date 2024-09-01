// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final int typeId = 1;

  @override
  Settings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Settings(
      id: fields[0] as String,
      queueCount: fields[1] as int,
      textSize: fields[3] as double,
      textWeight: fields[4] as double,
      verticalPadding: fields[5] as double,
      horizontalPadding: fields[6] as double,
      timeColumnHorizontalPadding: fields[7] as double,
      borderWidth: fields[8] as double,
      evenColumnOpacity: fields[9] as double,
      backgroundColor: fields[12] as String,
      enableColor: fields[13] as String,
      disableColor: fields[14] as String,
      unknownColor: fields[15] as String,
      borderColor: fields[16] as String,
      textColor: fields[17] as String,
      includeHeadersRow: fields[20] as bool,
      includeTotalRow: fields[21] as bool,
      showDate: fields[24] as bool,
      dateDaysOffset: fields[25] as int,
      dateTextSize: fields[26] as double,
      dateTextWeight: fields[27] as double,
      dateTextColor: fields[28] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.queueCount)
      ..writeByte(3)
      ..write(obj.textSize)
      ..writeByte(4)
      ..write(obj.textWeight)
      ..writeByte(5)
      ..write(obj.verticalPadding)
      ..writeByte(6)
      ..write(obj.horizontalPadding)
      ..writeByte(7)
      ..write(obj.timeColumnHorizontalPadding)
      ..writeByte(8)
      ..write(obj.borderWidth)
      ..writeByte(9)
      ..write(obj.evenColumnOpacity)
      ..writeByte(12)
      ..write(obj.backgroundColor)
      ..writeByte(13)
      ..write(obj.enableColor)
      ..writeByte(14)
      ..write(obj.disableColor)
      ..writeByte(15)
      ..write(obj.unknownColor)
      ..writeByte(16)
      ..write(obj.borderColor)
      ..writeByte(17)
      ..write(obj.textColor)
      ..writeByte(20)
      ..write(obj.includeHeadersRow)
      ..writeByte(21)
      ..write(obj.includeTotalRow)
      ..writeByte(24)
      ..write(obj.showDate)
      ..writeByte(25)
      ..write(obj.dateDaysOffset)
      ..writeByte(26)
      ..write(obj.dateTextSize)
      ..writeByte(27)
      ..write(obj.dateTextWeight)
      ..writeByte(28)
      ..write(obj.dateTextColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
