import 'package:dentsys_client/models/patient_conditions/patientConditions_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConditionsService {
    final String baseUrl = 'http://localhost:3000/dentsys-api/';

    Future<PatientConditions> addPatientConditionService(PatientConditions patientConditions) async {
        try {
            final headers = {
                'Content-Type': 'application/json',
            };
          final response = await http.put(
            Uri.parse('$baseUrl/change-patient-conditions'),
            headers: headers,
            body: jsonEncode(patientConditions.toJson()),
          );
          if (response.statusCode == 201) {
            return PatientConditions.fromJson(jsonDecode(response.body));
          } else {
            throw Exception('Failed to add patient condition: ${response.body}');
          }
        } catch (error) {
            print ('Error in service: $error');
            throw Exception('Error in service: $error');
        }
    }

    Future<void> deletePatientConditionService(PatientConditions patientConditions) async {
        try {
            final headers = {
                'Content-Type': 'application/json',
            };
            final response = await http.delete(
                Uri.parse('$baseUrl/delete-patient-conditions/${patientConditions.patient_id}'),
                headers: headers,
                body: jsonEncode(patientConditions.toJson()),
            );
            if (response.statusCode == 200) {
                print('Deleted patient condition');
            } else {
                throw Exception('Failed to delete patient condition: ${response.body}');
            }
        } catch (error) {
            print ('Error in service: $error');
            throw Exception('Error in service: $error');
        }
    }
}