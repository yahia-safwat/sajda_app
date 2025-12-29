// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_prayer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyPrayerModelAdapter extends TypeAdapter<DailyPrayerModel> {
  @override
  final int typeId = 0;

  @override
  DailyPrayerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyPrayerModel(
      date: fields[0] as DateTime,
      prayersMap: (fields[1] as Map).cast<String, bool>(),
    );
  }

  @override
  void write(BinaryWriter writer, DailyPrayerModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.prayersMap);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyPrayerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
