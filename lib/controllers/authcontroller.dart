import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:journey/consts/appConsts.dart';
import 'package:journey/models/response_model.dart';

class Authcontroller extends GetxController implements GetxService {
  final storage = const FlutterSecureStorage();
    RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;
  Future<ResponseModel> login(String email, String password) async 
  {
        isLoading.value = true;
    late ResponseModel responseModel;
    var url = Uri.http(Appconsts.appUri, Appconsts.login);
    final response =
        await http.post(
          url,
        headers :
        {
          'Cookie' : Appconsts.cookie,
          'User-Agent' : Appconsts.useragent,
        },
         body: {'email': email, 'password': password});
    Map<String, dynamic> data = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "Welcome!");
      await storage.write(key: 'access_token', value: data["access_token"]);
    } else {
      responseModel = ResponseModel(false, data["message"]);
    }
        isLoading.value = false;
    return (responseModel);
  }

  Future<ResponseModel> register(
      String name, String email, String password) async {
    late ResponseModel responseModel;
    var url = Uri.http(Appconsts.appUri, Appconsts.registeration);
    final response = await http
        .post(url,
         headers :
        {
          'Content-Type' : 'application/json',
          'Cookie' : Appconsts.cookie,
          'User-Agent' : Appconsts.useragent,
        },
         body: {'name': name, 'email': email, 'password': password}
         );
    Map<String, dynamic> data = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "Welcome!");
      await storage.write(key: 'access_token', value: data["access_token"]);
    } else {
      responseModel = ResponseModel(false, data.toString());
    }

    return (responseModel);
  }
   Future<ResponseModel>logout() async {
    late ResponseModel responseModel;
  var url = Uri.http(Appconsts.appUri, Appconsts.logout);
   final token = await storage.read(key: 'access_token');
  final response = await http.post(
    url,

    headers: {
    'Accept':'application/json',
     'Authorization':'Bearer $token',
      'Content-Type' : 'application/json',
          'Cookie' : Appconsts.cookie,
          'User-Agent' : Appconsts.useragent,
      
  },
  );
  Map<String,dynamic> data = convert.jsonDecode(response.body);
  if(response.statusCode == 200) 
  {
      responseModel = ResponseModel(true, data["message"]);
  }
  else 
  {
    responseModel = ResponseModel(false, data["message"]);
  }
   
   
  return (responseModel);
  

}

 Future<bool> checkLoginStatus() async {
    try {
      final token = await storage.read(key: 'access_token');
      isLoggedIn.value = token != null;  
      return isLoggedIn.value;
    } catch (e) {
    
     
      isLoggedIn.value = false;
      return false;
    }
  }
 Future<void> clearAccessToken() async {
    await storage.delete(key: 'access_token');
    isLoggedIn.value = false;
  }


}
