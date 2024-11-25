import 'package:dentsys_client/models/patientTreatments-model.dart';
import 'package:dentsys_client/services/treatment_service.dart';

class TreatmentController {
  // POST
  final TreatmentService _treatmentService = TreatmentService();
  Future<PatientTreatment> createTreatment(PatientTreatment treatment) async {
    try {
      final createdTreatment = await _treatmentService.addTreatmentService(treatment);
      return createdTreatment;
    } catch (error) {
      throw Exception('Error creating treatment in frontend controller: $error');
    }
  }
}