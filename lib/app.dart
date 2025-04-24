import 'package:cup_tub/screens/dashboard.dart';
import 'package:cup_tub/screens/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Cup Tup",
      debugShowCheckedModeBanner: false,
      home: const LogInScreen(), // this should work now
    );
  }
}
