class Reservation {
  final int statusCode;
  final DateTime date;
  final String title;
  final String description;
  final double cost;
  final String pictureUrl;
  final String employeeName;
  final String employeeAvatarUrl;

  Reservation({
    required this.statusCode,
    required this.date,
    required this.title,
    required this.description,
    required this.cost,
    required this.pictureUrl,
    required this.employeeName,
    required this.employeeAvatarUrl,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      statusCode: json['statusCode'],
      date: DateTime.parse(json['date']),
      title: json['title'],
      description: json['description'],
      cost: json['cost'].toDouble(),
      pictureUrl: json['pictureUrl'],
      employeeName: json['employeeName'],
      employeeAvatarUrl: json['employeeAvatarUrl'],
    );
  }
}