import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cup_tub/app.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openBox('loginBox');
  await Hive.openBox('salesBox');
  await Hive.openBox('transactionsBox');
  await Hive.openBox('userBox');
  runApp(App());
}
