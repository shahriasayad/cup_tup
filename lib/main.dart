import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cup_tub/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Open the box before running the app
  await Hive.openBox('loginBox');
  await Hive.openBox('salesBox');
  await Hive.openBox('userBox');

  runApp(App());
}
