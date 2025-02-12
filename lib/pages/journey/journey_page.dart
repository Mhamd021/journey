import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journey/controllers/journeycontroller.dart';
import 'package:journey/pages/posts/posts_page.dart';

import '../../consts/dimensions.dart';

class Journeypage extends StatefulWidget {
  const Journeypage({super.key});

  @override
  State<Journeypage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Journeypage> {

  Future<void> loadResources() async {
   await Get.find<Journeycontroller>().getjourneys();
  }

  @override
  void initState() {
    super.initState();
    Get.find<Journeycontroller>().getjourneys();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: loadResources,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                top: Dimensions.height45,
              ),
              padding: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Journeys"),
                  Container(
                    width: Dimensions.width45,
                    height: Dimensions.height45,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Dimensions.iconSize24,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
                child: SingleChildScrollView(
              child: PostsPage(),
            ))
          ],
        ),
      ),
    );
  }
}
