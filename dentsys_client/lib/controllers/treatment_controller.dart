import 'package:dentsys_client/models/treatments_model.dart';
import 'package:dentsys_client/services/treatment_service.dart';

class TreatmentController {
  final TreatmentService _treatmentService = TreatmentService();
  
  // POST
  Future<PatientTreatment> createTreatment(PatientTreatment treatment) async {
    try {
      final createdTreatment = await _treatmentService.addTreatmentService(treatment);
      return createdTreatment;
    } catch (error) {
      throw Exception('Error creating treatment in frontend controller: $error');
    }
  }

  // GET
  Future<List<PatientTreatment>> getPatientTreatments(String patient_id) async {
    try {
      final treatments = await _treatmentService.getPatientTreatmentsService(patient_id);
      return treatments;
    } catch (error) {
      throw Exception('Error getting treatments in frontend controller: $error');
    }
  }
}