class User {
  // properties
  final String? id;
  final String? firstName;
  final String? lastName;
  final String username;
  final String? email;
  final String password;

  // constructor for registration
  User.registerCons({
    this.id, // optional
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.password,
  });

  // constructor for login
  User.loginCons({
    required this.username,
    required this.password,
  })  : id = null,
        email = null,
        firstName = null,
        lastName = null;

  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName, username: $username, email: $email, password: $password}';
  }

  // factory constructor
  factory User.fromJson(Map<String, dynamic> json) {
    print('User.fromJson: $json');
    // Adjust to match your API response structure for login
    if (json.containsKey('user')) {
      var userJson = json['user'];
      return User.registerCons(
        id: userJson['user_id'].toString(),
        email: userJson['user_email'],
        firstName: userJson['user_firstName'],
        lastName: userJson['user_lastName'],
        username: userJson['user_username'],
        password: userJson['user_password'], // Consider whether you want this
      );
    } else {
      return User.loginCons(
        username: json['username'],
        password: json['password'],
      );
    }
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
