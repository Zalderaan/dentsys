// ignore_for_file: non_constant_identifier_names
class Insurance{
  final int? id;
  final int patient_id;
  final String insurance_name;
  String? effective_date;

  Insurance({
    this.id,
    required this.patient_id,
    required this.insurance_name,
    this.effective_date
  });

  @override
  String toString() {
    var insuranceName = '$insurance_name + $effective_date + $patient_id';
    return insuranceName;
  }

  Map<String, dynamic> toJson() {
    return {
      "patient_id": patient_id,
      "insurance_name": insurance_name,
      'effective_date': effective_date?.isNotEmpty == true ? effective_date : null,
    };
  }

  factory Insurance.fromJson(Map<String, dynamic> json){
    // print('Insurance.fromJson: $json');
    final insurance = json['newInsurance'] != null ? json['newInsurance'][0] : json;

    return Insurance(
      id: insurance['insruance_id'],
      patient_id: insurance['patient_id'],
      insurance_name: insurance['insurance_name'],
      effective_date: insurance['effective_date']
    );
  }
}