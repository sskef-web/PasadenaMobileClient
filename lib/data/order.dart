class Order {
  final String headImageUrl;
  final String employeeImageUrl;
  final String title;
  final String employeeName;
  final DateTime dateTime;
  final int reservationStatus;

  Order({
    required this.headImageUrl,
    required this.employeeImageUrl,
    required this.title,
    required this.employeeName,
    required this.dateTime,
    required this.reservationStatus,
  });

  Order copyWith({
    String? headImageUrl,
    String? employeeImageUrl,
    String? title,
    String? employeeName,
    DateTime? dateTime,
    int? reservationStatus,
  }) {
    return Order(
      headImageUrl: headImageUrl ?? this.headImageUrl,
      employeeImageUrl: employeeImageUrl ?? this.employeeImageUrl,
      title: title ?? this.title,
      employeeName: employeeName ?? this.employeeName,
      dateTime: dateTime ?? this.dateTime,
      reservationStatus: reservationStatus ?? this.reservationStatus,
    );
  }
}
