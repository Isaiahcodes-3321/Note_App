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

@HiveType(typeId: 1)
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

