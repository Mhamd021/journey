class Journey {
  late List<Journeys> journeys;
  Journey({
    required this.journeys
     });

  Journey.fromJson(Map<String, dynamic> json) {
    if (json['journeys'] != null) {
      journeys = <Journeys>[];
      json['journeys'].forEach((v) {
        journeys.add(Journeys.fromJson(v));
      });
    }
  }
}

class Journeys {
  int? id;
  String? headline;
  String? startDay;
  String? lastDay;
  StartPoint? startPoint;
  StartPoint? endPoint;
  String? description;
  int? journeyCharg;
  int? maxNumber;
  String? createdAt;
  String? updatedAt;

  Journeys(
      {this.id,
      this.headline,
      this.startDay,
      this.lastDay,
      this.startPoint,
      this.endPoint,
      this.description,
      this.journeyCharg,
      this.maxNumber,
      this.createdAt,
      this.updatedAt});

  Journeys.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    headline = json['headline'];
    startDay = json['start_day'];
    lastDay = json['last_day'];
    startPoint = json['start_point'] != null
        ?  StartPoint.fromJson(json['start_point'])
        : null;
    endPoint = json['end_point'] != null
        ?  StartPoint.fromJson(json['end_point'])
        : null;
    description = json['description'];
    journeyCharg = json['journey_charg'];
    maxNumber = json['max_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

 
}

class StartPoint {
  String? type;
  List<double>? coordinates;

  StartPoint({this.type, this.coordinates});

  StartPoint.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

}
