import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media_o/app/pages/login_screen/widget/text_field_auth.dart';

import '../controller/login_controller.dart';
import '../widget/button.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});

  final LoginController loginController = Get.find<LoginController>();

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
              const SizedBox(height: 24),
              Lottie.asset(
                'assets/animations/Animation - 1744551766873.json',
                fit: BoxFit.contain,
                width: 200,
                height: 200,
              ),
              const Text(
                'Welcome to Expensify',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
                obscureText: true,
                hintText: 'Password',
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: (){},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ButtonAuth(text: 'Login', onPressed: controller.login),
              const SizedBox(height: 32),
              Text(
                'Don\'t have an account?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              TextButton(
                onPressed: () {
                  controller.navigateToRegister();
                },
                child: const Text(
                  'Register Here',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
