import 'package:dentsys_client/models/treatments_model.dart';
import 'package:dentsys_client/screens/login/responsive_widget.dart';
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

  Future<double> getPatientLastBalance(String patient_id) async {
    const headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get-last-balance/$patient_id'),
        headers: headers
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final double lastBalance = data['lastBalance'].toDouble();
        return lastBalance;
      } else {
        throw Exception('Failed to fetch last balance: ${response.body}');
      }
    } catch (error) {
      throw Exception('error in service: $error');
    }
  }

  Future<double> getBalanceBeforeTreatment(String patient_id, String treatment_id) async {
    const headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get-balance-before-treatment/$patient_id/$treatment_id'),
        headers: headers
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final double balanceBeforeTreatment = data['balBeforeTr'].toDouble();
        return balanceBeforeTreatment;
      } else {
        throw Exception('Failed to fetch balance before treatment: ${response.body}');
      }
    } catch (error) {
      throw Exception('error in service: $error');
    }
  }
  // UPDATE
  Future<void> updateTreatmentService(PatientTreatment treatment) async {
    const headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/update-treatment/${treatment.id}'),
        headers: headers,
        body: jsonEncode(treatment.toJson())
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update treatment: ${response.body}');
      }
    } catch (error) {
      throw Exception('error in service: $error');
    }
  }

  // DELETE
  Future<void> deleteTreatmentService(String treatment_id) async {
    const headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/delete-treatment/$treatment_id'),
        headers: headers
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete treatment: ${response.body}');
      }
    } catch (error) {
      throw Exception('error in service: $error');
    }
  }
}