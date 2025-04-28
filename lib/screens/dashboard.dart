import 'package:flutter/material.dart';
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
                        Text('Total Amount: $totalAmount TK'),
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
                  'Total Profit: ${salesBox.get('totalProfit', defaultValue: 0)} TK',
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
}
