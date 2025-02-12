import 'package:get/get.dart';

import '../consts/appConsts.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../models/journey.dart';

class Journeycontroller extends GetxController {
  bool _isLoaded = false;
  List<dynamic> _journeysList = [];
  List<dynamic> get journeysList => _journeysList;
  bool get isLoaded => _isLoaded;

  Future<void> getjourneys() async {
    var url = Uri.http(Appconsts.appUri, Appconsts.journeys);
    final response = await http.get(
      url,
        headers :
        {
          'Content-Type' : 'application/json',
          'Cookie' : Appconsts.cookie,
          'User-Agent' : Appconsts.useragent,
        },
      );
    Map<String, dynamic> data = convert.jsonDecode(response.body);
    _journeysList = [];
    _journeysList.addAll(Journey.fromJson(data).journeys);
    _isLoaded = true;
    update();
  }
}
