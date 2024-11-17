import 'package:dentsys_client/models/patient_conditions/conditions_model.dart';

class PatientConditions {
  final int? patient_id;
  final List<Conditions> conditions;

  PatientConditions({
    this.patient_id,
    required this.conditions,
  });

  @override
  String toString() {
    return 'PatientConditions{patient_id: $patient_id, conditions: $conditions}';
  }

  factory PatientConditions.fromJson(Map<String, dynamic> json) {
    print('received in pcon fromJson: $json');
    List<Conditions> conditions = [];
    for (var condition in json['newPatientCondition']) {
      conditions.add(Conditions.fromJson(condition));
    }
    return PatientConditions(
      patient_id: json['patient_id'],
      conditions: conditions,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> conditions = [];
    for (var condition in this.conditions) {
      conditions.add(condition.toJson());
    }
    return {
      'patient_id': patient_id,
      'conditions': conditions,
    };
  }
}