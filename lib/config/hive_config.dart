import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class HiveConfig {
  static start() async {
    Directory dir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(dir.path);
  }
}
