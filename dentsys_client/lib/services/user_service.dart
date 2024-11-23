import '../models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = 'http://localhost:3000/dentsys-api'; // base url
  
  /* AUTH METHODS */
  
  // register
  Future<User> registerService(User user) async {
    const headers = {
      'Content-Type': 'application/json'
    };

    try{
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: headers,
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 201) {
        // var UserRegRes = jsonDecode(response.body);
        // print('in register $UserRegRes');
        return User.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to register user');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  // login
  Future<dynamic> loginService(User user) async {
    print("loginService accesesed");
    const headers = {
      'Content-Type': 'application/json'
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: headers,
        body: jsonEncode(user.toJson()),
      );
      
      if (response.statusCode == 200) {
        var userRes = jsonDecode(response.body);
        print(userRes);
        return User.fromJson(userRes);
      } else {
        var errorRes = jsonDecode(response.body);
        throw Exception(errorRes['error'] ?? 'Failed to login');
      }
    } catch (e) {
      throw Exception ('Error $e');
    }
  }

  // logout

  /* USER METHODS */
  // getCurrentUser
}