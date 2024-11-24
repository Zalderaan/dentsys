import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dentsys_client/models/procedure_model.dart';

class ProcedureService {
  final String baseUrl = 'http://localhost:3000/dentsys-api'; // base URL

  // Add procedure (POST)
  Future<Procedure> addProcedureService(Procedure procedure) async {
    const headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add-procedure'),
        headers: headers,
        body: jsonEncode(procedure.toJson()),
      );

      if (response.statusCode == 201) {
        return Procedure.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to add procedure: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error in service: $error');
    }
  }

  // Get all procedures (GET)
  Future<List<Procedure>> getAllProceduresService() async {
    const headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get-procedures'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final procedures = (data['procedures'] as List)
            .map((procedure) => Procedure.fromJson(procedure))
            .toList();
        return procedures;
      } else {
        throw Exception('Failed to fetch procedures: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error in getAllProcedures service: $error');
    }
  }

  // Update procedure (PUT)
  Future<void> updateProcedureService(Procedure procedure) async {
    const headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.put(
        Uri.parse('$baseUrl/update-procedure/${procedure.id}'),
        headers: headers,
        body: jsonEncode(procedure.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update procedure: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error in updateProcedure service: $error');
    }
  }

  // Delete procedure (DELETE)
  Future<void> deleteProcedureService(String procedureId) async {
    const headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/delete-procedure/$procedureId'),
        headers: headers,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete procedure: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error in deleteProcedure service: $error');
    }
  }
}
