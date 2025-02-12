import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journey/controllers/commentcontroller.dart';
import 'package:journey/controllers/postcontroller.dart';
import 'package:journey/controllers/authcontroller.dart';
import 'package:journey/helper/initial.dart' as deb;
import 'package:journey/helper/route_helper.dart';
import 'package:journey/pages/auth_pages/sign_in_page.dart';
import 'package:journey/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await deb.init();
  final authController = Get.find<Authcontroller>();
  await authController.clearAccessToken();
  await authController.checkLoginStatus();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Postcontroller>(
      builder: (_) {
        return GetBuilder<Commentcontroller>(
          builder: (_) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              defaultTransition: Transition.fade,
              transitionDuration: const Duration(milliseconds: 75),
              home: const Root(),  
              getPages: RouteHelper.routes,
            );
          },
        );
      },
    );
  }
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<Authcontroller>();

    return Obx(() {
      return authController.isLoggedIn.value ? const HomePage() : const SigninPage();
    });
  }
}
