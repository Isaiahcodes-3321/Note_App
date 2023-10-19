
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notetittle = StateProvider<String>((ref) => 'Note Title');
final notebody = StateProvider<String>((ref) => 'Note Body');

 
var dateadded = StateProvider((ref) => " 9 Sep");

