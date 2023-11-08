// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokenStorageAdapter extends TypeAdapter<TokenStorage> {
  @override
  final int typeId = 0;

  @override
  TokenStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    String? getToken(dynamic value) {
      if (value is String) {
        return value;
      }
      return null; 
    }

    return TokenStorage(
      myToken: getToken(fields[0]) ?? "", 
       myRefreshToken: getToken(fields[1]) ?? "", 
        );
  }

  @override
  void write(BinaryWriter writer, TokenStorage obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.myToken)
      ..writeByte(1)
      ..write(obj.myRefreshToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}