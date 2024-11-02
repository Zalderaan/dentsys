import 'package:yns_prms/services/user_service.dart';
import 'package:yns_prms/models/user_model.dart';

class UserController {
  final UserService userService;

  UserController(this.userService); // constructor

  User? _currentUser; // priv var to hold the current user

  // register a user
  Future<String> register(User user) async {
    try {
      var registered = await userService.registerService(user);
      return 'User registered: ${registered.username}';
    } catch (e) {
      return 'Registration failed: $e';
    }
  }

  Future<dynamic> login(User user) async {
    try {
      _currentUser = await userService.loginService(user);
      print('Login response: $_currentUser'); // Debugging line
      if (_currentUser == null) {
        throw Exception("User not found");
      }
      return "User logged in: ${_currentUser!.username}";
    } catch (e) {
      print('current user: $_currentUser!.username');
      print('Login failed: $e');
      return 'Login failed: $e';
    }
  }

  Future<void> logout() async {
    _currentUser = null;
  }
}

