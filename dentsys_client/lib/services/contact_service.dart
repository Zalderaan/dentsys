import "../models/contact_model.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;

class ContactService {
  final String baseUrl = 'http://localhost:3000/dentsys-api';
  
  Future<Contact> addContactService(Contact contact) async {
    const headers = {
      'Content-Type': 'application/json'
    };

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add-contact'),
        headers: headers,
        body: jsonEncode(contact.toJson())
      );
      print(response.body);
      if(response.statusCode == 201) {
        return Contact.fromJson(jsonDecode(response.body));
      } else {
        throw Exception ('Failed to add contact: ${response.body}');
      }

    } catch (error) {
      throw Exception('Error in contact service: $error');
    }
  }
}