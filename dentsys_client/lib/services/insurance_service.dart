import '../models/insurance_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InsuranceService {
  final String baseUrl = 'http://localhost:3000/dentsys-api';

  // POST
  Future<Insurance> addInsuranceService(Insurance insurance) async {
    const headers = {
      'Content-Type': 'application/json'
    };

    try {

      final response = await http.post(
        Uri.parse('$baseUrl/add-insurance'),
        headers: headers,
        body: jsonEncode(insurance.toJson())
      );

      if (response.statusCode == 201){
        // print('data returned to service: ${response.body}');
        return Insurance.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to add insurance ${response.body}');
      }
    } catch (error) {
      print('Error in service: $error');
      throw Exception('Error in service: $error');
    }
  }
}