class Contact {
  final int? id;
  final int patient_id;
  final String home_address;
  final String home_number;
  final String work_number;
  final String mobile_number;
  final String fax_number;
  final String email;

  Contact({
    this.id,
    required this.patient_id,
    required this.home_address,
    required this.home_number,
    required this.work_number,
    required this.mobile_number,
    required this.fax_number,
    required this.email,
  });
  
  @override
String toString() {
    return "contact_id = $id";
  }

  factory Contact.fromJson(Map<String, dynamic> json){
    // print ('data received in contact fromJson: $json');
    final contact = json['newContact'] != null ? json['newContact'][0] : json; // if 'newPatient' exists in json response, use it, else use json 
    return Contact(
      id: contact["contact_id"],
      patient_id: contact["patient_id"],
      home_address: contact["contact_homeAddress"],
      home_number: contact["contact_homeNo"],
      work_number: contact["contact_workNo"],
      mobile_number: contact["contact_mobileNo"],
      fax_number: contact["contact_faxNo"],
      email: contact["contact_email"]
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "patient_id": patient_id,
      "home_address": home_address,
      "home_number": home_number,
      "office_number": work_number,
      "mobile_number": mobile_number,
      "fax_number": fax_number,
      "email": email
    };
  }
}