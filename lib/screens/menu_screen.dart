import 'package:cup_tub/utils/custom%20themes/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuScreen extends StatelessWidget {
  final List<String> items = [
    'Chips',
    'Cookies',
    'Popcorn',
    'Tea',
    'Coffee',
    'Juice'
  ];
  final List<int> prices = [10, 15, 20, 10, 15, 20];
  final quantities = List<int>.generate(6, (_) => 0).obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        backgroundColor: Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(items[index]),
                          Text('₹${prices[index]}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              if (quantities[index] > 0) quantities[index]--;
                            },
                          ),
                          Text('${quantities[index]}'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              quantities[index]++;
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            CustomButton(
              buttonText: "Go to cart",
              onPressed: () {
                Get.toNamed('/cart', arguments: quantities);
              },
            ),
          ],
        ),
      ),
    );
  }
}
