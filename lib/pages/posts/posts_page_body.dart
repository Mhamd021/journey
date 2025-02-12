import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journey/controllers/commentcontroller.dart';
import 'package:journey/models/Post.dart';
import 'package:journey/widgets/textFieldwidget.dart';
import '../../consts/appConsts.dart';
import '../../consts/dimensions.dart';
import '../../controllers/postcontroller.dart';

class PostsPageBody extends StatefulWidget {
  const PostsPageBody({super.key});
  @override
  State<PostsPageBody> createState() => _PostsPageBodyState();
}

var postInfoController = TextEditingController();
TextEditingController commentInfoController = TextEditingController();
class _PostsPageBodyState extends State<PostsPageBody> {
  void toggleLike(Post post) {
    Get.find<Postcontroller>().toggleLike(post.id);
  }

 void createComment(Post post) {
  String commentInfo = commentInfoController.text.trim();
  var commentcontroller = Get.find<Commentcontroller>();
  commentcontroller.createComment(post, commentInfo).then((status) {
    if (status.isSuccess) {
      Get.snackbar('Success', status.message);
      commentInfoController.text = '';
    } else {
      Get.snackbar('Failed', status.message);
    }
  });
}

  void getComments(Post post) async {
    await Get.find<Commentcontroller>().getpostcomments(post.id);
    showCommentsModal(post);
  }

  createPost() {
    var postcontroller = Get.find<Postcontroller>();
    String postinfo = postInfoController.text.trim();
    postcontroller.createpost(postinfo).then((status) {
      if (status.isSuccess == true) {
        Get.snackbar("success", "Post Created!");
        postInfoController.text = '';
      } else {
        Get.snackbar("failed", status.message);
      }
    });
  }

  void showCommentsModal(Post post) {
  

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius15),
        ),
        child: Container(
          height: Dimensions.height45 * 14, 
          width: Dimensions.width45 * 12,
          padding: EdgeInsets.all(Dimensions.width20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.radius15),
          ),
          child: Column(
            children: [
              Expanded(
                child: GetBuilder<Commentcontroller>(builder: (controller) {
                  return controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.comments.length,
                          itemBuilder: (context, index) {
                            final comment = controller.comments[index];
                            return Column(children: [
                              Row(children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: Dimensions.width10,
                                      top: Dimensions.width10),
                                  width: Dimensions.width30 + Dimensions.width20,
                                  height: Dimensions.width30 + Dimensions.width20,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    radius:
                                        (Dimensions.width30 + Dimensions.width30) /
                                            2,
                                    backgroundImage: comment.user.userImage !=
                                                null &&
                                            comment.user.userImage!.isNotEmpty
                                        ? NetworkImage(
                                            "http://${Appconsts.appUri}/${comment.user.userImage}")
                                        : const AssetImage("assets/image/lego.png")
                                            as ImageProvider,
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                SizedBox(width: Dimensions.width10 / 4),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      comment.user.name,
                                      style: TextStyle(
                                          fontSize: Dimensions.font20 / 1.5,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      comment.createdAt,
                                      style: TextStyle(
                                        fontSize: Dimensions.font20 / 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                               const Divider(
                                color: Colors.grey,
                                thickness: 0.5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      comment.commentInfo,
                                      style: TextStyle(
                                          fontSize: Dimensions.font20 / 2 + 5),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 0.5,
                              ),
                            ]);
                          },
                        );
                }),
              ),
              
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: commentInfoController,
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.width10),
                 GestureDetector
                 (
                  onTap: () 
                  {
                    createComment(post);
                  },
                  child: const Icon(Icons.send)),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: Dimensions.height15),
          child: Column(
            children: [
              AppTextField(
                textController: postInfoController,
                hintText: "What's on your mind ....?",
                icon: Icons.send,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.image),
                  GestureDetector(
                      onTap: () {
                        createPost();
                      },
                      child: const Icon(
                        Icons.send,
                      ))
                ],
              ),
            ],
          ),
        ),
        GetBuilder<Postcontroller>(builder: (controller) {
          return controller.isLoading.value
              ? const CircularProgressIndicator()
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.posts.length,
                  itemBuilder: (context, index) {
                    final post = controller.posts[index];
                    return Container(
                      padding: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                          bottom: Dimensions.width10 / 1.5),
                      margin: EdgeInsets.only(
                        bottom: Dimensions.width10,
                        left: Dimensions.width10 / 1.2,
                        right: Dimensions.width10 / 1.2,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: Dimensions.width10,
                                      top: Dimensions.width10),
                                  width:
                                      Dimensions.width30 + Dimensions.width20,
                                  height:
                                      Dimensions.width30 + Dimensions.width20,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape
                                        .circle, // Makes the Container a circle
                                  ),
                                  child: CircleAvatar(
                                    radius: (Dimensions.width30 +
                                            Dimensions.width30) /
                                        2,
                                    backgroundImage: post.user.userImage !=
                                                null &&
                                            post.user.userImage!.isNotEmpty
                                        ? NetworkImage(
                                            "http://${Appconsts.appUri}/${post.user.userImage}")
                                        : const AssetImage(
                                                "assets/image/lego.png")
                                            as ImageProvider,
                                    backgroundColor: Colors
                                        .transparent, // Optional: makes the background transparent
                                  ),
                                ),
                                SizedBox(width: Dimensions.width10 / 4),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      post.user.name,
                                      style: TextStyle(
                                          fontSize: Dimensions.font20 / 1.5,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      post.createdAt,
                                      style: TextStyle(
                                        fontSize: Dimensions.font20 / 2,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.5,
                            ),
                            SizedBox(
                                height: Dimensions.width10 +
                                    Dimensions.width10 / 2),
                            Text(
                              post.postInfo,
                              style: TextStyle(
                                  fontSize: Dimensions.font20 / 2 + 5),
                            ),
                            SizedBox(height: Dimensions.width10 / 4),
                            post.postImage != null && post.postImage!.isNotEmpty
                                ? Image.network(
                                    "http://${Appconsts.appUri}/${post.postImage}",
                                    fit: BoxFit.contain,
                                  )
                                : const SizedBox()
                          ],
                        ),
                        SizedBox(height: Dimensions.height20),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${post.likesCount} likes"),
                                Text("${post.commentsCount} comments"),
                              ],
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 0.5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () => toggleLike(post),
                                  child: Icon(
                                    post.hasLiked
                                        ? Icons.thumb_up
                                        : Icons.thumb_up_outlined,
                                    color: post.hasLiked
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                ),
                                SizedBox(width: Dimensions.width10 / 3),
                                Text(
                                  post.hasLiked ? "liked" : "like",
                                  style: TextStyle(
                                    color: post.hasLiked
                                        ? Colors.blue
                                        : Colors.black,
                                  ),
                                ),
                                SizedBox(width: Dimensions.width45),
                                GestureDetector(
                                  onTap: () => getComments(post),
                                  child: const Icon(
                                    Icons.messenger_outline,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: Dimensions.width10 / 3),
                                const Text("comment"),
                                SizedBox(width: Dimensions.width45),
                                const Icon(
                                  Icons.share,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: Dimensions.width10 / 3),
                                const Text("share"),
                              ],
                            ),
                          ],
                        ),
                      ]),
                    );
                  },
                );
        }),
      ],
    );
  }
}
