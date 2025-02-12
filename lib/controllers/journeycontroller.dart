import 'package:get/get.dart';
import '../consts/appConsts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../models/Journey.dart';

class Journeycontroller extends GetxController {
  var journeys = <Journey>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  Future<void> getjourneys() async {
    var url = Uri.http(Appconsts.appUri, '/api/journeys');
    try {
      isLoading(true);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = convert.jsonDecode(response.body);
        final journeysJson = data['journeys'] as List;
        journeys.assignAll(
          journeysJson.map((journeyJson) => Journey.fromJson(journeyJson)).toList(),
        );
        
      } else {
        errorMessage('could not fetch journeys');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
    update();
  }
}
