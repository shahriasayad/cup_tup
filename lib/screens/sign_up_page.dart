import 'package:cup_tub/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/custom themes/custom_button.dart';
import '../utils/custom themes/password_text_form_field.dart';
import '../utils/custom themes/text_field_theme.dart';
import 'package:hive/hive.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  late Box loginBox;

  @override
  void initState() {
    super.initState();
    createBox();
  }

  void createBox() async {
    loginBox = await Hive.openBox('loginBox');
  }

  void handleLogin() async {
    final username = userNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in all fields",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    await loginBox.put('username', username);
    await loginBox.put('email', email);
    await loginBox.put('password', password);

    Get.offAll(() => DashBoardScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Log in",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 25),
                            CustomTextFormField(
                              controller: userNameController,
                              hintText: "user name",
                              icon: Icons.person,
                            ),
                            const SizedBox(height: 15),
                            CustomTextFormField(
                              controller: emailController,
                              hintText: "email address",
                              icon: Icons.email,
                            ),
                            const SizedBox(height: 15),
                            PasswordTextFormField(
                              controller: passwordController,
                              hintText: 'Password',
                            ),
                            const SizedBox(height: 15),

                            // ////////
                            CustomButton(
                              buttonText: 'Log in',
                              onPressed: () async {
                                // Validate that all fields are filled
                                if (userNameController.text.isNotEmpty &&
                                    emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty) {
                                  // Save user data to Hive
                                  await loginBox.put(
                                      'username', userNameController.text);
                                  await loginBox.put(
                                      'email', emailController.text);
                                  await loginBox.put(
                                      'password', passwordController.text);
                                  await loginBox.put(
                                      'isLoggedIn', true); // Save login state

                                  // Navigate to the dashboard screen
                                  Get.offAll(() => DashBoardScreen());
                                } else {
                                  // Show an error message if any field is empty
                                  Get.snackbar(
                                    "Error",
                                    "Please fill in all fields",
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
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
