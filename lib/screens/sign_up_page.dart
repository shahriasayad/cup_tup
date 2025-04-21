import 'package:cup_tub/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/custom themes/custom_button.dart';
import '../utils/custom themes/password_text_form_field.dart';
import '../utils/custom themes/text_field_theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                            Text(
                              "Log in",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 25),
                            CustomTextFormField(
                              hintText: "user name",
                              icon: Icons.person,
                            ),
                            SizedBox(height: 15),
                            CustomTextFormField(
                              hintText: "email address",
                              icon: Icons.email,
                            ),
                            SizedBox(height: 15),
                            PasswordTextFormField(hintText: 'Password'),
                            SizedBox(height: 15),
                            CustomButton(
                              buttonText: 'Log in',
                              onPressed: () {
                                Get.to(DashBoardScreen());
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
