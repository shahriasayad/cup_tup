import 'package:cup_tub/screens/sign_up_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "cup tup",
      debugShowCheckedModeBanner: false,
      // themeMode: ThemeMode.system,
      // theme: ThemeData(
      //   brightness: Brightness.light,
      // ),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      // ),
      home: SignUpScreen(),
    );
  }
}
