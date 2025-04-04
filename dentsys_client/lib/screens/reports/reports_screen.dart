// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:dentsys_client/screens/reports/edit_treatment_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:dentsys_client/screens/reports/forms/personal_info_forms.dart';
import 'package:dentsys_client/screens/reports/add_treatment_dialog.dart';
import 'package:dentsys_client/screens/reports/forms/allergies_forms.dart';
import 'package:dentsys_client/screens/reports/forms/contact_info_forms.dart';
import 'package:dentsys_client/screens/reports/forms/dental_history_forms.dart';
import 'package:dentsys_client/screens/reports/forms/dental_insurance_forms.dart';
import 'package:dentsys_client/screens/reports/forms/diseases_forms.dart';
import 'package:dentsys_client/screens/reports/forms/medical_history_forms.dart';

import 'package:dentsys_client/models/patientDetails_model.dart';

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
import 'package:dentsys_client/controllers/allergies_controller.dart';

import 'package:dentsys_client/models/patient_conditions/patientConditions_model.dart';
import 'package:dentsys_client/models/patient_conditions/conditions_model.dart';
import 'package:dentsys_client/controllers/conditions_controller.dart';

import 'package:dentsys_client/models/procedure_model.dart';
import 'package:dentsys_client/controllers/procedure_controller.dart';

import 'package:dentsys_client/models/treatments_model.dart';
import 'package:dentsys_client/controllers/treatment_controller.dart';

class ReportsScreen extends StatefulWidget {
  final int? patient_id;
  const ReportsScreen({super.key , this.patient_id});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final PatientController patientController = PatientController();
  final ProcedureController procedureController = ProcedureController();
  final TreatmentController treatmentController = TreatmentController();
  PatientDetails? patientDetails;
  List<PatientTreatment>? patientTreatments;
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    loadPatientDetails();
    loadPatientTreatments();
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

  void loadPatientTreatments() async {
    try {
      final treatments = await treatmentController.getPatientTreatments(widget.patient_id.toString());
      setState(() {
        patientTreatments = treatments;
        isLoading = false;
      });
      print('patient treatments: $patientTreatments');
    } catch (error) {
      print('Error getting patient treatments: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  void handleDeletePatient(int? patient_id) async {
    try {
      await patientController.deletePatient(patient_id);
      setState(() {
        patientDetails = null; // Clear patient details
      });
    } catch (error) {
      print('Error deleting patient: $error');
    }
  }


  void handleDeleteTreatment(String treatmentId) async {
    try {
      await treatmentController.deleteTreatment(treatmentId);
      loadPatientTreatments();
    } catch (error) {
      print('Error deleting treatment: $error');
    }
  }

  //dialog box for treatment deletions
  Future<void> showDeleteConfirmationDialog(BuildContext context, String treatmentId) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // Prevent dismissing by tapping outside the dialog
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Confirm Deletion', 
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 66, 43, 21),
          ),
        ),
        content: const Text(
          'Are you sure you want to delete this Treatment?',
          style: TextStyle(
            fontSize: 16.0,
            color: Color.fromARGB(255, 66, 43, 21),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              handleDeleteTreatment(treatmentId); // Proceed with deletion
            },
            child: const Text(
              'Yes',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      );
    },
  );
}

// dialog confirmation for patient record deletions
  void _showDeleteConfirmationDialog(BuildContext context, Function onDeleteConfirmed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
              'Confirm Deletion',
              style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 66, 43, 21),
            ),
          ),
          content: const Text(
            'Are you sure you want to delete this Patient Records?',
            style: TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 66, 43, 21),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDeleteConfirmed(); 
                Navigator.of(context).pop(); 
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }


@override
Widget build(BuildContext context) {
  return DefaultTabController(
    length: 2, // Number of tabs
    child: Material(
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
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      
                      const SizedBox(width: 10.0),

                      const Expanded(
                        child: Text(
                          "Patient Record",
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 66, 43, 21),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color.fromARGB(255, 255, 0, 0), Color.fromARGB(255, 22, 21, 66)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _showDeleteConfirmationDialog(context, () {
                              handleDeletePatient(widget.patient_id);
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Delete Records",
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
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),

                // TAB BAR
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
                  child: const TabBar(
                    indicatorColor: Colors.brown,
                    labelColor: Color.fromARGB(255, 66, 43, 21),
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: "Details"),
                      Tab(text: "Treatment Record"),
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),

                // TAB BAR VIEW
                SizedBox(
                  height: 600, // Set a fixed height for the content
                  child: TabBarView(
                    children: [
                      // Details Tab
                      SingleChildScrollView(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                        _showEditPatientFormsDialog(
                                          context,
                                          patientDetails!,
                                          () {
                                            loadPatientDetails();
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.edit, color: Colors.white),
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
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Divider(height: 10, color: Colors.grey[800], thickness: 0.5),
                              const SizedBox(height: 10),
                              patientDetails == null
                                  ? const Text('No patient data available')
                                  : buildPatientDetails(patientDetails!),
                            ],
                          ),
                        ),
                      ),

                      // Treatment Record Tab
                      SingleChildScrollView(
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
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "Treatment Record",
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 66, 43, 21),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          if (patientDetails?.patient.id != null) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AddTreatmentDialog(
                                                  patient_id: patientDetails!.patient.id!,
                                                  onTreatmentAdded: loadPatientTreatments, // Pass the refresh function
                                                );
                                              },
                                            );
                                          }
                                        },
                                        label: const Text(""),
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.brown[800],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
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
                        
                                  // Table with Dynamic Data
                                  isLoading
                                      ? const Center(child: CircularProgressIndicator())
                                      : Table(
                                          columnWidths: const {
                                            0: FlexColumnWidth(2), // Date-Time
                                            1: FlexColumnWidth(2), // Tooth No
                                            2: FlexColumnWidth(4), // Procedure
                                            3: FlexColumnWidth(2), // Dentist
                                            4: FlexColumnWidth(2), // Amount Charged
                                            5: FlexColumnWidth(2), // Amount Paid
                                            6: FlexColumnWidth(2), // Balance
                                            7: FlexColumnWidth(2), // Actions
                                          },
                                          border: TableBorder.all(
                                            color: Colors.black,
                                            width: 1.0,
                                          ),
                                          children: [
                                            // Table Headers
                                            const TableRow(
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
                                                    "Tooth/Teeth No.",
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
                                                    "Dentist/s",
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Amount Charged",
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Amount Paid",
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Balance",
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Actions",
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Dynamic Data Rows
                                            ...patientTreatments!.reversed.map((treatment) {
                                              return TableRow(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(DateTime.parse(treatment.treatment_date.toString())
                                                        .toLocal()
                                                        .toString()),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(treatment.treatment_toothNo.toString()),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      (treatment.treatment_prcdName),                                                      
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(treatment.treatment_dentist),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "₱${treatment.treatment_charged.toStringAsFixed(2)}",
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "₱${treatment.treatment_paid.toStringAsFixed(2)}",
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "₱${treatment.treatment_balance.toStringAsFixed(2)}",
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 8.0,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        IconButton(
                                                          icon: const Icon(Icons.edit, color: Colors.blue),
                                                          onPressed: () {
                                                            // Handle edit action
                                                            showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return EditTreatmentDialog(
                                                                  patient_id: patientDetails!.patient.id!,
                                                                  treatment: treatment,
                                                                  onTreatmentAdded: loadPatientTreatments, // Pass the refresh function
                                                                );
                                                              },
                                                            );
                                                          },
                                                        ),
                                                        IconButton(
                                                          icon: const Icon(Icons.delete, color: Colors.red),
                                                          onPressed: () async {
                                                            showDeleteConfirmationDialog(context, treatment.id.toString());
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }).toList(),
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
                          ],
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

  // fetchPatientDetails(int i) {

  // }
}

// Edit Patient Forms
  void _showEditPatientFormsDialog(BuildContext context, PatientDetails details, VoidCallback onUpdate) {
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
    final TextEditingController _dialogAgeController = TextEditingController(text: details.patient.age.toString());
    final TextEditingController _dialogBirthdateController = 
        TextEditingController(
            text: DateFormat('yyyy-MM-dd').format(DateTime.parse(details.patient.birthDate).toLocal()),
        );
    final TextEditingController _dialogNationalityController = TextEditingController(text: details.patient.nationality);
    final TextEditingController _dialogOccupationController = TextEditingController(text: details.patient.occupation);
    final TextEditingController _dialogReligionController = TextEditingController(text: details.patient.religion);
    final TextEditingController _dialogReasonController = TextEditingController(text: details.patient.reason);
    final TextEditingController _dialogReferrerController = TextEditingController(text: details.patient.referrer);
    final TextEditingController _guardianNameController = TextEditingController(text: details.patient.parentName);
    final TextEditingController _guardianOccupationController = TextEditingController(text: details.patient.parentOccupation);
    late String? _dialogSex = details.patient.sex;
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
    final TextEditingController dialogEffectiveDateController = 
          TextEditingController(
              text: details.insurance.effective_date != null 
                  ? DateFormat('yyyy-MM-dd').format(DateTime.parse(details.insurance.effective_date!).toLocal())
                  : '',
          );
    late InsuranceController insuranceController = InsuranceController(); // insurance controller
    
    // dental history
    final TextEditingController dialogPreviousDentistController = TextEditingController(text: details.dental.previous_dentist);
    final TextEditingController dialogLatestVisitController =
          TextEditingController(
              text: details.dental.last_visit != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(details.dental.last_visit!).toLocal()) : '',
          );
    late DentalController dentalController = DentalController(); // dental controller

  // medical history
  final TextEditingController dialogPhysicianController = TextEditingController(text: details.medical.medical_physician);
  final TextEditingController dialogPhysicianSpecController = TextEditingController(text: details.medical.medical_physicianSpec);
  final TextEditingController dialogOfficeAddressController = TextEditingController(text: details.medical.medical_officeAddress);
  final TextEditingController dialogOfficeNoController = TextEditingController(text: details.medical.medical_officeNo);
  final TextEditingController dialogUnderTreatmentDetailsController = TextEditingController(text: details.medical.medical_treatmentDetails);
  final TextEditingController dialogSeriousOperationDetails = TextEditingController(text: details.medical.medical_seriousOperationDetails);
  final TextEditingController dialogMedicalHospitalizedDetails = TextEditingController(text: details.medical.medical_hospitalizedDetails);
  final TextEditingController dialogMedicationDetails = TextEditingController(text: details.medical.medical_medicationDetails);
  final TextEditingController dialogBloodTypeController = TextEditingController(text: details.medical.medical_bloodType);
  final TextEditingController dialogBloodPressureController = TextEditingController(text: details.medical.medical_bloodPressure);
  final TextEditingController dialogBleedingTimeController = TextEditingController(text: details.medical.medical_bleedingTime);
  late bool dialogGoodHealthValue = details.medical.medical_goodHealth;
  late bool dialogUnderTreatmentValue = details.medical.medical_isUnderTreatment;
  late bool dialogSeriousOperationValue = details.medical.medical_seriousOperation;
  late bool dialogHospitalizedValue = details.medical.medical_hospitalized;
  late bool dialogMedicationValue = details.medical.medical_isMedication;
  late bool dialogTobaccoValue = details.medical.medical_isTobacco;
  late bool dialogDangerousSubstanceValue = details.medical.medical_dangerousSubstance;
  late bool? dialogPregnantValue = details.medical.medical_isPregnant;
  late bool? dialogNursingValue = details.medical.medical_isNursing;
  late bool? dialogBirthControlValue = details.medical.medical_isBirthControl;
  late MedicalController medicalController = MedicalController(); // medical controller

  // allergies info
  final TextEditingController dialogAllergiesOthersController = TextEditingController(text: details.allergies.allergies_others);
  late bool dialogAllergiesAnestheticValue = details.allergies.allergies_anesthetic;
  late bool dialogAllergiesAntibioticsValue = details.allergies.allergies_penicillin;
  late bool dialogAllergiesSulfaValue = details.allergies.allergies_sulfaDrugs;
  late bool dialogAllergiesAspirinValue = details.allergies.allergies_aspirin;
  late bool dialogAllergiesLatexValue = details.allergies.allergies_latex;
  late bool dialogAllergiesOthersValue = details.allergies.allergies_others!.isNotEmpty;
  late AllergiesController allergiesController = AllergiesController(); // allergies controller

  // conditions info
  final TextEditingController dialogConditionsOthersController = TextEditingController();
  late bool dialogHighBlood = details.conditions.any((condition) => condition.condition_id == 1 && condition.patientCondition_status);
  late bool dialogLowBlood = details.conditions.any((condition) => condition.condition_id == 2 && condition.patientCondition_status);
  late bool dialogEpilepsy = details.conditions.any((condition) => condition.condition_id == 3 && condition.patientCondition_status);
  late bool dialogAids = details.conditions.any((condition) => condition.condition_id == 4 && condition.patientCondition_status);
  late bool dialogSTD = details.conditions.any((condition) => condition.condition_id == 5 && condition.patientCondition_status);
  late bool dialogStomachUlcer = details.conditions.any((condition) => condition.condition_id == 6 && condition.patientCondition_status);
  late bool dialogFaintingSeizures = details.conditions.any((condition) => condition.condition_id == 7 && condition.patientCondition_status);
  late bool dialogRapidWL = details.conditions.any((condition) => condition.condition_id == 8 && condition.patientCondition_status);
  late bool dialogRadTherapy = details.conditions.any((condition) => condition.condition_id == 9 && condition.patientCondition_status);
  late bool dialogJointReplacement = details.conditions.any((condition) => condition.condition_id == 10 && condition.patientCondition_status);
  late bool dialogHeartSurg = details.conditions.any((condition) => condition.condition_id == 11 && condition.patientCondition_status);
  late bool dialogHeartAttack = details.conditions.any((condition) => condition.condition_id == 12 && condition.patientCondition_status);
  late bool dialogHeartDisease = details.conditions.any((condition) => condition.condition_id == 13 && condition.patientCondition_status);
  late bool dialogHeartMurmur = details.conditions.any((condition) => condition.condition_id == 14 && condition.patientCondition_status);
  late bool dialogThyroid = details.conditions.any((condition) => condition.condition_id == 15 && condition.patientCondition_status);
  late bool dialogHepaLiver = details.conditions.any((condition) => condition.condition_id == 16 && condition.patientCondition_status);
  late bool dialogJaundice = details.conditions.any((condition) => condition.condition_id == 17 && condition.patientCondition_status);
  late bool dialogRheumaticFever = details.conditions.any((condition) => condition.condition_id == 18 && condition.patientCondition_status);
  late bool dialogHayFever = details.conditions.any((condition) => condition.condition_id == 19 && condition.patientCondition_status);
  late bool dialogRespiratory = details.conditions.any((condition) => condition.condition_id == 20 && condition.patientCondition_status);
  late bool dialogTB = details.conditions.any((condition) => condition.condition_id == 21 && condition.patientCondition_status);
  late bool dialogSwollenAnkles = details.conditions.any((condition) => condition.condition_id == 22 && condition.patientCondition_status);
  late bool dialogKidneyDisease = details.conditions.any((condition) => condition.condition_id == 23 && condition.patientCondition_status);
  late bool dialogDiabetes = details.conditions.any((condition) => condition.condition_id == 24 && condition.patientCondition_status);
  late bool dialogChestPain = details.conditions.any((condition) => condition.condition_id == 25 && condition.patientCondition_status);
  late bool dialogStroke = details.conditions.any((condition) => condition.condition_id == 26 && condition.patientCondition_status);
  late bool dialogTumors = details.conditions.any((condition) => condition.condition_id == 27 && condition.patientCondition_status);
  late bool dialogAnemia = details.conditions.any((condition) => condition.condition_id == 28 && condition.patientCondition_status);
  late bool dialogAngina = details.conditions.any((condition) => condition.condition_id == 29 && condition.patientCondition_status);
  late bool dialogAsthma = details.conditions.any((condition) => condition.condition_id == 30 && condition.patientCondition_status);
  late bool dialogEmphysema = details.conditions.any((condition) => condition.condition_id == 31 && condition.patientCondition_status);
  late bool dialogBleedingProb = details.conditions.any((condition) => condition.condition_id == 32 && condition.patientCondition_status); 
  late bool dialogBloodDisease = details.conditions.any((condition) => condition.condition_id == 33 && condition.patientCondition_status);
  late bool dialogHeadInjury = details.conditions.any((condition) => condition.condition_id == 34 && condition.patientCondition_status);
  late bool dialogArthritis = details.conditions.any((condition) => condition.condition_id == 35 && condition.patientCondition_status);
  late ConditionsController conditionsController = ConditionsController();
  
  dynamic retrieveSex(String? updSex) async {
    _dialogSex = updSex;
  }

  _dialogBirthdateController.addListener(() {
    final birthDate = DateTime.tryParse(_dialogBirthdateController.text);
    if (birthDate != null) {
      final age = DateTime.now().year - birthDate.year;
      _dialogAgeController.text = age.toString();
    }
  });

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(details.patient.birthDate),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.parse(details.patient.birthDate)) {
      _dialogBirthdateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  GestureDetector(
    onTap: () => _selectBirthDate(context),
    child: AbsorbPointer(
      child: TextField(
        controller: _dialogBirthdateController,
        decoration: InputDecoration(labelText: 'Birthdate'),
      ),
    ),
  );

  Future<void> saveUpdatePatient() async {
    final updatedPatient = Patient(
      id: details.patient.id,
      firstName: _dialogFirstNameController.text,
      lastName: _dialogLastNameController.text,
      middleName: _dialogMiddleNameController.text,
      nickname: _dialogNicknameController.text,
      birthDate: DateFormat('yyyy-MM-dd').format(DateTime.parse(_dialogBirthdateController.text)),
      age: int.parse(_dialogAgeController.text),
      sex: _dialogSex,
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
        // print('Patient updated successfully');

        // Trigger refresh
        onUpdate();
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
        // print('Contact updated successfully');

         // Trigger refresh
        onUpdate();
      } catch (error) {
        print('Error updating contact: $error');
      }
    }
    
    Future<void> saveUpdateInsurance() async {
      final updatedInsurance = Insurance(
        patient_id: details.insurance.patient_id,
        insurance_name: dialogInsuranceNameController.text,
        effective_date: dialogEffectiveDateController.text.isNotEmpty ? DateFormat('yyyy-MM-dd').format(DateTime.parse(dialogEffectiveDateController.text)) : '',
        // effective_date: dialogEffectiveDateController.text,
      );

      try {
        await insuranceController.updateInsurance(updatedInsurance);
        // print('Insurance updated successfully');

         // Trigger refresh
        onUpdate();
      } catch (error) {
        print('Error updating insurance: $error');
      }
    }

    Future<void> saveUpdateDental() async {
      final updatedDental = Dental(
        patient_id: details.dental.patient_id,
        previous_dentist: dialogPreviousDentistController.text,
        last_visit: dialogLatestVisitController.text.isNotEmpty ? DateFormat('yyyy-MM-dd').format(DateTime.parse(dialogLatestVisitController.text)) : '',
      );

      try {
        await dentalController.updateDentalHistory(updatedDental);
        // print('Dental updated successfully');

         // Trigger refresh
        onUpdate();
      } catch (error) {
        print('Error updating dental: $error');
      }
    }

  dynamic retrieveMedicalStates(
    bool goodHealth,
    bool underTreatment,
    bool seriousOperation,
    bool hospitalized,
    bool medication,
    bool tobacco,
    bool dangerousSubstance,
    bool? pregnant,
    bool? nursing,
    bool? birthControl,
  ) async {
      dialogGoodHealthValue = goodHealth;
      dialogUnderTreatmentValue = underTreatment;
      dialogSeriousOperationValue = seriousOperation;
      dialogHospitalizedValue = hospitalized;
      dialogMedicationValue = medication;
      dialogTobaccoValue = tobacco;
      dialogDangerousSubstanceValue = dangerousSubstance;
      dialogPregnantValue = pregnant;
      dialogNursingValue = nursing;
      dialogBirthControlValue = birthControl;
  }

    Future<void> saveUpdateMedical() async {
      final updatedMedical = Medical(
        patient_id: details.medical.patient_id,
        medical_physician: dialogPhysicianController.text,
        medical_physicianSpec: dialogPhysicianSpecController.text,
        medical_officeAddress: dialogOfficeAddressController.text,
        medical_officeNo: dialogOfficeNoController.text,
        medical_goodHealth: dialogGoodHealthValue,
        medical_isUnderTreatment: dialogUnderTreatmentValue,
        medical_treatmentDetails: dialogUnderTreatmentDetailsController.text,
        medical_seriousOperation: dialogSeriousOperationValue,
        medical_seriousOperationDetails: dialogSeriousOperationDetails.text,
        medical_hospitalized: dialogHospitalizedValue,
        medical_hospitalizedDetails: dialogMedicalHospitalizedDetails.text,
        medical_isMedication: dialogMedicationValue,
        medical_medicationDetails: dialogMedicationDetails.text,
        medical_bloodType: dialogBloodTypeController.text,
        medical_bloodPressure: dialogBloodPressureController.text,
        medical_bleedingTime: dialogBleedingTimeController.text,
        medical_isTobacco: dialogTobaccoValue,
        medical_dangerousSubstance: dialogDangerousSubstanceValue,
        medical_isPregnant: dialogPregnantValue,
        medical_isNursing: dialogNursingValue,
        medical_isBirthControl: dialogBirthControlValue,
      );
      // print('updatedMedical in saveUpdateMedical: $updatedMedical');
      try {
        await medicalController.updateMedicalHistory(updatedMedical);
        // print('Medical updated successfully');

         // Trigger refresh
        onUpdate();
      } catch (error) {
        print('Error updating medical: $error');
      } 
    }

    dynamic retrieveAllergyStates(
      bool anesthetic,
      bool antibiotics,
      bool sulfa,
      bool aspirin,
      bool latex,
    ) async {
      dialogAllergiesAnestheticValue = anesthetic;
      dialogAllergiesAntibioticsValue = antibiotics;
      dialogAllergiesSulfaValue = sulfa;
      dialogAllergiesAspirinValue = aspirin;
      dialogAllergiesLatexValue = latex;
    }

    Future<void> saveUpdateAllergies() async {
      final updatedAllergies = Allergies(
        patient_id: details.allergies.patient_id,
        allergies_anesthetic: dialogAllergiesAnestheticValue,
        allergies_penicillin: dialogAllergiesAntibioticsValue,
        allergies_sulfaDrugs: dialogAllergiesSulfaValue,
        allergies_aspirin: dialogAllergiesAspirinValue,
        allergies_latex: dialogAllergiesLatexValue,
        allergies_others: dialogAllergiesOthersController.text,
      );

      try {
        await allergiesController.updateAllergy(updatedAllergies);
        // print('Allergies updated successfully');

         // Trigger refresh
        onUpdate();
      } catch(error){
        print('Error updating allergies: $error');
      }
    }

  dynamic retrieveConditionsStates(
    bool highBlood,
    bool lowBlood,
    bool epilepsy,
    bool aids,
    bool std,
    bool stomachUlcer,
    bool faintingSeizures,
    bool rapidWL,
    bool radTherapy,
    bool jointReplacement,
    bool heartSurg,
    bool heartAttack,
    bool heartDisease,
    bool heartMurmur,
    bool thyroid,
    bool hepaLiver,
    bool jaundice,
    bool rheumaticFever,
    bool hayFever,
    bool respiratory,
    bool tb,
    bool swollenAnkles,
    bool kidneyDisease,
    bool diabetes,
    bool chestPain,
    bool stroke,
    bool tumors,
    bool anemia,
    bool angina,
    bool asthma,
    bool emphysema,
    bool bleedingProb,
    bool bloodDisease,
    bool headInjury,
    bool arthritis,
  ) {
    dialogHighBlood = highBlood;
    dialogLowBlood = lowBlood;
    dialogEpilepsy = epilepsy;
    dialogAids = aids;
    dialogSTD = std;
    dialogStomachUlcer = stomachUlcer;
    dialogFaintingSeizures = faintingSeizures;
    dialogRapidWL = rapidWL;
    dialogRadTherapy = radTherapy;
    dialogJointReplacement = jointReplacement;
    dialogHeartSurg = heartSurg;
    dialogHeartAttack = heartAttack;
    dialogHeartDisease = heartDisease;
    dialogHeartMurmur = heartMurmur;
    dialogThyroid = thyroid;
    dialogHepaLiver = hepaLiver;
    dialogJaundice = jaundice;
    dialogRheumaticFever = rheumaticFever;
    dialogHayFever = hayFever;
    dialogRespiratory = respiratory;
    dialogTB = tb;
    dialogSwollenAnkles = swollenAnkles;
    dialogKidneyDisease = kidneyDisease;
    dialogDiabetes = diabetes;
    dialogChestPain = chestPain;
    dialogStroke = stroke;
    dialogTumors = tumors;
    dialogAnemia = anemia;
    dialogAngina = angina;
    dialogAsthma = asthma;
    dialogEmphysema = emphysema;
    dialogBleedingProb = bleedingProb;
    dialogBloodDisease = bloodDisease;
    dialogHeadInjury = headInjury;
    dialogArthritis = arthritis;
  }
  
  Future<void> saveUpdatedConditions() async {
    List<Conditions> updatedConditions = [
      Conditions(condition_id: 1, patientCondition_status: dialogHighBlood),
      Conditions(condition_id: 2, patientCondition_status: dialogLowBlood),
      Conditions(condition_id: 3, patientCondition_status: dialogEpilepsy),
      Conditions(condition_id: 4, patientCondition_status: dialogAids),
      Conditions(condition_id: 5, patientCondition_status: dialogSTD),
      Conditions(condition_id: 6, patientCondition_status: dialogStomachUlcer),
      Conditions(condition_id: 7, patientCondition_status: dialogFaintingSeizures),
      Conditions(condition_id: 8, patientCondition_status: dialogRapidWL),
      Conditions(condition_id: 9, patientCondition_status: dialogRadTherapy),
      Conditions(condition_id: 10, patientCondition_status: dialogJointReplacement),
      Conditions(condition_id: 11, patientCondition_status: dialogHeartSurg),
      Conditions(condition_id: 12, patientCondition_status: dialogHeartAttack),
      Conditions(condition_id: 13, patientCondition_status: dialogHeartDisease),
      Conditions(condition_id: 14, patientCondition_status: dialogHeartMurmur),
      Conditions(condition_id: 15, patientCondition_status: dialogThyroid),
      Conditions(condition_id: 16, patientCondition_status: dialogHepaLiver),
      Conditions(condition_id: 17, patientCondition_status: dialogJaundice),
      Conditions(condition_id: 18, patientCondition_status: dialogRheumaticFever),
      Conditions(condition_id: 19, patientCondition_status: dialogHayFever),
      Conditions(condition_id: 20, patientCondition_status: dialogRespiratory),
      Conditions(condition_id: 21, patientCondition_status: dialogTB),
      Conditions(condition_id: 22, patientCondition_status: dialogSwollenAnkles),
      Conditions(condition_id: 23, patientCondition_status: dialogKidneyDisease),
      Conditions(condition_id: 24, patientCondition_status: dialogDiabetes),
      Conditions(condition_id: 25, patientCondition_status: dialogChestPain),
      Conditions(condition_id: 26, patientCondition_status: dialogStroke),
      Conditions(condition_id: 27, patientCondition_status: dialogTumors),
      Conditions(condition_id: 28, patientCondition_status: dialogAnemia),
      Conditions(condition_id: 29, patientCondition_status: dialogAngina),
      Conditions(condition_id: 30, patientCondition_status: dialogAsthma),
      Conditions(condition_id: 31, patientCondition_status: dialogEmphysema),
      Conditions(condition_id: 32, patientCondition_status: dialogBleedingProb),
      Conditions(condition_id: 33, patientCondition_status: dialogBloodDisease),
      Conditions(condition_id: 34, patientCondition_status: dialogHeadInjury),
      Conditions(condition_id: 35, patientCondition_status: dialogArthritis),
    ];
    

    final trueConditions = updatedConditions.where((condition) => condition.patientCondition_status == true).toList();
    final falseConditions = updatedConditions.where((condition) => condition.patientCondition_status == false).toList();
    
    final updPatientConditions = PatientConditions(
      patient_id: details.patient.id,
      conditions: trueConditions,
    );

    final delPatientConditions = PatientConditions(
      patient_id: details.patient.id,
      conditions: falseConditions,
    );

    // print ('updPatientConditions: $updPatientConditions');
    // print ('delPatientConditions: $delPatientConditions');

    try {
      await conditionsController.addPatientCondition(updPatientConditions);
      await conditionsController.deletePatientCondition(delPatientConditions);
       // Trigger refresh
      onUpdate();
    } catch (error) {
      print('Error updating conditions: $error');
    }
  }
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
          child: SingleChildScrollView(
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
                  selectedSex: _dialogSex,
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
                  patient: details.patient,
                  onSexChanged: retrieveSex,
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
                  physicianNameController: dialogPhysicianController,
                  physicianSpecialtyController: dialogPhysicianSpecController,
                  officeAddressController: dialogOfficeAddressController,
                  officeNumberController: dialogOfficeNoController,
                  isInGoodHealth: dialogGoodHealthValue,
                  isUnderTreatment: dialogUnderTreatmentValue,
                  medicalTreatmentDetailsController: dialogUnderTreatmentDetailsController,
                  isSeriousIllness: dialogSeriousOperationValue,
                  seriousIllnessDetailsController: dialogSeriousOperationDetails,
                  isHospitalized: dialogHospitalizedValue,
                  hospitalizationDetailsController: dialogMedicalHospitalizedDetails,
                  isTakingMedication: dialogMedicationValue,
                  medicationDetailsController: dialogMedicationDetails,
                  isUsingTobacco: dialogTobaccoValue,
                  isUsingDangerousDrugs: dialogDangerousSubstanceValue,
                  bloodTypeController: dialogBloodTypeController,
                  bloodPressureController: dialogBloodPressureController,
                  bleedingTimeController: dialogBleedingTimeController,
                  isNursing: dialogNursingValue,
                  isPregnant: dialogPregnantValue,
                  isTakingBirthControl: dialogBirthControlValue,
                  onUpdated: retrieveMedicalStates,
                ),
                AllergiesForms(
                  formKey: dialogAllergiesFormKey, 
                  isAllergicToAnesthetic: dialogAllergiesAnestheticValue,
                  isAllergicToAntibiotics: dialogAllergiesAntibioticsValue,
                  isAllergicToSulfa: dialogAllergiesSulfaValue,
                  isAllergicToAspirin: dialogAllergiesAspirinValue,
                  isAllergicToLatex: dialogAllergiesLatexValue,
                  isAllergicToOthers: dialogAllergiesOthersValue,
                  allergiesOthersController: dialogAllergiesOthersController,
                  onAllergiesChanged: retrieveAllergyStates,
                ),
                DiseasesForms(
                  formKey: dialogDiseasesFormKey, 
                  isHighBlood: dialogHighBlood,
                  isLowBlood: dialogLowBlood,
                  isEpilepsy: dialogEpilepsy,
                  isAIDSorHIV: dialogAids,
                  isSTD: dialogSTD,
                  isUlcers: dialogStomachUlcer,
                  isFaintingSeizure: dialogFaintingSeizures,
                  isRapidWeightLoss: dialogRapidWL,
                  isRadiationTherapy: dialogRadTherapy,
                  isJointReplacement: dialogJointReplacement,
                  isHeartSurgery: dialogHeartSurg,
                  isHeartAttack: dialogHeartAttack,
                  isHeartDisease: dialogHeartDisease,
                  isHeartMurmur: dialogHeartMurmur,
                  isThyroidProblem: dialogThyroid,
                  isLiverDisease: dialogHepaLiver,
                  isRheumaticFever: dialogRheumaticFever,
                  isJaundice: dialogJaundice,
                  isHayFever: dialogHayFever,
                  isRespiratoryProblems: dialogRespiratory,
                  isSwollenAnkle: dialogSwollenAnkles,
                  isTuberculosis: dialogTB,
                  isKidneyDisease: dialogKidneyDisease,
                  isDiabetes: dialogDiabetes,
                  isChestPain: dialogChestPain,
                  isStroke: dialogStroke,
                  isCancer: dialogTumors,
                  isAnemia: dialogAnemia,
                  isAngina: dialogAngina,
                  isAsthma: dialogAsthma,
                  isEmphysema: dialogEmphysema,
                  isBleedingProblem: dialogBleedingProb,
                  isBloodDisease: dialogBloodDisease,
                  isHeadInjuries: dialogHeadInjury,
                  isArthritis: dialogArthritis,
                  othersDisease: dialogConditionsOthersController.text.isNotEmpty,
                  onConditionsChanged: retrieveConditionsStates,
                ),
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
                await saveUpdateMedical();
                await saveUpdateAllergies();
                await saveUpdatedConditions();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  //Patient Details
  Widget buildPatientDetails(PatientDetails details) {
  return LayoutBuilder(
    builder: (context, constraints) {
      // Use the screen width to adjust the layout
      bool isWideScreen = constraints.maxWidth > 600;

      if (isWideScreen) {
        return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                              "Personal Details",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 66, 43, 21),
                              ),
                            ),
                      const SizedBox(height: 10),
                      Divider(
                                        height: 10,
                                        color: Colors.grey[600],
                                        thickness: 0.5,
                                      ),
                      const SizedBox(height: 10),
                      buildInfoSection("Name", [details.patient.firstName, details.patient.lastName]),
                      buildInfoSection("Age", [details.patient.age.toString()]),
                      buildInfoSection("Birthdate", [formatDate(details.patient.birthDate)]),
                      buildInfoSection("Gender", [details.patient.sex.toString()]),
                      buildInfoSection("Nationality", [details.patient.nationality]),
                      buildInfoSection("Occupation", [details.patient.occupation]),
                      buildInfoSection("Religion", [details.patient.religion]),                    
                      buildInfoSection(
                        "Good Health",
                        details.medical.medical_goodHealth
                            ? ["Yes"]
                            : ["No"],
                      ),
                      buildInfoSection(
                        "Under Medical Treatment",
                        details.medical.medical_isUnderTreatment
                            ? [details.medical.medical_treatmentDetails.toString()]
                            : ["No"],
                      ),                      
                      buildInfoSection("Blood Type", [details.medical.medical_bloodType]),
                      buildInfoSection("Blood Pressure", [details.medical.medical_bloodPressure]),
                      buildInfoSection("Bleeding Time", [details.medical.medical_bleedingTime]),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                              "Contact Details",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 66, 43, 21),
                              ),
                            ),
                      const SizedBox(height: 10),
                      Divider(
                                        height: 10,
                                        color: Colors.grey[600],
                                        thickness: 0.5,
                                      ),
                      const SizedBox(height: 10),
                      buildInfoSection("Email Address", [details.contact.email]),
                      buildInfoSection("Contact Number", [details.contact.mobile_number]),
                      buildInfoSection("Address", [details.contact.home_number, details.contact.home_address]),
                      buildInfoSection("Fax Number", [details.contact.fax_number]),
                      buildInfoSection("Office Number", [details.contact.work_number]),
                      buildInfoSection("Dental Insurance", [details.insurance.insurance_name]),
                      buildInfoSection("Effective Date", [details.insurance.effective_date != null ? formatDate(details.insurance.effective_date!) : 'N/A']),
                      buildInfoSection("Previous Dentist", [details.dental.previous_dentist]),
                      buildInfoSection("Latest Visit", [details.dental.last_visit != null ? formatDate(details.dental.last_visit!) : 'N/A']),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                              "Medical History",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 66, 43, 21),
                              ),
                            ),
                      const SizedBox(height: 10),
                      Divider(
                                        height: 10,
                                        color: Colors.grey[600],
                                        thickness: 0.5,
                                      ),
                      const SizedBox(height: 10),
                      buildInfoSection("Physician", [details.medical.medical_physician]),
                      buildInfoSection("Speciality", [details.medical.medical_physicianSpec.toString()]),
                      buildInfoSection("Office Address", [details.medical.medical_officeAddress]),
                      buildInfoSection("Office Number", [details.medical.medical_officeNo]),
                      buildInfoSection(
                        "Usage of Tobacco",
                        details.medical.medical_isTobacco
                            ? ["Yes"]
                            : ["No"],
                      ),
                      buildInfoSection(
                        "Usage of Alcohol",
                        details.medical.medical_dangerousSubstance
                            ? ["Yes"]
                            : ["No"],
                      ),
                      buildInfoSection(
                        "Hospitalized",
                        details.medical.medical_hospitalized
                            ? [details.medical.medical_hospitalizedDetails.toString()]
                            : ["No"],
                      ),
                      buildInfoSection(
                        "Taking Any Prescription",
                        details.medical.medical_isMedication
                            ? [details.medical.medical_medicationDetails.toString()]
                            : ["No"],
                      ),
                      buildInfoSection(
                        "Serious Illness",
                        details.medical.medical_seriousOperation
                            ? [details.medical.medical_seriousOperationDetails.toString()]
                            : ["No"],
                      ),
                      buildInfoSection(
                        "Pregnant",
                        details.medical.medical_isPregnant == true
                            ? ["Yes"]
                            : ["No"],
                      ),
                      buildInfoSection(
                        "Taking Birth Controls",
                        details.medical.medical_isBirthControl == true
                            ? ["Yes"]
                            : ["No"],
                      ),
                      buildInfoSection(
                        "Nursing",
                        details.medical.medical_isNursing == true
                            ? ["Yes"]
                            : ["No"],
                      ),
                      buildInfoSection("Allergies", getTrueAllergies(details.allergies)),
                      buildInfoSection("Conditions", [formatConditions(details.conditions)]),
                    ],
                  ),
                ),
              ],
            );
      } else {
        return SingleChildScrollView(
              child: Column(
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
                  buildInfoSection(
                    "Good Health",
                    details.medical.medical_goodHealth
                        ? ["Yes"]
                        : ["No"],
                  ),
                  buildInfoSection(
                    "Under Medical Treatment",
                    details.medical.medical_isUnderTreatment
                        ? [details.medical.medical_treatmentDetails.toString()]
                        : ["No"],
                  ),              
                  buildInfoSection("Blood Type", [details.medical.medical_bloodType]),
                  buildInfoSection("Blood Pressure", [details.medical.medical_bloodPressure]),
                  buildInfoSection("Bleeding Time", [details.medical.medical_bleedingTime]),
                  buildInfoSection("Dental Insurance", [details.insurance.insurance_name]),
                  buildInfoSection("Effective Date", [details.insurance.effective_date != null ? formatDate(details.insurance.effective_date!) : 'N/A']),
                  buildInfoSection("Previous Dentist", [details.dental.previous_dentist]),
                  buildInfoSection("Latest Visit", [details.dental.last_visit != null ? formatDate(details.dental.last_visit!) : 'N/A']),
                  buildInfoSection("Physician", [details.medical.medical_physician]),
                  buildInfoSection("Speciality", [details.medical.medical_physicianSpec.toString()]),
                  buildInfoSection("Office Address", [details.medical.medical_officeAddress]),
                  buildInfoSection("Office Number", [details.medical.medical_officeNo]),
                  buildInfoSection(
                    "Usage of Tobacco",
                    details.medical.medical_isTobacco
                        ? ["Yes"]
                        : ["No"],
                  ),
                  buildInfoSection(
                    "Usage of Alcohol",
                    details.medical.medical_dangerousSubstance
                        ? ["Yes"]
                        : ["No"],
                  ),
                  buildInfoSection(
                    "Hospitalized",
                    details.medical.medical_hospitalized
                        ? [details.medical.medical_hospitalizedDetails.toString()]
                        : ["No"],
                  ),
                  buildInfoSection(
                    "Taking Any Prescription",
                    details.medical.medical_isMedication
                        ? [details.medical.medical_medicationDetails.toString()]
                        : ["No"],
                  ),
                  buildInfoSection(
                    "Serious Illness",
                    details.medical.medical_seriousOperation
                        ? [details.medical.medical_seriousOperationDetails.toString()]
                        : ["No"],
                  ),
                  buildInfoSection(
                    "Pregnant",
                    details.medical.medical_isPregnant == true
                        ? ["Yes"]
                        : ["No"],
                  ),
                  buildInfoSection(
                    "Taking Birth Controls",
                    details.medical.medical_isBirthControl == true
                        ? ["Yes"]
                        : ["No"],
                  ),
                  buildInfoSection(
                    "Nursing",
                    details.medical.medical_isNursing == true
                        ? ["Yes"]
                        : ["No"],
                  ),
                  buildInfoSection("Allergies", getTrueAllergies(details.allergies)),
                  buildInfoSection("Conditions", [formatConditions(details.conditions)]),
                ],
              ),
            );
      }
          },
        );
      }


  // initialize condition states


  // Funtion to Format the Names of Conditions
  String formatConditions(List<Conditions>? conditions) {
    if (conditions == null || conditions.isEmpty) {
      return "No conditions";
    }

    // Create a map of condition IDs to names
    const conditionNames = {
      1: "High blood pressure",
      2: "Low blood pressure",
      3: "Seizure disorder",
      4: "Immunodeficiency Syndrome",
      5: "Sexually Transmitted Disease",
      6: "Peptic or stomach ulcer",
      7: "History of fainting or seizures",
      8: "Rapid weight loss",
      9: "Radiation therapy",
      10: "Joint replacement surgery",
      11: "History of heart surgery",
      12: "History of heart attack",
      13: "Heart disease",
      14: "Heart murmur",
      15: "Thyroid issues",
      16: "Hepatitis / liver issues",
      17: "Hepatitis / Jaundice",
      18: "Rheumatic fever",
      19: "Hay fever",
      20: "Respiratory problems",
      21: "Tuberculosis",
      22: "Swollen ankles",
      23: "Kidney disease",
      24: "Diabetes",
      25: "Chest pain",
      26: "History of stroke",
      27: "History of tumors",
      28: "Anemia",
      29: "Angina",
      30: "Asthma",
      31: "Emphysema",
      32: "Bleeding problems",
      33: "Blood disease",
      34: "History of head injury",
      35: "Arthritis",
      36: "Other health conditions",
    };

    // Filter and map to human-readable names
    return conditions
        .where((condition) => condition.patientCondition_status) // Keep only true conditions
        .map((condition) => conditionNames[condition.condition_id] ?? "Unknown Condition") // Map ID to name
        .join("\n"); // Join all names with a comma
  }

  // Format the date
  String formatDate(String utcDate) {
  final DateTime parsedDate = DateTime.parse(utcDate).toLocal();
  return DateFormat('yyyy-MM-dd').format(parsedDate);
}


  List<String> getTrueAllergies(Allergies allergies) {
    List<String> trueAllergies = [];

    if (allergies.allergies_anesthetic) trueAllergies.add("Anesthetic");
    if (allergies.allergies_penicillin) trueAllergies.add("Penicillin");
    if (allergies.allergies_sulfaDrugs) trueAllergies.add("Sulfa Drugs");
    if (allergies.allergies_aspirin) trueAllergies.add("Aspirin");
    if (allergies.allergies_latex) trueAllergies.add("Latex");
    if (allergies.allergies_others != null && allergies.allergies_others!.isNotEmpty) {
      if (allergies.allergies_others != null) {
        trueAllergies.add(allergies.allergies_others!);
      }
    }
    return trueAllergies;
  }
  
  
  //Text Field Builder
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



