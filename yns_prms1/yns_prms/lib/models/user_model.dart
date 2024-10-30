

class User {
  // properties
  final String? id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;

  // constructor
  User({
    this.id, // optional
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.password,
  });

  // factory constructor
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'password': password,
    };
  }
}