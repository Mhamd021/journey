import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journey/controllers/postcontroller.dart';
import '../../consts/dimensions.dart';
import 'posts_page_body.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  Future<void> loadResources() async 
  {
    await Get.find<Postcontroller>().getPosts();
  }

  @override
  void initState() {
    super.initState();
   Get.find<Postcontroller>().getPosts();
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
              margin: EdgeInsets.only(top: Dimensions.height45),
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    children: [
                      Text(
                        "posts",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.width30,
                      height: Dimensions.height30,
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
                  )
                ],
              ),
            ),
            const Expanded(child: SingleChildScrollView(child: PostsPageBody())),
          ],
        ),
      ),
    );
  }
}
