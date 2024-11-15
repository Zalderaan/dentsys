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
    var fullName = '$firstName' '$lastName';
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
    final patient = json['newPatient'][0];
    return Patient(
      id: patient['patient_id'],
      firstName: patient['patient_firstName'],
      lastName: patient['patient_lastName'],
      middleName: patient['patient_middleName'],
      nickname: patient['patient_nickname'],
      birthDate: patient['patient_birthdate'],
      age: patient['patient_age'] is String 
        ? int.tryParse(patient['patient_age']) ?? 0 
        : patient['patient_age'] as int,
      sex: patient['patient_sex'],
      nationality: patient['patient_nationality'],
      religion: patient['patient_religion'],
      occupation:  patient['patient_occupation'],
      reason: patient['patient_reason'],
      balance: patient['patient_totalBal'],
      parentName: patient['patient_parentName'],
      parentOccupation: patient['patient_parentOccupation'],
      referrer: patient['patient_referrer']
    );
    // remember: balance temporarily removed
  }
}
