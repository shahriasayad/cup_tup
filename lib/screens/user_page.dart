import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class UserPage extends StatelessWidget {
  final userBox = Hive.box('userBox');

  @override
  Widget build(BuildContext context) {
    final String username = userBox.get('username', defaultValue: 'Guest');
    final String email = userBox.get('email', defaultValue: 'No Email');

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
        backgroundColor: const Color(0xFF4CAF50),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(username, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Email:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(email, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
