class PatientTreatment {
  final int? id;
  final int patient_id;
  final String treatment_prcdName;
  final String treatment_dentist;
  final double treatment_charged;
  final double treatment_paid;
  final double treatment_balance;
  final String? treatment_date;
  final String treatment_toothNo;

  PatientTreatment({
    this.id,
    required this.patient_id,
    required this.treatment_prcdName,
    required this.treatment_dentist,
    required this.treatment_charged,
    required this.treatment_paid,
    required this.treatment_balance,
    required this.treatment_toothNo,
    this.treatment_date
  });

  Map<String, dynamic> toJson() {
    return{
      "treatment_id": id,
      "patient_id": patient_id,
      "treatment_prcdName": treatment_prcdName,
      "treatment_dentist": treatment_dentist,
      "treatment_charged": treatment_charged,
      "treatment_paid": treatment_paid,
      "treatment_balance": treatment_balance,
      "treatment_date": treatment_date,
      "treatment_toothNo": treatment_toothNo
    };
  }

  factory PatientTreatment.fromJson(Map<String, dynamic> json){
    print('patientTreatment.fromJson: $json');
    final treatmentData = json['newTreatment'] != null ? json['newTreatment'] : json;
    
    return PatientTreatment(
      id: treatmentData['treatment_id'],
      patient_id: treatmentData['patient_id'],
      treatment_prcdName: treatmentData['treatment_prcdName'],
      treatment_dentist: treatmentData['treatment_dentist'],
      treatment_charged: double.parse(treatmentData['treatment_charged'].toString()),
      treatment_paid: double.parse(treatmentData['treatment_paid'].toString()),
      treatment_balance: double.parse(treatmentData['treatment_balance'].toString()),
      treatment_date: treatmentData['treatment_date'],
      treatment_toothNo: treatmentData['treatment_toothNo']
    );
  }
}