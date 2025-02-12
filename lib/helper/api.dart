import 'package:get/get.dart';

// import '../consts/appConsts.dart';


class Api extends GetConnect implements GetxService
{
     late String token;
    final String appBaseUrl;
    late Map<String,String> _mainHeaders;
    late String sharedPreferences;

    Api({required this.appBaseUrl,required this.sharedPreferences}){
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = "123123132";
    // sharedPreferences.getString(Appconsts.TOKEN)??"";
    _mainHeaders=
    {
      'Content-type':'application/json',
      'Authorization':'Bearer $token',
    };

    }
    void updateHeader (String token)
    {
        _mainHeaders=
    {
      'Content-type':'application/json; charset=UTF-8',
      'Authorization':'Bearer $token',
    };
    }
    Future<Response> getData (String uri,{Map<String,String>? headers})
    async {
      try{
      Response response =  await 
      get(
        uri,
        headers: headers??_mainHeaders
        );
      return response;
      }
      catch(e){
        return Response(statusCode: 1,statusText: e.toString());
      }
    }

      Future<Response> postData(String uri,dynamic body) async 
    {
      
      try
      {
        Response response = await post(uri, body,headers: _mainHeaders);
       
        return response;
      }
      catch(e)
      {
        
        return Response(statusCode: 1 ,statusText: e.toString());
      } 
    }
}