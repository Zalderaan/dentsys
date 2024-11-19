// ignore_for_file: non_constant_identifier_names

class Medical{
  final int? medical_id;
  final int patient_id;
  final String medical_physician;
  final String? medical_physicianSpec;
  final String medical_officeAddress;
  final String medical_officeNo;
  final bool medical_goodHealth;
  final bool medical_isUnderTreatment;
  final String? medical_treatmentDetails;
  final bool medical_seriousOperation;
  final String? medical_seriousOperationDetails;
  final bool medical_hospitalized;
  final String? medical_hospitalizedDetails;
  final bool medical_isMedication;
  final String? medical_medicationDetails;
  final bool medical_isTobacco;
  final bool medical_dangerousSubstance;
  final String medical_bleedingTime;
  final String medical_bloodPressure;
  final String medical_bloodType;
  final bool? medical_isPregnant;
  final bool? medical_isNursing;
  final bool? medical_isBirthControl;

  Medical({
    this.medical_id,
    required this.patient_id,
    required this.medical_physician,
    this.medical_physicianSpec,
    required this.medical_officeAddress,
    required this.medical_officeNo,
    required this.medical_goodHealth,
    required this.medical_isUnderTreatment,
    this.medical_treatmentDetails,
    required this.medical_seriousOperation,
    this.medical_seriousOperationDetails,
    required this.medical_hospitalized,
    this.medical_hospitalizedDetails,
    required this.medical_isMedication,
    this.medical_medicationDetails,
    required this.medical_isTobacco,
    required this.medical_dangerousSubstance,
    required this.medical_bleedingTime,
    required this.medical_bloodPressure,
    required this.medical_bloodType,
    this.medical_isPregnant,
    this.medical_isNursing,
    this.medical_isBirthControl,
  });

@override
String toString() {
  // print (
  //   'Medical {\n'
  //   '  medical_id: $medical_id,\n'
  //   '  patient_id: $patient_id,\n'
  //   '  medical_physician: $medical_physician,\n'
  //   '  medical_physicianSpec: $medical_physicianSpec,\n'
  //   '  medical_officeAddress: $medical_officeAddress,\n'
  //   '  medical_officeNo: $medical_officeNo,\n'
  //   '  medical_goodHealth: $medical_goodHealth,\n'
  //   '  medical_isUnderTreatment: $medical_isUnderTreatment,\n'
  //   '  medical_treatmentDetails: $medical_treatmentDetails,\n'
  //   '  medical_seriousOperation: $medical_seriousOperation,\n'
  //   '  medical_seriousOperationDetails: $medical_seriousOperationDetails,\n'
  //   '  medical_hospitalized: $medical_hospitalized,\n'
  //   '  medical_hospitalizedDetails: $medical_hospitalizedDetails,\n'
  //   '  medical_isMedication: $medical_isMedication,\n'
  //   '  medical_medicationDetails: $medical_medicationDetails,\n'
  //   '  medical_isTobacco: $medical_isTobacco,\n'
  //   '  medical_dangerousSubstance: $medical_dangerousSubstance,\n'
  //   '  medical_bleedingTime: $medical_bleedingTime,\n'
  //   '  medical_bloodPressure: $medical_bloodPressure,\n'
  //   '  medical_bloodType: $medical_bloodType,\n'
  //   '  medical_isPregnant: $medical_isPregnant,\n'
  //   '  medical_isNursing: $medical_isNursing,\n'
  //   '  medical_isBirthControl: $medical_isBirthControl\n'
  //   '}'
  // );
  return 'id: $medical_id';
}

  factory Medical.fromJson(Map<String, dynamic> json){
    print('Medical.fromJson: $json');
    final medical = json['newMedicalHistory'] != null ? json['newMedicalHistory'][0] : json;
    return Medical(
      medical_id: medical['medical_id'],
      patient_id: medical['patient_id'],
      medical_physician: medical['medical_physician'], 
      medical_physicianSpec: medical['medical_physicianSpec'],
      medical_officeAddress: medical['medical_officeAddress'], 
      medical_officeNo: medical['medical_officeNo'], 
      medical_goodHealth: medical['medical_goodHealth'] == 1, // tinyint to bool conversion 
      medical_isUnderTreatment: medical['medical_isUnderTreatment'] == 1, 
      medical_treatmentDetails: medical['medical_treatmentDetails'],
      medical_seriousOperation: medical['medical_seriousOperation'] == 1, 
      medical_seriousOperationDetails: medical['medical_seriousOperationDetails'],
      medical_hospitalized: medical['medical_hospitalized'] == 1, 
      medical_hospitalizedDetails: medical['medical_hospitalizedDetails'],
      medical_isMedication: medical['medical_isMedication'] ==1 , 
      medical_medicationDetails: medical['medical_medicationDetails'],
      medical_isTobacco: medical['medical_isTobacco'] == 1, 
      medical_dangerousSubstance: medical['medical_dangerousSubstance'] == 1, 
      medical_bleedingTime: medical['medical_bleedingTime'] is int
        ? medical['medical_bleedingTime'].toString()
        : medical['medical_bleedingTime'], 
      medical_bloodPressure: medical['medical_bloodPressure'], 
      medical_bloodType: medical['medical_bloodType']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'patient_id': patient_id,
      'medical_physician': medical_physician,
      'medical_physicianSpec': medical_physicianSpec,
      'medical_officeAddress': medical_officeAddress,
      'medical_officeNo': medical_officeNo,
      'medical_goodHealth': medical_goodHealth,
      'medical_isUnderTreatment': medical_isUnderTreatment,
      'medical_treatmentDetails': medical_treatmentDetails,
      'medical_seriousOperation': medical_seriousOperation,
      'medical_seriousOperationDetails': medical_seriousOperationDetails,
      'medical_hospitalized': medical_hospitalized,
      'medical_hospitalizedDetails': medical_hospitalizedDetails,
      'medical_isMedication': medical_isMedication,
      'medical_medicationDetails': medical_medicationDetails,
      'medical_isTobacco': medical_isTobacco,
      'medical_dangerousSubstance': medical_dangerousSubstance,
      'medical_bleedingTime': medical_bleedingTime,
      'medical_bloodPressure': medical_bloodPressure,
      'medical_bloodType': medical_bloodType,
      'medical_isPregnant': medical_isPregnant,
      'medical_isNursing': medical_isNursing,
      'medical_isBirthControl': medical_isBirthControl
    };
  }
}