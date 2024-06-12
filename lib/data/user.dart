class User {
  final int id;
  final String firstName;
  final String lastName;
  final String avatar;
  final String email;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.email
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      avatar: json['avatar'],
      email: json['email'],
    );
  }
}