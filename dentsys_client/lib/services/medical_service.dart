import '../models/medical_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MedicalService {
  final String baseUrl = 'http://localhost:3000/dentsys-api';

  // POST
  Future<Medical> addMedicalService(Medical medical) async {
    const headers = {
      'Content-Type': 'application/json'
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add-medical-history'),
        headers: headers,
        body: jsonEncode(medical.toJson())
      );
      if(response.statusCode == 201) {
        return Medical.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to add medical history: ${response.body}');
      }
    } catch (error) {
      print('Error in service: $error');
      throw Exception('Error in service: $error');
    }
  }

  Future<void> updateMedicalService(Medical medical) async {
    const headers = {
      'Content-Type': 'application/json'
    };

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/update-medical-history/${medical.patient_id}'),
        headers: headers,
        body: jsonEncode(medical.toJson())
      );

      if(response.statusCode != 200) {
        throw Exception('Failed to update medical history: ${response.body}');
      }
    } catch (error) {
      print('Error in service: $error');
      throw Exception ('Error in service: $error');
    }
  }
}