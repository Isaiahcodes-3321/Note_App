import 'package:hive/hive.dart';
part 'theme.g.dart';


// Storage for user
@HiveType(typeId: 0)
class ThemeCheck{
  ThemeCheck({
    required this.theme_data,
  });

  @HiveField(0)
  bool theme_data;
}

//  flutter packages pub run build_runner build