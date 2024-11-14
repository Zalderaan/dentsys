import '../models/patient_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PatientService {
  final String baseUrl = 'http://localhost:3000/dentsys-api'; // base url

  // add patient (POST)
  Future<Patient> addPatientService(Patient patient) async {
    const headers = {
      'Content-Type': 'application/json'
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add-patient'),
        headers: headers,
        body: jsonEncode(
          patient.toJson()
        ),
      );
      print(response.body);
      if (response.statusCode == 201) {
        return Patient.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to add patient: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error in service: $error');
    }
  }

  // TODO: use in patient details
  // get patient by id (GET)
  Future<Patient> getPatientByIdService(String patient_id) async {
    const headers = {
      'Content-Type': 'application/json'
    };

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/patients/$patient_id'),
        headers: headers
      );

      if (response.statusCode == 200) {
        return Patient.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load patient: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error in service: $error');
    }
  }

  // TODO use in patient list
  Future<List<Patient>> getAllPatientsService() async {
    const headers = {
      'Content-Type': 'applicaton/json'
    };

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/patients'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as List;
        final responseMap = responseData.map((data) => Patient.fromJson(data)).toList();
        return responseMap;
      } else {
        throw Exception('Failed to load patients: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error in getAllPatient service: $error');
    }
  }

  // TODO: use in patient update
  // PUT
  Future<void> updatePatientService(Patient patient) async {
    const headers = {
      'Content-Type': 'application/json'
    };

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/update-patient/${patient.id}'),
        headers: headers,
        body: jsonEncode(patient.toJson())
      );

      if(response.statusCode != 200){
        throw Exception('Failed to update patient: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error in updatePatient service: $error');
    }
  }

  // TODO use in patient delete (?)
  // DELETE
  Future<void> deletePatientService(String patient_id) async {
    const headers = {
      'Content-Type': 'application/json'
    };

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/delete-patient/$patient_id'),
        headers: headers,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete patient: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error deleting patient in service: $error');
    }
  }
}