class Employee {
  final String photoUrl;
  final String firstName;
  final String lastName;
  final double positiveReviews;
  final String status;
  final String procedureType;
  final DateTime date;
  bool isFavorite;

  Employee({
    required this.photoUrl,
    required this.firstName,
    required this.lastName,
    required this.positiveReviews,
    required this.status,
    required this.procedureType,
    required this.date,
    this.isFavorite = false,
  });
}