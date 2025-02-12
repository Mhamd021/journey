
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:journey/consts/appConsts.dart';
import 'package:journey/models/response_model.dart';

import '../models/Post.dart';

class Postcontroller extends GetxController 
{
  final storage = const FlutterSecureStorage();
  var posts = <Post>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getPosts();
  }

  Future<void> getPosts() async 
  {
    final token = await storage.read(key: 'access_token');
    try {
      isLoading(true);
      var url = Uri.http(Appconsts.appUri, Appconsts.posts);
      var response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Cookie': Appconsts.cookie,
        'User-Agent': Appconsts.useragent,
      });
      if (response.statusCode == 200) {
        Map<String, dynamic> data = convert.jsonDecode(response.body);
        final postsJson = data['posts'] as List;
        posts.assignAll(
            postsJson.map((postJson) => Post.fromJson(postJson)).toList());
      } else {
        errorMessage('Failed to load posts');
      }
    } catch (e) {
      errorMessage(e.toString());
    } 
    finally {
      isLoading(false);
    }
   update(); 
  }

  Future<void> toggleLike(int postId) async {
    final token = await storage.read(key: 'access_token');

    final post = posts.firstWhere((post) => post.id == postId);
    post.hasLiked = !post.hasLiked;
    post.hasLiked ? post.likesCount++ : post.likesCount--;
    update();

    try {
      var url = Uri.http(Appconsts.appUri, '/api/apiPosts/like/$postId');
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Cookie': Appconsts.cookie,
          'User-Agent': Appconsts.useragent,
        },
      );
      if (response.statusCode == 200) {
        final data = convert.jsonDecode(response.body);
        post.hasLiked = data['liked'];
        post.likesCount = data['likes_count'];
      } else {
        post.hasLiked = !post.hasLiked;
        post.hasLiked ? post.likesCount++ : post.likesCount--;
      }
    } catch (e) {
      post.hasLiked = !post.hasLiked;
      post.hasLiked ? post.likesCount++ : post.likesCount--;
    }

    update();
  }

  Future<ResponseModel> createpost(String postinfo, {String postimage = ""}) async {
  final token = await storage.read(key: 'access_token');
  late ResponseModel responseModel;
  var url = Uri.http(Appconsts.appUri, Appconsts.posts);
  final response = await http.post(
    url,
    body: convert.jsonEncode({
      'post_info': postinfo,
      'post_image': postimage,
    }),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Cookie': Appconsts.cookie,
      'User-Agent': Appconsts.useragent,
    },
  );
  Map<String, dynamic> data = convert.jsonDecode(response.body);
  if (response.statusCode == 200) {
    responseModel = ResponseModel(true, data['message']);
    getPosts();
    update();
  } else {
    responseModel = ResponseModel(false, data['message']);
  }
  return responseModel;
}

  Future<ResponseModel> editpost(int post, String userid, String postinfo,
      {String postimage = ""}) async {
    final token = await storage.read(key: 'access_token');
    late ResponseModel responseModel;
    var url = Uri.http(Appconsts.appUri, '/api/ModifyPost/$post?_method=PUT');
    final response = await http.post(url, body: {
      'user_id': userid,
      'post_info': postinfo,
      'post_image': postimage
    }, headers: {
      'Accept':'application/json',
      'Authorization': 'Bearer$token',
      'Content-Type': 'application/json',
      'Cookie': Appconsts.cookie,
      'User-Agent': Appconsts.useragent,
    });
    Map<String, dynamic> data = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, data['message']);
    } else {
      responseModel = ResponseModel(false, data['message']);
    }
    return (responseModel);
  }

//delete post
//authentication
}

