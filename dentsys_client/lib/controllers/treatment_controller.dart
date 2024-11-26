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

  Future<double> getPatientLastBalance(String patient_id) async {
    try {
      final lastTreatment = await _treatmentService.getPatientLastBalance(patient_id);
      return lastTreatment;
    } catch (error) {
      throw Exception('Error getting last treatment in frontend controller: $error');
    }
  }

  // DELETE
  Future<void> deleteTreatment(String treatment_id) async {
    try {
      final deletedTreatment = await _treatmentService.deleteTreatmentService(treatment_id);
    } catch (error) {
      throw Exception('Error deleting treatment in frontend controller: $error');
    }
  }
}