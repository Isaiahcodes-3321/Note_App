import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final title_trash = StateProvider((ref) => "Hello New Note");

final note_trash = StateProvider((ref) =>
    "Hello i will be going to the market to get some things today okey ");

final date_deleted = StateProvider((ref) => "5 Sep");
