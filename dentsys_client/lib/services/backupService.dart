import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BackupService{
  Future<void> backupDataService(String? path) async {
    print('path in service: $path');
    path = path!.replaceAll('\\', '/');
    print('path in service after shit: $path');
    final String baseUrl = 'http://localhost:3000/dentsys-api/'; 
    try {
      const headers = {
        'Content-Type': 'application/json',
      };

      final response = await http.post(
        Uri.parse('$baseUrl/backup'),
        body: jsonEncode({
          'path': path,
          }),
        headers: headers
      );

      if (response.statusCode == 200) {
        print('Data backed up successfully');
      } else {
        throw Exception('Failed to back up data: ${response.body}');
      }
    } catch (error) {
      print('Error backing up data in frontend service: $error');
      throw Exception('Error backing up data in frontend service: $error');
    }
  }

  Future<void> restoreDataService(String path) async {
    print('path: $path');    
    final String baseUrl = 'http://localhost:3000/dentsys-api/';
    try {
      const headers = {
        'Content-Type': 'application/json'
      };

      final response = await http.post(
        Uri.parse('$baseUrl/restore'),
        body: jsonEncode({
          'path': path,
        }),
        headers: headers 
      );

      if (response.statusCode == 200) {
        print('Data restored successfully');
      } else {
        throw Exception('Failed to restore data: ${response.body}');
      }
    } catch (error) {
      print('Error in service: $error');
      throw Exception('Error in service: $error');
    }
  }
}