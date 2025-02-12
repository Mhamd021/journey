import 'package:get/get.dart';
import 'package:journey/controllers/authcontroller.dart';
import 'package:journey/controllers/commentcontroller.dart';
import 'package:journey/controllers/journeycontroller.dart';
import '../controllers/postcontroller.dart';

Future<void> init() async 
{
  Get.lazyPut(() => Authcontroller());
  Get.lazyPut(() => Postcontroller());
  Get.lazyPut(() => Commentcontroller());
  Get.lazyPut(() => Journeycontroller());

}