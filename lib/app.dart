import 'package:cup_tub/screens/about_app_screen.dart';
import 'package:cup_tub/screens/cart_screen.dart';
import 'package:cup_tub/screens/dashboard.dart';
import 'package:cup_tub/screens/menu_screen.dart';
import 'package:cup_tub/screens/sales_history.dart';
import 'package:cup_tub/screens/sign_up_page.dart';
import 'package:cup_tub/screens/transaction_details_screen.dart';
import 'package:cup_tub/screens/user_page.dart';
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
        GetPage(name: '/sales_history', page: () => SalesHistory()),
        GetPage(
            name: '/transactionDetails',
            page: () => TransactionDetailsScreen()),
        GetPage(name: '/about', page: () => AboutAppScreen()),
        GetPage(
          name: '/user',
          page: () => UserPage(),
        ),
      ],
    );
  }
}
