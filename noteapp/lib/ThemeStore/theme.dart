import 'package:hive/hive.dart';
part 'theme.g.dart';


// Storage for user
@HiveType(typeId: 0)
class Theme_check{
  Theme_check({
    required this.theme,
    // required this.name,
  });

  @HiveField(0)
  bool theme;
  // String name;
}

//  flutter packages pub run build_runner build