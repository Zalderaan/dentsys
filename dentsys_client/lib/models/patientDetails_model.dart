import 'package:dentsys_client/models/allergies_model.dart';
import 'package:dentsys_client/models/contact_model.dart';
import 'package:dentsys_client/models/dental_model.dart';
import 'package:dentsys_client/models/insurance_model.dart';
import 'package:dentsys_client/models/medical_model.dart';
import 'package:dentsys_client/models/patient_conditions/conditions_model.dart';
import 'package:dentsys_client/models/patient_model.dart';

class PatientDetails {
  final Patient patient;
  final Contact contact;
  final Dental dental;
  final Insurance insurance;
  final Medical medical;
  final Allergies allergies;
  final List<Conditions> conditions;

  PatientDetails({
    required this.patient,
    required this.contact,
    required this.dental,
    required this.insurance,
    required this.medical,
    required this.allergies,
    required this.conditions,
  });

  @override
  String toString() {
    return 'PatientDetails: $patient, $contact, $dental, $insurance, $medical, $allergies, $conditions';
  }

  factory PatientDetails.fromJson(Map<String, dynamic> json) {
    final patient_details = json['patientDetails'];
    var patient = Patient.fromJson(patient_details['patient'][0]);
    var contact = Contact.fromJson(patient_details['contact'][0]);
    var dental = Dental.fromJson(patient_details['dentalHistory'][0]);
    var insurance = Insurance.fromJson(patient_details['insurance'][0]);
    var allergies = Allergies.fromJson(patient_details['allergies'][0]);
    var medical = Medical.fromJson(patient_details['medicalHistory'][0]);
    var conditions = (patient_details['patientCondition'] as List<dynamic>)
          .map((e) => Conditions.fromJson(e))
          .toList();
    
    // if (patient != null){
    //   print(patient);
    // } else {
    //   print('Patient is null');
    // }

    // if (contact != null){
    //   print(contact);
    // } else {
    //   print('Contact is null');
    // }

    // if (dental != null){
    //   print(dental);
    // } else {
    //   print('Dental is null');
    // }

    // if (insurance != null){
    //   print(insurance);
    // } else {
    //   print('Insurance is null');
    // }

    // if (allergies != null){
    //   print(allergies);
    // } else {
    //   print('Allergies is null');
    // }

    // if (medical != null){
    //   print(medical);
    // } else {
    //   print('Medical is null');
    // }

    // if (conditions != null){
    //   print(conditions);
    // } else {
    //   print('Conditions is null');
    // }
    
    return PatientDetails(
      patient: patient,
      contact: contact,
      dental: dental,
      insurance: insurance,
      medical: medical,
      allergies: allergies,
      conditions: conditions,
    );
  }
}