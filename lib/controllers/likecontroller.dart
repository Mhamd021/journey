// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:journey/consts/appConsts.dart';
// import 'dart:convert' as convert;

// class LikeController extends GetxController {
// final storage = const FlutterSecureStorage();
//   bool _isLoaded = false;
//   bool get isLoaded => _isLoaded;
//   var postlikes = <int,int>{}.obs;
//   var isLiked = <int,bool>{}.obs;
  
//   Future  getpostlikes(int postid) async {
//     var url = Uri.http(Appconsts.appUri, '/api/postlikes/$postid');
//     final response = await http.get(
//       url,
//         headers :
//         {
//           'Content-Type' : 'application/json',
//           'Cookie' : Appconsts.cookie,
//           'User-Agent' : Appconsts.useragent,
//         },
      
//       );
//     Map<String, dynamic> data = convert.jsonDecode(response.body);
//     postlikes[postid] = data['count'];
//     _isLoaded = true;
//     update();
//   }

//   getuserlikes() {}

//   //like*
//   Future<void> createlike(int postid) async {
//       var token = storage.read(key: 'access_token');
//     var url = Uri.http(Appconsts.appUri, Appconsts.like);
//     await http.post(
//     url,
//     body:
//     {
//       'post_id': postid,
//     },
//     headers: 
//     {
//       'Accept' : 'application/json',
//       'Authorization':'Bearer$token',
//          'Content-Type' : 'application/json',
//           'Cookie' : Appconsts.cookie,
//           'User-Agent' : Appconsts.useragent,
//     });
    
//   }

//   Future deletelike(int like) async {
//     var url = Uri.http(Appconsts.appUri, '/api/like/$like');
//     final response = await http.delete(
//       url,
//           headers :
//         {
//           'Content-Type' : 'application/json',
//           'Cookie' : Appconsts.cookie,
//           'User-Agent' : Appconsts.useragent,
//         },
      
//       );
//     return (response.body);
//   }

//   Future hasLikedPost(int postId) async {
//     final token = await storage.read(key: 'access_token');
//     var url = Uri.http('127.0.0.1:8000', '/api/hasliked/$postId');
//     final response = await http.get(
//       url,
//       headers: {
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $token',
//          'Content-Type' : 'application/json',
//           'Cookie' : Appconsts.cookie,
//           'User-Agent' : Appconsts.useragent,
//     });

//     Map<String,dynamic> data = convert.jsonDecode(response.body);
//     isLiked[postId] = data['liked']; 
//     update();
//   }

  
// }
