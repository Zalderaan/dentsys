import 'package:dentsys_client/models/patientDetails_model.dart';
import 'package:dentsys_client/screens/reports/forms/allergies_forms.dart';
import 'package:dentsys_client/screens/reports/forms/contact_info_forms.dart';
import 'package:dentsys_client/screens/reports/forms/dental_history_forms.dart';
import 'package:dentsys_client/screens/reports/forms/dental_insurance_forms.dart';
import 'package:dentsys_client/screens/reports/forms/diseases_forms.dart';
import 'package:dentsys_client/screens/reports/forms/medical_history_forms.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dentsys_client/screens/reports/forms/personal_info_forms.dart';

import 'package:dentsys_client/models/patient_model.dart';
import 'package:dentsys_client/controllers/patient_controller.dart';

import 'package:dentsys_client/models/contact_model.dart';
import 'package:dentsys_client/controllers/contact_controller.dart';

import 'package:dentsys_client/models/insurance_model.dart';
import 'package:dentsys_client/controllers/insurance_controller.dart';

import 'package:dentsys_client/models/dental_model.dart';
import 'package:dentsys_client/controllers/dental_controller.dart';

import 'package:dentsys_client/models/medical_model.dart';
import 'package:dentsys_client/controllers/medical_controller.dart';

import 'package:dentsys_client/models/allergies_model.dart';


class ReportsScreen extends StatefulWidget {
  final int? patient_id;
  const ReportsScreen({super.key , this.patient_id});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final PatientController patientController = PatientController();
  PatientDetails? patientDetails;
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    loadPatientDetails();
  }

  // get patient details
  void loadPatientDetails() async {
    try {
      final details = await patientController.getPatientById(widget.patient_id.toString());
      setState(() {
        patientDetails = details;
        isLoading = false;
      });
    } catch (error) {
      print('Error getting patient details: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    
    // int? patientId = widget.patient_id;
    // final patient = patientDetails.patient;
    // final contact = patientDetails.contact;
    // final dental = patientDetails.dental;
    // final insurance = patientDetails.insurance;
    // final medical = patientDetails.medical;
    // final allergies = patientDetails.allergies;
    // final conditions = patientDetails.conditions;
    // print('patient id in reports: $patientId'); //debug line
    
    return Material(
      child: SizedBox(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // TITLE
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Patient Record",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 66, 43, 21),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),

                // MAIN ROW CONTAINER FOR DETAILS, TREATMENT, APPOINTMENTS
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    // DETAILS CONTAINER
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Details",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 66, 43, 21),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFFE2AD5E), Color(0xFF422B15)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      _showEditPatientFormsDialog(context, patientDetails!);
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      "Edit Details",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                //const SizedBox(width:400),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            Divider(
                                        height: 10,
                                        color: Colors.grey[800],
                                        thickness: 0.5,
                                      ),
                            const SizedBox(height: 10),
                            
                            
                            
                            patientDetails == null
                                  ? const Text('No patient data available')
                                  : buildPatientDetails(patientDetails!),
                            // Details Fields
                            // FutureBuilder<PatientDetails>(
                            //   future: fetchPatientDetails(patientId!), // Replace 9 with the relevant patient ID
                            //   builder: (context, snapshot) {
                            //     if (snapshot.connectionState == ConnectionState.waiting) {
                            //       return const Center(child: CircularProgressIndicator());
                            //     } else if (snapshot.hasError) {
                            //       return Center(child: Text('Error: ${snapshot.error}'));
                            //     } else if (!snapshot.hasData || snapshot.data == null) {
                            //       return const Center(child: Text('No data available'));
                            //     } else {
                            //       return Row(
                            //         mainAxisAlignment: MainAxisAlignment.start,
                            //         children: [
                            //           Column(
                            //             mainAxisAlignment: MainAxisAlignment.start,
                            //             children: [
                            //               buildInfoSection("Name", patient.firstName),
                            //               const SizedBox(height: 15.0),
                                          
                            //               buildInfoSection("Age", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Age", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Birthdate", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Gender", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Occupation", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Home Address", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Contact Number", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Email Address", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Fax Number", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Blood Type", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Allergies", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Diseases", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Age", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Age", "21"),
                            //               const SizedBox(height: 15.0),
                            //             ],
                            //           ),
                            //           const SizedBox(width: 300),

                            //           Column(
                            //             mainAxisAlignment: MainAxisAlignment.start,
                            //             children: [
                            //               buildInfoSection("Name", "Erix"),
                            //               const SizedBox(height: 15.0),
                                          
                            //               buildInfoSection("Age", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Age", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Birthdate", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Gender", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Occupation", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Home Address", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Contact Number", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Email Address", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Fax Number", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Blood Type", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Allergies", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Diseases", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Age", "21"),
                            //               const SizedBox(height: 15.0),

                            //               buildInfoSection("Age", "21"),
                            //               const SizedBox(height: 15.0),
                            //             ],
                            //           ),
                            //         ],
                            //       );
                            //     }
                            //   }
                            // )   

                            
                            

                          ],
                        ),
                      ),
                    ),
                    
                    
                    const SizedBox(width: 15.0),

                    // COLUMN FOR TREATMENT RECORD AND APPOINTMENTS
                    Expanded(
                      child: Column(
                        children: [
                          // TREATMENT RECORD CONTAINER
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      "Treatment Record",
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Divider(
                                  height: 10,
                                  color: Colors.grey[800],
                                  thickness: 0.5,
                                ),
                                const SizedBox(height: 5),
                                
                                // Table Headers
                                Table(
                                  columnWidths: const {
                                    0: FlexColumnWidth(3),  // Date-Time
                                    1: FlexColumnWidth(4),  // Procedure
                                    2: FlexColumnWidth(2),  // Price
                                  },
                                  border: TableBorder.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                  children: const [
                                    TableRow(
                                      
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Date-Time",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Procedure",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Price",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    
                                    // Example Row (Replace with dynamic data rows as needed)
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("2024-11-10 14:30"),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("Cleaning"),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("₱500"),
                                        ),
                                      ],
                                    ),
                                    // Additional rows can go here
                                  ],
                                ),

                                const SizedBox(height: 10.0),

                                // Totals Row
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Text(
                                      "Total Remaining Balance:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

              
                          const SizedBox(height: 15.0),

                          // APPOINTMENTS CONTAINER
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      "Appointments",
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                      Divider(
                                        height: 10,
                                        color: Colors.grey[800],
                                        thickness: 0.5,
                                      ),
                                const SizedBox(height: 10),

                                Table(
                                  columnWidths: const {
                                    0: FlexColumnWidth(3),  // Date-Time
                                    1: FlexColumnWidth(4),  // Procedure
                                    2: FlexColumnWidth(2),  // Price
                                  },
                                  border: TableBorder.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                  children: const [
                                    TableRow(
                                      
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Date-Time",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Procedure",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Price",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    
                                    // Example Row (Replace with dynamic data rows as needed)
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("2024-11-10 14:30"),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("Cleaning"),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("₱500"),
                                        ),
                                      ],
                                    ),
                                    // Additional rows can go here
                                  ],
                                ),


                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  fetchPatientDetails(int i) {

  }
}

// Edit Patient Forms
void _showEditPatientFormsDialog(BuildContext context, PatientDetails details) {
  final GlobalKey<FormState> dialogPersonalInfoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> dialogContactInfoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> dialogDentalInsuranceFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> dialogDentalHistoryFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> dialogMedicalHistoryFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> dialogAllergiesFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> dialogDiseasesFormKey = GlobalKey<FormState>();
  
  // patient personal info
  final TextEditingController _dialogFirstNameController = TextEditingController(text: details.patient.firstName);
  final TextEditingController _dialogLastNameController = TextEditingController(text: details.patient.lastName);
  final TextEditingController _dialogMiddleNameController = TextEditingController(text: details.patient.middleName);
  final TextEditingController _dialogNicknameController = TextEditingController(text: details.patient.nickname);
  final TextEditingController _dialogSexController = TextEditingController(text: details.patient.sex);
  final TextEditingController _dialogAgeController = TextEditingController(text: details.patient.age.toString());
  final TextEditingController _dialogBirthdateController = TextEditingController(text: details.patient.birthDate);
  final TextEditingController _dialogNationalityController = TextEditingController(text: details.patient.nationality);
  final TextEditingController _dialogOccupationController = TextEditingController(text: details.patient.occupation);
  final TextEditingController _dialogReligionController = TextEditingController(text: details.patient.religion);
  final TextEditingController _dialogReasonController = TextEditingController(text: details.patient.reason);
  final TextEditingController _dialogReferrerController = TextEditingController(text: details.patient.referrer);
  final TextEditingController _guardianNameController = TextEditingController(text: details.patient.parentName);
  final TextEditingController _guardianOccupationController = TextEditingController(text: details.patient.parentOccupation);
  late PatientController patientController = PatientController();

  // contact info
  final TextEditingController _emailController = TextEditingController(text: details.contact.email);
  final TextEditingController _homeAddressController = TextEditingController(text: details.contact.home_address);
  final TextEditingController _homeNoController = TextEditingController(text: details.contact.home_number);
  final TextEditingController _faxNoController = TextEditingController(text: details.contact.fax_number);
  final TextEditingController _workNoController = TextEditingController(text: details.contact.work_number);
  final TextEditingController _mobileNoController = TextEditingController(text: details.contact.mobile_number);
  late ContactController contactController = ContactController(); // contact controller

  // insurance
  final TextEditingController dialogInsuranceNameController = TextEditingController(text: details.insurance.insurance_name);
  final TextEditingController dialogEffectiveDateController = TextEditingController(text: details.insurance.effective_date);
  late InsuranceController insuranceController = InsuranceController(); // insurance controller
  
  // dental history
  final TextEditingController dialogPreviousDentistController = TextEditingController(text: details.dental.previous_dentist);
  final TextEditingController dialogLatestVisitController = TextEditingController(text: details.dental.last_visit);
  late DentalController dentalController = DentalController(); // dental controller

  // medical history
  final TextEditingController dialogPhysicianController = TextEditingController(text: details.medical.medical_physician);
  final TextEditingController dialogPhysicianSpecController = TextEditingController(text: details.medical.medical_physicianSpec);
  final TextEditingController dialogOfficeAddressController = TextEditingController(text: details.medical.medical_officeAddress);
  final TextEditingController dialogOfficeNoController = TextEditingController(text: details.medical.medical_officeNo);  

  final TextEditingController dialogBloodTypeController = TextEditingController(text: details.medical.medical_bloodType);
  final TextEditingController dialogBloodPressureController = TextEditingController(text: details.medical.medical_bloodPressure);
  final TextEditingController dialogBleedingTimeController = TextEditingController(text: details.medical.medical_bleedingTime);

  final TextEditingController dialogTobaccoController = TextEditingController(text: details.medical.medical_isTobacco.toString());
  final TextEditingController dialogAlcoholController = TextEditingController(text: details.medical.medical_dangerousSubstance.toString());
  final TextEditingController dialogMedicationController = TextEditingController(text: details.medical.medical_isMedication.toString());
  final TextEditingController dialogHospitalizedController = TextEditingController(text: details.medical.medical_hospitalized.toString());
  final TextEditingController dialogSeriousOperationController = TextEditingController(text: details.medical.medical_seriousOperation.toString());
  final TextEditingController dialogPregnantController = TextEditingController(text: details.medical.medical_isPregnant.toString());
  final TextEditingController dialogBirthControlController = TextEditingController(text: details.medical.medical_isBirthControl.toString());
  final TextEditingController dialogNursingController = TextEditingController(text: details.medical.medical_isNursing.toString());
  late MedicalController medicalController = MedicalController(); // medical controller
  
  Future<void> saveUpdatePatient() async {
    final updatedPatient = Patient(
      id: details.patient.id,
      firstName: _dialogFirstNameController.text,
      lastName: _dialogLastNameController.text,
      middleName: _dialogMiddleNameController.text,
      nickname: _dialogNicknameController.text,
      birthDate: _dialogBirthdateController.text,
      age: int.parse(_dialogAgeController.text),
      sex: _dialogSexController.text,
      nationality: _dialogNationalityController.text,
      religion: _dialogReligionController.text,
      occupation: _dialogOccupationController.text,
      reason: _dialogReasonController.text,
      balance: details.patient.balance,
      referrer: _dialogReferrerController.text,
      parentName: _guardianNameController.text,
      parentOccupation: _guardianOccupationController.text,
    );

    try {
      await patientController.updatePatient(updatedPatient);
      print('Patient updated successfully');
    } catch (error) {
      print('Error updating patient: $error');
    }
  }

  Future<void> saveUpdateContact() async {
    final updatedContact = Contact(
      patient_id: details.contact.patient_id,
      email: _emailController.text, 
      home_address: _homeAddressController.text,
      home_number: _homeNoController.text,
      fax_number: _faxNoController.text,
      work_number: _workNoController.text,
      mobile_number: _mobileNoController.text,
    );

    try {
      await contactController.updateContact(updatedContact);
      print('Contact updated successfully');
    } catch (error) {
      print('Error updating contact: $error');
    }
  }
  
  Future<void> saveUpdateInsurance() async {
    final updatedInsurance = Insurance(
      patient_id: details.insurance.patient_id,
      insurance_name: dialogInsuranceNameController.text,
      effective_date: dialogEffectiveDateController.text,
    );

    print('Insurance in saveUpdateInsurance: $updatedInsurance');
    try {
      await insuranceController.updateInsurance(updatedInsurance);
      print('Insurance updated successfully');
    } catch (error) {
      print('Error updating insurance: $error');
    }
  }

  Future<void> saveUpdateDental() async {
    final updatedDental = Dental(
      patient_id: details.dental.patient_id,
      previous_dentist: dialogPreviousDentistController.text,
      last_visit: dialogLatestVisitController.text,
    );

    try {
      await dentalController.updateDentalHistory(updatedDental);
      print('Dental updated successfully');
    } catch (error) {
      print('Error updating dental: $error');
    }
  }

  // Future<void> saveUpdateMedical() async {
  //   final updatedMedical = Medical(

  //   );
  // }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Edit Patient Record',
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
        ),
        content: SizedBox(
          width: 1300,
          height: 600,
          child:  SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  height: 10,
                  color: Colors.grey[800],
                  thickness: 0.5,
                ),
                const SizedBox(height: 15.0),
                PersonalInfoForms(
                  firstNameController: _dialogFirstNameController,
                  lastNameController: _dialogLastNameController,
                  middleNameController: _dialogMiddleNameController,
                  nicknameController: _dialogNicknameController, 
                  sexController: _dialogSexController,
                  ageController: _dialogAgeController,
                  birthdateController: _dialogBirthdateController, 
                  nationalityController: _dialogNationalityController,
                  occupationController: _dialogOccupationController,
                  religionController: _dialogReligionController,
                  reasonController: _dialogReasonController,
                  referrerController: _dialogReferrerController,
                  parentNameController: _guardianNameController,
                  parentOccupationController: _guardianOccupationController,
                  formKey: dialogPersonalInfoFormKey, 
                  patient: details.patient
                ),
                ContactInfoForms(
                  emailController: _emailController,
                  homeAddressController: _homeAddressController,
                  homeNoController: _homeNoController,
                  faxNoController: _faxNoController,
                  workNoController: _workNoController,
                  mobileNoController: _mobileNoController,
                  formKey: dialogContactInfoFormKey, 
                  contact: details.contact
                ),
                DentalInsuranceForms(
                  insuranceNameController: dialogInsuranceNameController,
                  effectivedateController: dialogEffectiveDateController, 
                  formKey: dialogDentalInsuranceFormKey, 
                  insurance: details.insurance
                ),
                DentalHistoryForms(
                  formKey: dialogDentalHistoryFormKey, 
                  previousDentistController: dialogPreviousDentistController,
                  latestvisitController: dialogLatestVisitController, 
                ),
                MedicalHistoryForms(
                  formKey: dialogMedicalHistoryFormKey, 
                ),
                AllergiesForms(formKey: dialogAllergiesFormKey, ),
                DiseasesForms(formKey: dialogDiseasesFormKey, ),
                //const ContactInfoForms()
                
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text('Update Records'),
            onPressed: () async {
              // Perform form validation and handle updates
              if (dialogPersonalInfoFormKey.currentState?.validate() ?? false) {
                // Handle valid form submission here
                Navigator.of(context).pop();
              } else {
                // Handle invalid form case
              }

              await saveUpdatePatient();
              await saveUpdateContact();
              await saveUpdateInsurance();
              await saveUpdateDental();
              // await saveUpdateMedical();
            },
          ),
        ],
      );
    },
  );
}



  Widget buildPatientDetails(PatientDetails details) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInfoSection("Name", [details.patient.firstName, details.patient.lastName]),
            buildInfoSection("Age", [details.patient.age.toString()]),
            buildInfoSection("Birthdate", [formatDate(details.patient.birthDate)]),
            buildInfoSection("Gender", [details.patient.sex.toString()]),
            buildInfoSection("Nationality", [details.patient.nationality]),
            buildInfoSection("Occupation", [details.patient.occupation]),
            buildInfoSection("Religion", [details.patient.religion]),
            buildInfoSection("Email Address", [details.contact.email]),
            buildInfoSection("Contact Number", [details.contact.mobile_number]),
            buildInfoSection("Address", [details.contact.home_number, details.contact.home_address]),
            buildInfoSection("Fax Number", [details.contact.fax_number]),
            buildInfoSection("Office Number", [details.contact.work_number]),
            buildInfoSection("Good Health", [details.medical.medical_goodHealth.toString()]),
            buildInfoSection("Under Medical Treatment", [details.medical.medical_isMedication.toString()]),
            buildInfoSection("Blood Type", [details.medical.medical_bloodType]),
            buildInfoSection("Blood Pressure", [details.medical.medical_bloodPressure]),
            buildInfoSection("Bleeding Time", [details.medical.medical_bleedingTime]),

            
            // Add other patient fields as needed
          ],
        ),
        const SizedBox(width: 100),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInfoSection("Dental Insurance", [details.insurance.insurance_name]),
            buildInfoSection("Effective Date", [formatDate(details.insurance.effective_date)]),
            buildInfoSection("Previous Dentist", [details.dental.previous_dentist]),
            buildInfoSection("latest Visit", [formatDate(details.dental.last_visit)]),
            buildInfoSection("Physician", [details.medical.medical_physician]),
            buildInfoSection("Speciality", [details.medical.medical_physicianSpec.toString()]),
            buildInfoSection("Office Address", [details.medical.medical_officeAddress]),
            buildInfoSection("Office Number", [details.medical.medical_officeNo]),
            buildInfoSection("Usage of Tobacco", [details.medical.medical_isTobacco.toString()]),
            buildInfoSection("Usage of Alcohol", [details.medical.medical_dangerousSubstance.toString()]),
            buildInfoSection("Hospitalized", [details.medical.medical_hospitalized.toString()]),
            buildInfoSection("Taking Prescriptions", [details.medical.medical_isMedication.toString()]),
            buildInfoSection("Serious Illness", [details.medical.medical_seriousOperation.toString()]),
            buildInfoSection("Pregant", [details.medical.medical_isPregnant.toString()]),
            buildInfoSection("Taking Birth Controls", [details.medical.medical_isBirthControl.toString()]),
            buildInfoSection("Nursing", [details.medical.medical_isNursing.toString()]),
            buildInfoSection(
              "Allergies",
              getTrueAllergies(details.allergies),
            ),
            

        
          ],
        ),
      ]
    );



      
  }
  
  // Format the date
  String formatDate(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }

  List<String> getTrueAllergies(Allergies allergies) {
    List<String> trueAllergies = [];

    if (allergies.allergies_anesthetic) trueAllergies.add("Anesthetic");
    if (allergies.allergies_penicillin) trueAllergies.add("Penicillin");
    if (allergies.allergies_sulfaDrugs) trueAllergies.add("Sulfa Drugs");
    if (allergies.allergies_aspirin) trueAllergies.add("Aspirin");
    if (allergies.allergies_latex) trueAllergies.add("Latex");
    // if (allergies.allergies_others != null && allergies.allergies_others.isNotEmpty) {
    //   trueAllergies.add(allergies.allergies_others);
    // }
    return trueAllergies;
  }
  //
  Widget buildInfoSection(String label, List<String> values) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 66, 43, 21),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3.0), // Spacing between label and value
        ...values.map((value) => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 66, 43, 21),
                  ),
                ),
              ],
            )),
        const SizedBox(height: 15.0), // Spacing between sections
      ],
    );
  }



