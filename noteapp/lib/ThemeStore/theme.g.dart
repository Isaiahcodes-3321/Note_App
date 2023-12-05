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
    return TokenStorage(
      myToken: fields[0] as String,
      myRefreshToken: fields[1] as String,
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

class UserNameAndEmailStorageAdapter
    extends TypeAdapter<UserNameAndEmailStorage> {
  @override
  final int typeId = 1;

  @override
  UserNameAndEmailStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserNameAndEmailStorage(
      userName: fields[0] as String,
      email: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserNameAndEmailStorage obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserNameAndEmailStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
