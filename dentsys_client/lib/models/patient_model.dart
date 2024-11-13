class Patient {
  final int? id;
  final String firstName;
  final String lastName;
  final String middleName;
  final String? nickname;
  final String birthDate;
  final int age;
  final String sex;
  final String nationality;
  final String religion;
  final String occupation;
  final String reason;
  final int balance;
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
    required this.balance,
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
      "nickname": nickname,
      "birthDate": birthDate,
      "age": age,
      "sex": sex,
      "nationality": nationality,
      "religion": religion,
      "occupation": occupation,
      "reason": reason,
      "balance": balance,
      "parentName": parentName,
      "parentOccupation": parentOccupation
    };
  }

  factory Patient.fromJson(Map<String, dynamic> json){
    return Patient(
      id: json['patient_id'],
      firstName: json['patient_firstName'],
      lastName: json['patient_lastName'],
      middleName: json['patient_middleName'],
      nickname: json['patient_nickname'],
      birthDate: json['patient_birthDate'],
      age: json['patient_age'],
      sex: json['patient_sex'],
      nationality: json['patient_nationality'],
      religion: json['patient_religion'],
      occupation:  json['patient_occupation'],
      reason: json['patient_reason'],
      balance: json['patient_balance'],
      parentName: json['patient_parentName'],
      parentOccupation: json['patient_parentOccupation']
    );
  }
}
