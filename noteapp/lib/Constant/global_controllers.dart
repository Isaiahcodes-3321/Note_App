import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:noteapp/Screens/Add_Note/export_note_input.dart';

//my storage Make Hive accessible anywhere,
class GlobalControllers {
static late Box themeStorage;
static late RecorderController controller;
static late PlayerController playerController;
static  TextEditingController? noteContext;
static  TextEditingController? noteTittleContext;
// static late String? noteBodyValue;
// static late String? noteTittleValue;
}
