import 'package:dentsys_client/models/contact_model.dart';
import 'package:dentsys_client/services/contact_service.dart';

class ContactController {
  final ContactService _contactService = ContactService();

  Future<Contact> createContact(Contact contact) async {
    try {
      final createdContact = await _contactService.addContactService(contact);
      print('created contact: $createdContact');
      return createdContact;
    } catch (error) {
      throw Exception('Error creating contact in frontend controller: $error');
    }
  }
}