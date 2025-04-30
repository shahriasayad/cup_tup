import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cup_tub/screens/sales_history.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DashboardScreen extends StatelessWidget {
  final salesBox = Hive.box('salesBox');

  final List<String> itemNames = [
    'Chips',
    'Cookies',
    'Popcorn',
    'Tea',
    'Coffee',
    'Juice',
  ];

  final List<String> itemIcons = [
    'assets/icons/chips.png',
    'assets/icons/cookie.png',
    'assets/icons/popcorn.png',
    'assets/icons/tea.png',
    'assets/icons/coffee-cup.png',
    'assets/icons/orange-juice.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Color(0xFF4CAF50),
      ),
      drawer: DrawerContents(),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: itemNames.length,
              itemBuilder: (context, index) {
                final itemName = itemNames[index];
                final totalSold =
                    salesBox.get('$itemName-sold', defaultValue: 0);
                final totalAmount =
                    salesBox.get('$itemName-amount', defaultValue: 0);

                return Card(
                  color: Color(0xFFE6FFE6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          itemIcons[index],
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(height: 10),
                        Text('Total Sold: $totalSold'),
                        Text('Total Amount: $totalAmount BDT'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Profit: ${salesBox.get('totalProfit', defaultValue: 0)} BDT',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4CAF50),
                  ),
                  onPressed: () => Get.toNamed('/menu'),
                  child: Text('MENU', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Drawer DrawerContents() {
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
