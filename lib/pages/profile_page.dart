import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/authcontroller.dart';
import '../helper/route_helper.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});
 logout ()
 {
        var authController = Get.find<Authcontroller>();
         authController.logout().then((status)
          {
            if(status.isSuccess == true)
            {
                  Get.snackbar("success",status.message,colorText: Colors.green[300]);
                  Get.offNamed(RouteHelper.getSignIn());
            }
            else
            {
              Get.snackbar("failed", status.message);
            }

          });


 }

  @override
  Widget build(BuildContext context) {
    return  Scaffold
    (
       body: GestureDetector(
        onTap:()
              {
                Get.offNamed(RouteHelper.getSignIn());
              },
        child: const Center(child:  Text("hello"))
        ),
    );
  }
}