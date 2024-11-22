class Conditions {
  final int condition_id;
  final bool patientCondition_status;
  
  Conditions({
    required this.condition_id,
    required this.patientCondition_status,
  });

  @override
  String toString() {
    return 'Conditions{condition_id: $condition_id, patientCondition_status: $patientCondition_status}';
  }

  factory Conditions.fromJson(Map<String, dynamic> json) {
    return Conditions(
      condition_id: json['condition_id'],
      patientCondition_status: json['patientCondition_status'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'condition_id': condition_id,
      'patientCondition_status': patientCondition_status,
    };
  }
}