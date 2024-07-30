import 'reservations.dart';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final List<Reservation> reservations;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.reservations,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var reservationList = json['reservations'] as List;
    List<Reservation> reservations =
    reservationList.map((reservation) => Reservation.fromJson(reservation)).toList();

    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      reservations: reservations,
    );
  }
}