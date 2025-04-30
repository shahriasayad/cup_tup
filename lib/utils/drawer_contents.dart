import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DrawerContents extends StatelessWidget {
  const DrawerContents({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // padding: EdgeInsets,
        // zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF4CAF50)),
            child: Text('Menu',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.green,
            ),
            title: Text('User Profile'),
            onTap: () {
              Get.toNamed('/user');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.history,
              color: Colors.green,
            ),
            title: Text('Sales History'),
            onTap: () {
              Get.toNamed('/sales_history');
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_forever, color: Colors.red),
            title: Text('Wipe Data', style: TextStyle(color: Colors.red)),
            onTap: () {
              Get.defaultDialog(
                title: "Wipe All Data",
                middleText:
                    "This will permanently delete all saved data including login info, sales records, and user history.\n\nAre you sure you want to continue?",
                textConfirm: "Yes, Wipe",
                textCancel: "Cancel",
                confirmTextColor: Colors.white,
                buttonColor: Colors.red,
                onConfirm: () async {
                  await Hive.box('loginBox').clear();
                  await Hive.box('userBox').clear();
                  await Hive.box('salesBox').clear();
                  await Hive.box('transactionsBox').clear();
                  Get.offAllNamed('/login');
                  Get.snackbar('Data Wiped', 'All data has been cleared.',
                      snackPosition: SnackPosition.BOTTOM);
                },
                onCancel: () => Get.back(),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.green,
            ),
            title: Text('Logout'),
            onTap: () {
              Get.defaultDialog(
                title: "Logout",
                middleText: "Are you sure you want to logout?",
                textConfirm: "Yes",
                textCancel: "Cancel",
                confirmTextColor: Colors.white,
                buttonColor: const Color(0xFF4CAF50),
                onConfirm: () {
                  Hive.box('loginBox').put('isLoggedIn', false);
                  Get.offAllNamed('/login');
                },
                onCancel: () => Get.back(),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.question_mark_rounded,
              color: Colors.green,
            ),
            title: Text('about'),
            onTap: () {
              Get.toNamed('/about');
            },
          ),
        ],
      ),
    );
  }
}
