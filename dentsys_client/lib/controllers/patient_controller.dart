import 'package:dentsys_client/models/patientDetails_model.dart';
import 'package:dentsys_client/models/patient_model.dart';
import 'package:dentsys_client/services/patient_service.dart';

class PatientController {
  final PatientService _patientService = PatientService();
  Patient? _currentCreatePatient;
  
  // POST
  Future<Patient> createPatient(Patient patient) async {
    try {
      final createdPatient = await _patientService.addPatientService(patient);
      return createdPatient;
    } catch (error) {
      throw Exception('Error creating patient in frontend controller: $error');
    }
  }

  // GET
  Future<PatientDetails> getPatientById(String patient_id) async {
    try {
      final fetchedPatient = await _patientService.getPatientByIdService(patient_id);
      return fetchedPatient;
    } catch (error) {
      throw Exception('Error getting patient in frontend controller: $error');
    }
  }

  Future<List<Patient>> getPatients() async {
    try {
      final fetchedPatients = await _patientService.getAllPatientsService();
      return fetchedPatients;
    } catch (error) {
      print ('Error getting all patients in frontend controller: $error');
      throw Exception('Error getting all patients in frontend controller: $error');
    }
  }

  // PUT
  Future<void> updatePatient(Patient patient) async {
    try {
      await _patientService.updatePatientService(patient);
    } catch (error) {
      throw Exception('Error updating patient in frontend controller, $error');
    }
  }

  Future<void> deletePatient(String patient_id) async {
    try {
      await _patientService.deletePatientService(patient_id);
    } catch (error) {
      throw Exception('Error deleting patient in frontend controller, $error');
    }
  }
}