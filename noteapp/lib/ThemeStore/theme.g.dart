// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemecheckAdapter extends TypeAdapter<Theme_check> {
  @override
  final int typeId = 0;

  @override
  Theme_check read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Theme_check(
      theme: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Theme_check obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.theme);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemecheckAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
