class Journey {
  int id;
  String headline;
  String description;
  String startDate;
  String endDate;
  int maxNumber;
  int journeyCharge;
  String createAt;
  String updatedAt;
  String? deletedAt;
  List<Point> points;

  Journey({
    required this.id,
    required this.headline,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.journeyCharge,
    required this.maxNumber,
    required this.createAt,
    required this.updatedAt,
    this.deletedAt,
    required this.points,
  });

  factory Journey.fromJson(Map<String, dynamic> json) {
    return Journey(
      id: json['id'],
      headline: json['headline'],
      description: json['description'],
      startDate: json['start_day'],
      endDate: json['last_day'],
      journeyCharge: json['journey_charg'],
      maxNumber: json['max_number'],
      createAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      points: (json['points'] as List).map((point) => Point.fromJson(point)).toList(),
    );
  }
}

class Point {
  int id;
  int journeyId;
  int order;
  String pointDescription;
  String? pointImage;
  List<double> coordinates;

  Point({
    required this.id,
    required this.journeyId,
    required this.order,
    required this.pointDescription,
    required this.coordinates,
    this.pointImage,
  });

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      id: json['id'],
      journeyId: json['journey_id'],
      order: json['order'],
      pointDescription: json['point_description'],
      pointImage: json['image'],
      coordinates: json['coordinates'].cast<double>(),
    );
  }
}
