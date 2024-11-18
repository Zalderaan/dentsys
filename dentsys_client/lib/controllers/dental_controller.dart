import '../services/dental_service.dart';
import '../models/dental_model.dart';

class DentalController {
  final DentalService _dentalService = DentalService();

  Future<Dental> createDentalHistory(Dental dental) async {
    try {
      final createdDental = await _dentalService.addDentalService(dental);
      print('created dental from frontend controller: $createdDental');
      return createdDental; 
    } catch (error) {
      throw Exception('Error in dental frontend controller: $error');
    }
  }
}