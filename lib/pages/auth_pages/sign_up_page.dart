import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journey/consts/dimensions.dart';
import 'package:journey/widgets/textFieldwidget.dart';

import '../../controllers/authcontroller.dart';
import '../../helper/route_helper.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    var nameComtroller = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var passwordConfirmController = TextEditingController();
    register() {
      var authController = Get.find<Authcontroller>();
      String name = nameComtroller.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String passwordconfirm = passwordConfirmController.text.trim();

      if (name.isEmpty) {
        Get.snackbar("error", "name is required",
            animationDuration: Durations.extralong1);
      } else if (email.isEmpty) {
        Get.snackbar("error", "email is required",
            snackPosition: SnackPosition.BOTTOM);
      } else if (password.length < 8) {
        Get.snackbar("error", "password should be at least 8 chars",
            snackPosition: SnackPosition.BOTTOM);
      } else if (password != passwordconfirm) {
        Get.snackbar("error", "passwords did not match",
            snackPosition: SnackPosition.TOP);
      } else {
        authController.register(name, email, password).then((status) {
          if (status.isSuccess == true) {
            Get.snackbar("success", "welcome!");
            Get.offNamed(RouteHelper.getProfile());
          } else {
            Get.snackbar("failed", status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.height30 * 4),
            //app logo
            SizedBox(
              height: Dimensions.height20 * 5,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: Dimensions.radius15 * 5,
                  backgroundImage: const AssetImage("assets/image/lego.png"),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height20 * 3 + 10),
            AppTextField(
              textController: nameComtroller,
              hintText: "user",
              icon: Icons.person,
            ),
            SizedBox(height: Dimensions.height30),
            AppTextField(
              textController: emailController,
              hintText: "user@example.com",
              icon: Icons.email_outlined,
            ),
            SizedBox(height: Dimensions.height30),
            AppTextField(
              textController: passwordController,
              hintText: "*********",
              icon: Icons.password,
            ),
            SizedBox(height: Dimensions.height30),

            AppTextField(
              textController: passwordConfirmController,
              hintText: "*********",
              icon: Icons.key_sharp,
            ),
            SizedBox(height: Dimensions.height30),

            GestureDetector(
              onTap: () {
                register();
              },
              child: Container(
                width: Dimensions.screenWidth / 3.4,
                height: Dimensions.screenHeight / 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: Colors.blue,
                ),
                child: const Center(
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10),
            GestureDetector(
              onTap: () {
                Get.offNamed(RouteHelper.getSignIn());
              },
              child: const Text(
                "already have an account?",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
