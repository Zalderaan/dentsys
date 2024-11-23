import 'package:dentsys_client/services/user_service.dart';
import 'package:dentsys_client/models/user_model.dart';

class UserController {
  final UserService userService;

  UserController(this.userService); // constructor

  User? _currentUser; // priv var to hold the current user

  // register a user
  Future<dynamic> register(User user) async {
    try {
      var registered = await userService.registerService(user);
      // print('User registered: $registered');
      return 'User registered: ${registered.username}';
    } catch (e) {
      return 'Registration failed: $e';
    }
  }

  Future<dynamic> login(User user) async {
    try {
      _currentUser = await userService.loginService(user);
      if (_currentUser == null) {
        throw Exception("User not found");
      }
      print('current user: $_currentUser'); 

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

