import 'package:dentsys_client/models/patientTreatments-model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TreatmentService {
  final String baseUrl = 'http://localhost:3000/dentsys-api'; // base url
  
  // POST
  Future<PatientTreatment> addTreatmentService(PatientTreatment treatment) async {
    const headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add-treatment'),
        headers: headers,
        body: jsonEncode(treatment.toJson())
      );

      if (response.statusCode == 201) {
        return PatientTreatment.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to add procedure: ${response.body}');
      }

    } catch (error) {
      throw Exception('error in service: $error');
    }
  }
}