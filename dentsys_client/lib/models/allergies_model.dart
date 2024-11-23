class Allergies {
  final int? allergy_id;
  final int patient_id;
  final bool allergies_anesthetic;
  final bool allergies_penicillin;
  final bool allergies_sulfaDrugs;
  final bool allergies_aspirin;
  final bool allergies_latex;
  final String? allergies_others;

  Allergies({
    this.allergy_id,
    required this.patient_id,
    required this.allergies_anesthetic,
    required this.allergies_penicillin,
    required this.allergies_sulfaDrugs,
    required this.allergies_aspirin,
    required this.allergies_latex,
    this.allergies_others,
  });

  @override
  String toString(){
    print(
      'Allergies {\n'
      '  allergy_id: $allergy_id,\n'
      '  patient_id: $patient_id,\n'
      '  allergies_anesthetic: $allergies_anesthetic,\n'
      '  allergies_penicillin: $allergies_penicillin,\n'
      '  allergies_sulfaDrugs: $allergies_sulfaDrugs,\n'
      '  allergies_aspirin: $allergies_aspirin,\n'
      '  allergies_latex: $allergies_latex,\n'
      '  allergies_others: $allergies_others,\n'
      '}'
    ); 
    return 'Allergy: $allergy_id';
  }

  factory Allergies.fromJson(Map<String, dynamic> json) {
    // print('Allergies.fromJson: $json');
    final allergies = json['newAllergies'] != null ? json['newAllergies'][0] : json;
    return Allergies(
      allergy_id: allergies['allergies_id'],
      patient_id: allergies['patient_id'],
      allergies_anesthetic: allergies['allergies_anesthetic'] == 1,
      allergies_penicillin: allergies['allergies_penicillin'] == 1,
      allergies_sulfaDrugs: allergies['allergies_sulfaDrugs'] == 1,
      allergies_aspirin: allergies['allergies_aspirin'] == 1,
      allergies_latex: allergies['allergies_latex'] == 1,
      allergies_others: allergies['allergies_others'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'patient_id': patient_id,
      'allergies_anesthetic': allergies_anesthetic,
      'allergies_penicillin': allergies_penicillin,
      'allergies_sulfaDrugs': allergies_sulfaDrugs,
      'allergies_aspirin': allergies_aspirin,
      'allergies_latex': allergies_latex,
      'allergies_others': allergies_others,
    };
  }
}