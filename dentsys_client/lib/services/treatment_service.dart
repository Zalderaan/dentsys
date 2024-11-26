import 'package:dentsys_client/models/treatments_model.dart';
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

  // GET
  Future<List<PatientTreatment>> getPatientTreatmentsService(String patient_id) async {
    const headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get-treatments/$patient_id'),
        headers: headers
      );

      // map response to a list of patient treatments
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final treatments = (data['treatments'] as List)
            .map((treatment) => PatientTreatment.fromJson(treatment))
            .toList();
        return treatments;
      } else {
        throw Exception('Failed to fetch treatments: ${response.body}');
      }
    } catch (error) {
      throw Exception('error in service: $error');
    }
  }
}