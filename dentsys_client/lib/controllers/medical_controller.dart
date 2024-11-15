import '../models/medical_model.dart';
import '../services/medical_service.dart';

class MedicalController {
  final MedicalService _medicalService = MedicalService();

  // POST
  Future<Medical> createMedicalHistory(Medical medical) async {
    try {
      final createdPatient = await _medicalService.addMedicalService(medical);
      print('created medical from frontend controller: ${createdPatient.medical_id}');
      return createdPatient;
    } catch (error) {
      throw Exception('Error in medical frontend controller: $error');
    }
  }
}