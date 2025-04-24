import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DashBoardScreen extends StatelessWidget {
  final salesBox = Hive.box('salesBox');

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
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                final itemName = [
                  'Chips',
                  'Cookies',
                  'Popcorn',
                  'Tea',
                  'Coffee',
                  'Juice'
                ][index];
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
                        Icon(
                          index < 3 ? Icons.fastfood : Icons.local_cafe,
                          size: 40,
                          color: Colors.black,
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
