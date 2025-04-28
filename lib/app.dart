import 'package:cup_tub/screens/cart_screen.dart';
import 'package:cup_tub/screens/dashboard.dart';
import 'package:cup_tub/screens/menu_screen.dart';
import 'package:cup_tub/screens/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cup_tub/theme/app_theme.dart';
import 'package:cup_tub/theme/theme_controller.dart';

class App extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CupTup',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeController.themeMode.value,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LogInScreen()),
        GetPage(name: '/dashboard', page: () => DashboardScreen()),
        GetPage(name: '/menu', page: () => MenuScreen()),
        GetPage(name: '/cart', page: () => CartScreen()),
      ],
    );
  }
}
