// ignore_for_file: non_constant_identifier_names
class Insurance{
  final int? id;
  final int? patient_id;
  final String insurance_name;
  final String effective_date;

  Insurance({
    this.id,
    required this.patient_id,
    required this.insurance_name,
    required this.effective_date
  });

  @override
  String toString() {
    var insuranceName = '$insurance_name';
    return insuranceName;
  }

  Map<String, dynamic> toJson() {
    return {
      "patient_id": patient_id,
      "insurance_name": insurance_name,
      "effective_date": effective_date
    };
  }

  factory Insurance.fromJson(Map<String, dynamic> json){
    final insurance = json['newInsurance'][0];
    return Insurance(
      id: insurance['insruance_id'],
      patient_id: insurance['patent_id'],
      insurance_name: insurance['insurance_name'],
      effective_date: insurance['effective_date']
    );
  }
}