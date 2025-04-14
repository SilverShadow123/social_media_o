import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_o/app/pages/login_screen/widget/text_field_auth.dart';

import '../../login_screen/widget/button.dart';
import '../controleller/register_controller.dart';

class RegisterScreen extends GetView {
  RegisterScreen({super.key});
final RegisterController controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Register to Expensify',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              TextFieldAuth(
                controller: controller.nameTEController,
                labelText: 'Name',
                obscureText: false,
                hintText: 'Name',
              ),
              const SizedBox(height: 24),
              TextFieldAuth(
                controller: controller.emailTEController,
                labelText: 'Email',
                obscureText: false,
                hintText: 'Email',
              ),
              const SizedBox(height: 24),
              TextFieldAuth(
                controller: controller.passwordTEController,
                labelText: 'Password',
                obscureText: false,
                hintText: 'Password',
              ),
              const SizedBox(height: 24),
              TextFieldAuth(
                controller: controller.confirmPasswordTEController,
                labelText: 'Confirm Password',
                obscureText: false,
                hintText: 'Confirm Password',
              ),

              const SizedBox(height: 24),
              ButtonAuth(text: 'Register', onPressed: controller.register),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.navigateToLogin();
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
