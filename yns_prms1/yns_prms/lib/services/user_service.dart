import '../models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl;

  // constructor
  UserService({required this.baseUrl});

  // auth methods
  Future<User> login(String email, String password) async {
    
    try {
      final response = await http.get(Uri.parse('$baseUrl/login'));

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception ('Error $e');
    }
  }
}