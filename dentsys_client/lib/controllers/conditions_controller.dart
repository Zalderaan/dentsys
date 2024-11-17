import '../models/patient_conditions/patientConditions_model.dart';
import '../services/conditions_service.dart';

class ConditionsController {
  final ConditionsService _conditionsService = ConditionsService();

  // POST
  Future <PatientConditions> addPatientCondition(PatientConditions patientConditions) async {
    try {
      final createdPatientCondition = await _conditionsService.addPatientConditionService(patientConditions);
      print('created patient condition: $createdPatientCondition');
      return createdPatientCondition;
    } catch (error ) {
      throw Exception('Error creating patient condition in frontend controller: $error');
    }
  }

  // GET
  // Future <PatientConditions> getPatientConditions(int patientId) async {
  //   try {
  //     final patientConditions = await _conditionsService.getPatientConditionsService(patientId);
  //     print('patient conditions: $patientConditions');
  //     return patientConditions;
  //   } catch (error) {
  //     throw Exception('Error getting patient conditions in frontend controller: $error');
  //   }
  // }
}