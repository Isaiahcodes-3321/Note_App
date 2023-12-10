import 'package:hive/hive.dart';
part 'theme.g.dart';



@HiveType(typeId: 0)
class TokenStorage{
  TokenStorage({
    required this.myToken,
    required this.myRefreshToken,
  });

  @HiveField(0)
  String myToken;

  @HiveField(1)
  String myRefreshToken;
}

//  flutter packages pub run build_runner build

@HiveType(typeId: 0)
class UserNameAndEmailStorage{
  UserNameAndEmailStorage({
    required this.userName,
    required this.email,
  });

  @HiveField(0)
  String userName;

  @HiveField(1)
  String email;
}
















// class TokenStorageAdapter extends TypeAdapter<TokenStorage> {
//   @override
//   final int typeId = 0;

//   @override
//   TokenStorage read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return TokenStorage(
//       myToken: fields[0] as String,
//       myRefreshToken: fields[1] as String,
//     );
//   }

//   @override
//   void write(BinaryWriter writer, TokenStorage obj) {
//     writer
//       ..writeByte(2)
//       ..writeByte(0)
//       ..write(obj.myToken)
//       ..writeByte(1)
//       ..write(obj.myRefreshToken);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is TokenStorageAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }








