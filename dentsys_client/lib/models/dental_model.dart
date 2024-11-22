// ignore_for_file: non_constant_identifier_names

class Dental {
  final int? id;
  final int? patient_id;
  final String previous_dentist;
  final String last_visit;

  Dental({
    this.id,
    this.patient_id,
    required this.previous_dentist,
    required this.last_visit,
  });

  @override
  String toString() {
    return 'Dental{dental_id: $id, patient_id: $patient_id, previous_dentist: $previous_dentist, last_visit: $last_visit}';
  }

  factory Dental.fromJson(Map<String, dynamic> json) {
    print('data received in dental fromJson: $json');
    final dental = json['newDentalHistory'] != null ? json['newDentalHistory'][0] : json; // 
    return Dental(
      id: dental['dental_id'],
      patient_id: dental['patient_id'],
      previous_dentist: dental['dental_previousDentist'],
      last_visit: dental['dental_lastVisit'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'patient_id': patient_id,
      'previous_dentist': previous_dentist,
      'last_visit': last_visit,
    };
  }
}