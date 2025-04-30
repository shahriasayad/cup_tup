import 'package:cup_tub/utils/custom%20themes/custom_button.dart';
import 'package:cup_tub/utils/custom%20themes/password_text_form_field.dart';
import 'package:cup_tub/utils/custom%20themes/text_field_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LogInScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final loginBox = Hive.box('loginBox');

  @override
  Widget build(BuildContext context) {
    // Check login status on app start
    if (loginBox.get('isLoggedIn', defaultValue: false)) {
      Future.microtask(() => Get.offAllNamed('/dashboard'));
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Log in',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 25),
                            CustomTextFormField(
                              controller: usernameController,
                              hintText: "username",
                              icon: Icons.person,
                            ),
                            SizedBox(height: 15),
                            CustomTextFormField(
                              controller: emailController,
                              hintText: "email address",
                              icon: Icons.email,
                            ),
                            SizedBox(height: 15),
                            PasswordTextFormField(
                              controller: passwordController,
                              hintText: 'Password',
                            ),
                            SizedBox(height: 28),
                            CustomButton(
                              buttonText: "LOGIN",
                              onPressed: () {
                                String username =
                                    usernameController.text.trim();
                                String email = emailController.text.trim();
                                String password =
                                    passwordController.text.trim();

                                // 🛑 First, check for empty fields
                                if (username.isEmpty ||
                                    email.isEmpty ||
                                    password.isEmpty) {
                                  Get.snackbar(
                                      "Error", "Please fill all fields",
                                      snackPosition: SnackPosition.BOTTOM);
                                  return;
                                }

                                // ✅ Now check if credentials are correct
                                if (username == 'tawaf' &&
                                    password == 'cuptup' &&
                                    email == 'tawaf@gmail.com') {
                                  // Open or access userBox
                                  final userBox = Hive.box('userBox');

                                  // Save user data in Hive
                                  userBox.put('username', username);
                                  userBox.put('email', email);

                                  // Also mark login state
                                  final loginBox = Hive.box('loginBox');
                                  loginBox.put('isLoggedIn', true);

                                  // Navigate to dashboard
                                  Get.offAllNamed('/dashboard');
                                } else {
                                  Get.snackbar(
                                      "Error", "Invalid login credentials",
                                      snackPosition: SnackPosition.BOTTOM);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
