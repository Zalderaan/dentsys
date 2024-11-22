import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/allergies_model.dart';

class AllergiesService {
  final String baseUrl = 'http://localhost:3000/dentsys-api';

  // POST
  Future<Allergies> addAllergyService(Allergies allergies) async {
      const headers = {
        'Content-Type': 'application/json',
      };
    
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add-allergies'),
        headers: headers,
        body: jsonEncode(allergies.toJson()),
      );
      // print (response.body);
      
      if (response.statusCode == 201) {
        return Allergies.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
          'Failed to create allergies: ${response.body}'
        );
      }
    } catch (error) {
      print('Error creating allergies in frontend service: $error');
      throw Exception('Error creating allergies in frontend service: $error');
    }
  }

  Future<void> updateAllergyService(Allergies allergies) async {
    const headers = {
      'Content-Type': 'application/json',
    };

    try {
      print('allergies.patient_id in fe service: ${allergies.patient_id}');
      final response = await http.put(
        Uri.parse('$baseUrl/update-allergies/${allergies.patient_id}'),
        headers: headers,
        body: jsonEncode(allergies.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception(
          'Failed to update allergies: ${response.body}'
        );
      }
    } catch (error) {
      print('Error updating allergies in frontend service: $error');
      throw Exception('Error updating allergies in frontend service: $error');
    }
  }
}