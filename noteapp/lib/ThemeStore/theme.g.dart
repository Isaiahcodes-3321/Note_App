// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemecheckAdapter extends TypeAdapter<ThemeCheck> {
  @override
  final int typeId = 0;

  @override
  ThemeCheck read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ThemeCheck(
      theme_data: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ThemeCheck obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.theme_data);
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
