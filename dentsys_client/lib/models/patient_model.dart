class Patient {
  final int? id;
  final String firstName;
  final String lastName;
  final String middleName;
  final String? nickname;
  final String birthDate;
  final int age;
  final String? sex;
  final String nationality;
  final String religion;
  final String occupation;
  final String reason;
  final String? balance;
  final String? referrer;
  final String? parentName;
  final String? parentOccupation;

  Patient({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    this.nickname,
    required this.birthDate,
    required this.age,
    required this.sex,
    required this.nationality,
    required this.religion,
    required this. occupation,
    required this.reason,
    this.balance,
    this.referrer,
    this.parentName,
    this.parentOccupation
  });

  @override
  String toString() {
    var fullName = '$firstName ' '$lastName';
    return fullName;
  }

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "middleName": middleName,
      "nickname": nickname ?? "",
      "birthDate": birthDate,
      "age": age,
      "sex": sex,
      "nationality": nationality,
      "religion": religion,
      "occupation": occupation,
      "reason": reason,
      "balance": balance ?? "",
      "referrer": referrer ?? "",
      "parentName": parentName ?? "",
      "parentOccupation": parentOccupation ?? ""
    };
    // remember: balance temporarily removed
  }

  factory Patient.fromJson(Map<String, dynamic> json){
    // print ('received in fromJson patient: $json');
    final patientData = json['newPatient'] != null ? json['newPatient'][0] : json; // if 'newPatient' exists in json response, use it, else use json 
    // print('patient in fromJson: $patientData');
    // NOTE: newPatient is for add-patient, patient is for get-patient (next time be consistent in sending response data from backend)
    return Patient(
      id: patientData['patient_id'],
      firstName: patientData['patient_firstName'],
      lastName: patientData['patient_lastName'],
      middleName: patientData['patient_middleName'],
      nickname: patientData['patient_nickname'],
      birthDate: patientData['patient_birthdate'],
      age: patientData['patient_age'] is String 
        ? int.tryParse(patientData['patient_age']) ?? 0 
        : patientData['patient_age'] as int,
      sex: patientData['patient_sex'],
      nationality: patientData['patient_nationality'],
      religion: patientData['patient_religion'],
      occupation:  patientData['patient_occupation'],
      reason: patientData['patient_reason'],
      balance: patientData['patient_totalBal'],
      parentName: patientData['patient_parentName'],
      parentOccupation: patientData['patient_parentOccupation'],
      referrer: patientData['patient_referrer']
    );
    // remember: balance temporarily removed
  }
}
