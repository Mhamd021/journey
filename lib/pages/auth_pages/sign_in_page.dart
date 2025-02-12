import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journey/consts/dimensions.dart';
import 'package:journey/controllers/authcontroller.dart';
import 'package:journey/widgets/textFieldwidget.dart';
import '../../helper/route_helper.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isLoading = false;

  void login() {
    var authController = Get.find<Authcontroller>();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (!email.contains("@")) {
      Get.snackbar("error", "email is required", colorText: Colors.red[300], animationDuration: Durations.extralong1);
    } else if (password.length < 8) {
      Get.snackbar("error", "password should be at least 8 chars", colorText: Colors.red[300], snackPosition: SnackPosition.BOTTOM);
    } else if (password.isEmpty) {
      Get.snackbar("error", "password is required", colorText: Colors.red[300], snackPosition: SnackPosition.TOP);
    } else {
      setState(() {
        isLoading = true;
      });

      authController.login(email, password).then((status) {
        setState(() {
          isLoading = false;
        });

        if (status.isSuccess) {
         
          Get.offNamed(RouteHelper.getHome());
           Get.snackbar("success", "welcome!");
        } else {
          Get.snackbar("failed", status.message);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: Dimensions.height30 * 5),

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

            GestureDetector(
              onTap: isLoading ? null : login,
              child: Container(
                width: Dimensions.screenWidth / 3.4,
                height: Dimensions.screenHeight / 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: Colors.blue,
                ),
                child: Center(
                  child: isLoading
                      ?const  CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ),

            SizedBox(height: Dimensions.height10),
            GestureDetector(
              onTap: () {
                Get.offNamed(RouteHelper.getPostsPage());
              },
              child: const Text(
                "Don't have an account?",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
