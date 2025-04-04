import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

import 'package:dentsys_client/controllers/patient_controller.dart';
import 'package:dentsys_client/models/patient_model.dart';

import 'package:dentsys_client/controllers/contact_controller.dart';
import 'package:dentsys_client/models/contact_model.dart';

import 'package:dentsys_client/controllers/insurance_controller.dart';
import 'package:dentsys_client/models/insurance_model.dart';

import 'package:dentsys_client/controllers/dental_controller.dart';
import 'package:dentsys_client/models/dental_model.dart';

import 'package:dentsys_client/controllers/medical_controller.dart';
import 'package:dentsys_client/models/medical_model.dart';

import 'package:dentsys_client/controllers/allergies_controller.dart';
import 'package:dentsys_client/models/allergies_model.dart';

import 'package:dentsys_client/controllers/conditions_controller.dart';
import 'package:dentsys_client/models/patient_conditions/conditions_model.dart';
import 'package:dentsys_client/models/patient_conditions/patientConditions_model.dart';

class AddPatientRecordScreen extends StatefulWidget {
  final VoidCallback onRecordAdded;
  const AddPatientRecordScreen({super.key, required this.onRecordAdded});

  @override
  State<AddPatientRecordScreen> createState() => _AddPatientRecordScreenState();
}

class _AddPatientRecordScreenState extends State<AddPatientRecordScreen> {
  
  int? _patientId;
  int _currentStep = 0;
  
  @override
  void initState() {
    super.initState();
    // _patientId = _patientId ?? 0;
  }

  final _personalInfoFormKey = GlobalKey<FormState>();
  final _contactInformationFormKey =  GlobalKey<FormState>();
  final _dentalInsuranceFormKey =  GlobalKey<FormState>();
  final _dentalHistoryFormKey = GlobalKey<FormState>();
  final _medicalHistoryFormKey = GlobalKey<FormState>();
  final _allergicFormKey = GlobalKey<FormState>();
  final _diseasesFormKey = GlobalKey<FormState>();

  // personal info
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _parentGuardianController = TextEditingController();
  final TextEditingController _parentGuardianOccupationController = TextEditingController();
  final TextEditingController _referrerController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final PatientController patientController = PatientController(); // patient controller
  
  // contact info
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _homeAddressController = TextEditingController();
  final TextEditingController _homeNoController = TextEditingController();
  final TextEditingController _faxNoController = TextEditingController();
  final TextEditingController _workNoController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final ContactController contactController = ContactController(); // contact controller

  // insurance info
  final TextEditingController _insuranceNameController = TextEditingController();
  final TextEditingController _insuranceEffectiveDateController = TextEditingController();
  final InsuranceController insuranceController = InsuranceController(); // insurance controller

  // dental history info
  final TextEditingController _previousDentistController = TextEditingController();
  final TextEditingController _lastVisitController = TextEditingController();
  final DentalController dentalController = DentalController(); // dental history controller

  // medical history info
  final TextEditingController _physicianNameController = TextEditingController();
  final TextEditingController _physicianSpecialtyController = TextEditingController();
  final TextEditingController _officeAddressController = TextEditingController();
  final TextEditingController _officeNumberController = TextEditingController();
  final TextEditingController _treatmentDetailsController = TextEditingController();
  final TextEditingController _seriousOperationDetailsController = TextEditingController();
  final TextEditingController _hospitalizedDetailsController = TextEditingController();
  final TextEditingController _medicationDetailsController = TextEditingController();
  final TextEditingController _bleedingTimeController = TextEditingController();
  final TextEditingController _bloodPressureController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();
  final MedicalController medicalController = MedicalController(); // medical history controller  

  // allergies info
  final TextEditingController _otherAllergiesController = TextEditingController();
  final AllergiesController allergiesController = AllergiesController(); // allergies controller

  // patient conditions info
  final ConditionsController conditionsController = ConditionsController(); // conditions controller
  final TextEditingController _otherConditionsController = TextEditingController();


  // Method to validate and move to the next step
  Future<void> _onStepContinue() async {
    if (_currentStep == 0 && _personalInfoFormKey.currentState?.validate() == true) {
      setState(() {
        _currentStep += 1;
        isContactInformationEnabled = true; // Enable the next step
      });
    } else if (_currentStep == 1 && _contactInformationFormKey.currentState?.validate() == true) {
      setState(() {
        _currentStep += 1;
        isDentalInsuranceEnabled = true; // Enable the next step
      });
    } else if (_currentStep == 2 && _dentalInsuranceFormKey.currentState?.validate() == true) {
      setState(() {
        _currentStep += 1;
        isDentalHistoryEnabled = true; // Enable the next step
      });
    } else if (_currentStep == 3 && _dentalHistoryFormKey.currentState?.validate() == true) {
      setState(() {
        _currentStep += 1;
        isMedicalHistoryEnabled = true; // Enable the next step
      });
    } else if (_currentStep == 4 && _medicalHistoryFormKey.currentState?.validate() == true) {
      setState(() {
        _currentStep += 1;
        isAllergicFormEnabled = true; // Enable the next step
      });
    } else if (_currentStep == 5 && _allergicFormKey.currentState?.validate() == true) {
      setState(() {
        _currentStep += 1;
        isDiseasesEnabled = true; // Enable the next step
      });
    } else if (_currentStep == 6 && _diseasesFormKey.currentState?.validate() == true) {
      // All steps completed, or you can handle final action here
      await _handleAddPatient();
      await _handleAddContact();
      await _handleAddInsurance();
      await _handleAddDental();
      await _handleAddMedical();
      await _handleAddAllergies();
      await _handleAddConditions();
      widget.onRecordAdded();
      Navigator.pop(context);
    }
  }

  // Method to go back to the previous step
  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }
  

  Future<void> _handleAddPatient() async {
    final patient = Patient(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      middleName: _middleNameController.text,
      nickname: _nicknameController.text,
      birthDate: _dateController.text,
      age: int.tryParse(_ageController.text) ?? 0,
      sex: selectedSex,
      religion: _religionController.text,
      nationality: _nationalityController.text,
      occupation: _occupationController.text,
      parentName: _parentGuardianController.text,
      parentOccupation: _parentGuardianOccupationController.text,
      referrer: _referrerController.text,
      reason: _reasonController.text,
    );

    try {
      final createdPatient = await patientController.createPatient(patient);
      setState(() {
        _patientId = createdPatient.id;
      });

      AnimatedSnackBar.material(
        'Patient ${createdPatient.firstName} ${createdPatient.lastName} created successfully',
        type: AnimatedSnackBarType.success,
        duration: const Duration(seconds: 3),
      ).show(context);
    } catch (error) {
      print(error);

      // AnimatedSnackBar.material(
      //   'Error creating patient: $error',
      //   type: AnimatedSnackBarType.error,
      //   duration: const Duration(seconds: 5),
      // ).show(context);
    }
  }
  
  Future<void> _handleAddContact() async {
    if (_patientId == null) {
      // Handle the case where _patientId is null
      print('Patient ID is not available');
      AnimatedSnackBar.material(
        'Patient ID is not available',
        type: AnimatedSnackBarType.warning,
        duration: const Duration(seconds: 3),
      ).show(context);
      return;
    }

    final contact = Contact(
      patient_id: _patientId!,
      home_address: _homeAddressController.text,
      fax_number: _faxNoController.text,
      home_number: _homeNoController.text,
      work_number: _workNoController.text,
      mobile_number: _mobileNoController.text,
      email: _emailController.text,
    );

    try {
      final createdContact = await contactController.createContact(contact);

      // AnimatedSnackBar.material(
      //   'Contact created successfully: $createdContact',
      //   type: AnimatedSnackBarType.success,
      //   duration: const Duration(seconds: 3),
      // ).show(context);
    } catch (error) {
      AnimatedSnackBar.material(
        'Error creating contact: $error',
        type: AnimatedSnackBarType.error,
        duration: const Duration(seconds: 5),
      ).show(context);
    }
  }


  Future<void> _handleAddInsurance() async {
    final insurance = Insurance(
      patient_id: _patientId!,
      insurance_name: _insuranceNameController.text,
      effective_date: _insuranceEffectiveDateController.text
    );

    try {
      final createdInsurance = await insuranceController.createInsurance(insurance);
      
      // AnimatedSnackBar.material(
      //   'Insurance added successfuly: $createdInsurance',
      //   type: AnimatedSnackBarType.success,
      //   duration: const Duration(seconds: 3),
      // ).show(context);
    } catch (error) {
      AnimatedSnackBar.material(
        'Error creating contact: $error',
        type: AnimatedSnackBarType.error,
        duration: const Duration(seconds: 5),
      ).show(context);
    }
  }
  

  Future<void> _handleAddDental() async {
    final dental = Dental(
      patient_id: _patientId!,
      previous_dentist: _previousDentistController.text,
      last_visit: _lastVisitController.text
    );

    try {
      final createdDental = await dentalController.createDentalHistory(dental);
      
      // AnimatedSnackBar.material(
      //   'Dental history added successfuly: $createdDental',
      //   type: AnimatedSnackBarType.success,
      //   duration: const Duration(seconds: 3),
      // ).show(context);
    } catch (error) {
      AnimatedSnackBar.material(
        'Error creating dental history: $error',
        type: AnimatedSnackBarType.error,
        duration: const Duration(seconds: 5),
      ).show(context);
    }
  }

  Future<void> _handleAddMedical() async {
    final medical = Medical(
      patient_id: _patientId!,
      medical_physician: _physicianNameController.text,
      medical_physicianSpec: _physicianSpecialtyController.text,
      medical_officeAddress: _officeAddressController.text,
      medical_officeNo: _officeNumberController.text,
      medical_goodHealth: _isInGoodHealth,
      medical_isUnderTreatment: _isUnderTreatment,
      medical_treatmentDetails: _treatmentDetailsController.text,
      medical_seriousOperation: _isSeriousIllness,
      medical_seriousOperationDetails: _seriousOperationDetailsController.text,
      medical_hospitalized: _isHospitalized,
      medical_hospitalizedDetails: _hospitalizedDetailsController.text,
      medical_isMedication: _isTakingMedication,
      medical_medicationDetails: _medicationDetailsController.text,
      medical_isTobacco: _isUsingTobacco,
      medical_dangerousSubstance: _isUsingDangerousDrugs,
      medical_bleedingTime: _bleedingTimeController.text,
      medical_bloodPressure: _bloodPressureController.text,
      medical_bloodType: _bloodTypeController.text,
      medical_isPregnant: _isPregnant,
      medical_isNursing: _isNursing,
      medical_isBirthControl: _isTakingBirthControl,
    );
    try {
      final createdMedical = await medicalController.createMedicalHistory(medical);
      
      // AnimatedSnackBar.material(
      //   'Medical history added successfuly: $createdMedical',
      //   type: AnimatedSnackBarType.success,
      //   duration: const Duration(seconds: 3),
      // ).show(context);
    } catch (error) {
      AnimatedSnackBar.material(
        'Error creating medical history: $error',
        type: AnimatedSnackBarType.error,
        duration: const Duration(seconds: 5),
      ).show(context);
    }
  }

  int _calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month || 
    (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  Future<void> _handleAddAllergies() async {
    final allergies = Allergies(
      patient_id: _patientId!,
      allergies_anesthetic: _isAllergicToAnesthetic,
      allergies_penicillin: _isAllergicToPenicillin,
      allergies_sulfaDrugs: _isAllergicToSulfa,
      allergies_aspirin: _isAllergicToAspirin,
      allergies_latex: _isAllergicToLatex,
      allergies_others: _otherAllergiesController.text
    );
    try {
      final createdAllergies = await allergiesController.createAllergy(allergies);

      // AnimatedSnackBar.material(
      //   'Allergies added successfuly: $createdAllergies',
      //   type: AnimatedSnackBarType.success,
      //   duration: const Duration(seconds: 3),
      // ).show(context);
    } catch (error) {
      AnimatedSnackBar.material(
        'Error creating allergies: $error',
        type: AnimatedSnackBarType.error,
        duration: const Duration(seconds: 5),
      ).show(context);
    }
  }

  Future<void> _handleAddConditions() async {
    List<Conditions> conditions = [
      Conditions(condition_id: 1, patientCondition_status: _isHighBlood),
      Conditions(condition_id: 2, patientCondition_status: _isLowBlood),
      Conditions(condition_id: 3, patientCondition_status: _isEpilepsy),
      Conditions(condition_id: 4, patientCondition_status: _isAIDSorHIV),
      Conditions(condition_id: 5, patientCondition_status: _isSTD),
      Conditions(condition_id: 6, patientCondition_status: _isUlcers),
      Conditions(condition_id: 7, patientCondition_status: _isFaintingSeizure),
      Conditions(condition_id: 8, patientCondition_status: _isRapidWeigthLoss),
      Conditions(condition_id: 9, patientCondition_status: _isRadiationTherapy),
      Conditions(condition_id: 10, patientCondition_status: _isJointReplacement),
      Conditions(condition_id: 11, patientCondition_status: _isHeartSurgery),
      Conditions(condition_id: 12, patientCondition_status: _isHeartAttack),
      Conditions(condition_id: 13,patientCondition_status: _isHeartDisease),
      Conditions(condition_id: 14, patientCondition_status: _isHeartMurmur),
      Conditions(condition_id: 15, patientCondition_status: _isThyroidProblem),
      Conditions(condition_id: 16, patientCondition_status: _isLiverDisease),
      Conditions(condition_id: 17, patientCondition_status: _isJaundice),
      Conditions(condition_id: 18, patientCondition_status: _isRheumaticFever),
      Conditions(condition_id: 19, patientCondition_status: _isHayFever),
      Conditions(condition_id: 20, patientCondition_status: _isRespiratoryProblems),
      Conditions(condition_id: 21, patientCondition_status: _isTuberculosis),
      Conditions(condition_id: 22, patientCondition_status: _isSwollenAnkles),
      Conditions(condition_id: 23, patientCondition_status: _isKidneyDisease),
      Conditions(condition_id: 24, patientCondition_status: _isDiabetes),
      Conditions(condition_id: 25, patientCondition_status: _isChestPain),
      Conditions(condition_id: 26, patientCondition_status: _isStroke),
      Conditions(condition_id: 27, patientCondition_status: _isCancer),
      Conditions(condition_id: 28, patientCondition_status: _isAnemia),
      Conditions(condition_id: 29, patientCondition_status: _isAngina),
      Conditions(condition_id: 30, patientCondition_status: _isAsthma),
      Conditions(condition_id: 31, patientCondition_status: _isEmphysema),
      Conditions(condition_id: 32, patientCondition_status: _isBleedingProblem),
      Conditions(condition_id: 33, patientCondition_status: _isBloodDisease),
      Conditions(condition_id: 34, patientCondition_status: _isHeadInjuries),
      Conditions(condition_id: 35, patientCondition_status: _isArthritis),
      Conditions(condition_id: 36, patientCondition_status: _othersDisease),
    ];

    final filteredConditions = conditions.where((condition) => condition.patientCondition_status == true).toList();
    final patientConditions = PatientConditions(
      patient_id: _patientId!,
      conditions: filteredConditions,
    );

    try {
      final createdPatientConditions = await conditionsController.addPatientCondition(patientConditions);

      // AnimatedSnackBar.material(
      //   'Patient conditions added successfuly: $createdPatientConditions',
      //   type: AnimatedSnackBarType.success,
      //   duration: const Duration(seconds: 3),
      // ).show(context);
    } catch (error) {
      AnimatedSnackBar.material(
        'Error creating patient conditions: $error',
        type: AnimatedSnackBarType.error,
        duration: const Duration(seconds: 5),
      ).show(context);
    }     
  }

  String? selectedSex;
  int userAge = 0;
  // Define flags to enable or disable steps
  bool isContactInformationEnabled = false;
  bool isDentalInsuranceEnabled = false;
  bool isDentalHistoryEnabled = false;
  bool isMedicalHistoryEnabled = false;
  bool isAllergicFormEnabled = false;
  bool isDiseasesEnabled = false;
  bool _isInGoodHealth = false;
  bool _isUnderTreatment = false;
  bool _isSeriousIllness = false;
  bool _isHospitalized = false;
  bool _isTakingMedication = false;
  bool _isUsingTobacco = false;
  bool _isUsingDangerousDrugs = false;
  bool _isAllergicToAnesthetic = false;
  bool _isAllergicToPenicillin = false;
  bool _isAllergicToSulfa = false;
  bool _isAllergicToAspirin = false;
  bool _isAllergicToLatex = false;
  bool _isAllergicToOthers = false;
  bool _isPregnant = false;
  bool _isNursing = false;
  bool _isTakingBirthControl = false;

  bool _isHighBlood = false;
  bool _isLowBlood = false;
  bool _isEpilepsy = false;
  bool _isAIDSorHIV = false;
  bool _isSTD = false;
  bool _isUlcers = false;
  bool _isFaintingSeizure = false;
  bool _isRapidWeigthLoss = false;
  bool _isRadiationTherapy = false;

  bool _isJointReplacement = false;
  bool _isHeartSurgery = false;
  bool _isHeartAttack = false;
  bool _isThyroidProblem= false;
  bool _isHeartDisease = false;
  bool _isHeartMurmur = false;
  bool _isLiverDisease = false;
  bool _isRheumaticFever = false;
  bool _isHayFever = false;

  bool _isRespiratoryProblems = false;
  bool _isJaundice = false;
  bool _isTuberculosis = false;
  bool _isSwollenAnkles= false;
  bool _isKidneyDisease = false;
  bool _isDiabetes = false;
  bool _isChestPain = false;
  bool _isStroke = false;
  bool _isCancer = false;

  bool _isAnemia = false;
  bool _isAngina = false;
  bool _isAsthma = false;
  bool _isEmphysema = false;
  bool _isBleedingProblem = false;
  bool _isBloodDisease = false;
  bool _isHeadInjuries = false;
  bool _isArthritis = false;
  bool _othersDisease = false;
  

  void _validateAndEnableNextSection(GlobalKey<FormState> formKey, Function(bool) setEnabled) {
    if (formKey.currentState?.validate() ?? false) {
      setEnabled(true);
    } else {
      setEnabled(false);
    }
  }

  @override
  void dispose() {
    // _firstNameController.dispose();
    // _lastNameController.dispose();
    // _middleNameController.dispose();
    // _nicknameController.dispose();
    // _dateController.dispose();
    // _ageController.dispose();
    // _religionController.dispose();
    // _nationalityController.dispose();
    // _occupationController.dispose();
    // _parentGuardianController.dispose();
    // _parentGuardianOccupationController.dispose();
    // _referrerController.dispose();
    // _reasonController.dispose();

    // _emailController.dispose();
    // _homeAddressController.dispose();
    // _homeNoController.dispose();
    // _faxNoController.dispose();
    // _workNoController.dispose();
    // _mobileNoController.dispose();
    // _insuranceNameController.dispose();
    // _insuranceEffectiveDateController.dispose();

    // _previousDentistController.dispose();
    // _lastVisitController.dispose();
    // _physicianNameController.dispose();
    // _physicianSpecialtyController.dispose();
    // _officeAddressController.dispose();
    // _officeNumberController.dispose();
    // _treatmentDetailsController.dispose();
    // _seriousOperationDetailsController.dispose();
    // _hospitalizedDetailsController.dispose();
    // _medicationDetailsController.dispose();
    // _bleedingTimeController.dispose();
    // _bloodPressureController.dispose();
    // _bloodTypeController.dispose();
    // _otherAllergiesController.dispose();

    _dateController.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 
    Material(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Padding(padding: EdgeInsets.all(16.0),),
          title: const Text('Add Patient Record'),
        ),
        
        body: Stepper(
              currentStep: _currentStep,
              onStepContinue: _onStepContinue,
              onStepCancel: _onStepCancel,
              steps: [
                Step(
                  title: const Text('Personal Information'), // Personal Information Form
                  content: Form(
                      key: _personalInfoFormKey,
                      child: Column(
                        children: [
                          // (Personal Information fields)
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
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Personal Information",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Divider(
                                      height: 10,
                                      color: Colors.grey[400],
                                      thickness: 1,
                                    ),
                                    const SizedBox(height: 10),
        
                                    // Lastname, Firstname, Middle Name, Nickname
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: _firstNameController,
                                            decoration: const InputDecoration(
                                              labelText: "Firstname",
                                              border: OutlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'This item is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            controller: _middleNameController,
                                            decoration: const InputDecoration(
                                              labelText: "Middle Name",
                                              border: OutlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'This item is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            controller: _lastNameController,
                                            decoration: const InputDecoration(
                                              labelText: "Lastname",
                                              border: OutlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'This item is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),                  
                                        Expanded(
                                          child: TextFormField(
                                            controller: _nicknameController,
                                            decoration: const InputDecoration(
                                              labelText: "Nickname",
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    // Birth Date, Age, 
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: _dateController, // Controller to manage the selected date text
                                            decoration: const InputDecoration(
                                              labelText: "Birth Date (YYYY-MM-DD)",
                                              border: OutlineInputBorder(),
                                            ),
                                            readOnly: true, // Make the field non-editable
                                            onTap: () async {
                                              DateTime? pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1900), // Set a range if needed
                                                lastDate: DateTime.now(), 
                                              );
                            
                                              if (pickedDate != null) {
                                                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                _dateController.text = formattedDate;
                                                
                                                int calculatedAge = _calculateAge(pickedDate);
                                                _ageController.text = calculatedAge.toString();
                                                userAge = calculatedAge;
                                                setState(() {}); // Set the selected date
                                              }
                                            },
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'This item is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            controller: _ageController,
                                            decoration: const InputDecoration(
                                              labelText: "Age",
                                              border: OutlineInputBorder(),
                                            ),
                                            keyboardType: TextInputType.number, // This ensures only numeric keyboard
                                            inputFormatters: [
                                              
                                              FilteringTextInputFormatter.digitsOnly, // Allows only digits
                                            ],
                                            onChanged: (value) {
                                              userAge = int.tryParse(value) ?? 0;
                                              setState(() {}); // Trigger rebuild to update AbsorbPointer
                                            },
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'This item is required';
                                              }
                                              int? minAge = 1;
                                              if ((int.tryParse(value) ?? 0) < minAge) {
                                                return 'Patient must be at least 1 year old';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: DropdownButtonFormField<String>(
                                            decoration: const InputDecoration(
                                              labelText: "Sex",
                                              border: OutlineInputBorder(),
                                            ),
                                            value: selectedSex,
                                            items: ["Male", "Female"]
                                                .map((sex) => DropdownMenuItem(
                                                      value: sex,
                                                      child: Text(sex),
                                                    ))
                                                .toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedSex = value;
                                              });
                                            },
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'This item is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    // Religion, Nationality, Occupation
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: _religionController,
                                            decoration: const InputDecoration(
                                              labelText: "Religion",
                                              border: OutlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'This item is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            controller: _nationalityController,
                                            decoration: const InputDecoration(
                                              labelText: "Nationality",
                                              border: OutlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'This item is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            controller: _occupationController,
                                            decoration: const InputDecoration(
                                              labelText: "Occupation",
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    
                                    // For Minors
                                    AbsorbPointer(
                                      absorbing: userAge >= 18,
                                      child: Opacity(
                                        opacity: (userAge < 18) ? 1.0 : 0.5,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                              const Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children:[
                                                  Text(
                                                  "For Minors", 
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              
                                              // Parent/Guardian's Name
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      controller: _parentGuardianController,
                                                      decoration: const InputDecoration(
                                                        labelText: "Parent/Guardian's Name",
                                                        border: OutlineInputBorder(),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: TextFormField(
                                                      controller: _parentGuardianOccupationController,
                                                      decoration: const InputDecoration(
                                                        labelText: "Occupation",
                                                        border: OutlineInputBorder(),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                          ],
                                        ),
                                      ),
                                    ),
                                    
                                    //Reason For Dental Consultation
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: _referrerController,
                                            decoration: const InputDecoration(
                                              labelText: "Whom may we thank for referring you?",
                                              border: OutlineInputBorder(),
                                            ),
                                            
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: TextFormField(
                                            controller: _reasonController,
                                            decoration: const InputDecoration(
                                              labelText: "What is your reason for dental consultation?",
                                              border: OutlineInputBorder(),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'This item is required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
        
                                    // //Submit Button
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.end,
                                    //   children: [
                                    //     ElevatedButton(
                                    //       onPressed: () async
                                    //       {
                                    //         _validateAndEnableNextSection(
                                    //           _personalInfoFormKey,
                                    //           (isValid) => setState(() => isContactInformationEnabled = isValid),
                                    //         );
                                    //       },
                                    //       child: const Text("Next"),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          
                        ],
                      ),
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep == 0 ? StepState.editing : StepState.complete,
                  ),
                    
                    // Contact Information Form
                    // const SizedBox(height: 10.0),
                    //       Divider(
                    //         height: 10,
                    //         color: Colors.grey[800],
                    //         thickness: 0.5,
                    //       ),
                    // const SizedBox(height: 10),
                    // AbsorbPointer(
                    //   absorbing: !isContactInformationEnabled, // Disable if not enabled
                    //   child: Opacity(
                    //     opacity: isContactInformationEnabled ? 1.0 : 0.5, // Dim if disabled
                    //     child: Column(
                    //       children: [
                            // (Contact Information  Form)
                Step(
                  title: const Text('Contact Information'),
                  content: Form(
                              key: _contactInformationFormKey,
                                child: Column(
                                  children: [
                                    // (Contact Information  fields)
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
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            const Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Contact Information",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Divider(
                                              height: 10,
                                              color: Colors.grey[400],
                                              thickness: 0.5,
                                            ),
                                            const SizedBox(height: 10),
                                            // Home Adress
                                            TextFormField(
                                              controller: _homeAddressController,
                                              decoration: const InputDecoration(
                                                labelText: "Home Address",
                                                border: OutlineInputBorder(),
                                              ),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'This item is required';
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(height: 10),
                                            // Home Number, Office Number, Fax Number
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: _homeNoController,
                                                    keyboardType: TextInputType.number,
                                                    decoration: const InputDecoration(
                                                      labelText: "Home Tel. Number",
                                                      border: OutlineInputBorder(),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: _workNoController,
                                                    keyboardType: TextInputType.number,
                                                    decoration: const InputDecoration(
                                                      labelText: "Office Number",
                                                      border: OutlineInputBorder(),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: _faxNoController,
                                                    keyboardType: TextInputType.number,
                                                    decoration: const InputDecoration(
                                                      labelText: "Fax Number",
                                                      border: OutlineInputBorder(),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
        
                                            const SizedBox(height: 10),
                                            // Contact Number and Email
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: _mobileNoController,
                                                    decoration: const InputDecoration(
                                                      labelText: "Contact Number",
                                                      border: OutlineInputBorder(),
                                                    ),
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'This item is required';
                                                      }
                                                      // Regex pattern for Philippine contact numbers
                                                      String pattern = r'^09\d{9}$'; // Validates +63 followed by 10 digits
                                                      RegExp regExp = RegExp(pattern);
                                                      if (!regExp.hasMatch(value)) {
                                                        return 'Please enter a valid Philippine contact number (e.g. 09XXXXXXXXX)';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: _emailController,
                                                    decoration: const InputDecoration(
                                                      labelText: "Email Address",
                                                      border: OutlineInputBorder(),
                                                    ),
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'This item is required';
                                                      }
                                                      // Regex pattern for validating email format
                                                      String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                                                      RegExp emailRegExp = RegExp(emailPattern);
                                                      if (!emailRegExp.hasMatch(value)) {
                                                        return 'Please enter a valid email address';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          //   const SizedBox(height: 10),
                                          //   Row(
                                          //     mainAxisAlignment: MainAxisAlignment.end,
                                          //       children: [
                                          //         //if (isDentalHistoryEnabled)
                                          //           ElevatedButton(
                                          //             onPressed: () async {
        
                                          //               _validateAndEnableNextSection(
                                          //                 _contactInformationFormKey,
                                          //                 (isValid) => setState(() => isDentalInsuranceEnabled = isValid),
                                          //               );
                                          //             },
                                          //             child: const Text("Next"),
                                          //           ),
                                          //     // Add more fields as needed for dental history
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                    ),
                                  ],
                                ),
                            ),
                          isActive: _currentStep >= 1,
                          state: _currentStep == 1 ? StepState.editing : StepState.complete,
                        ),
                      
                      
                    //   ),
                    // ),
                    
                    // // Dental Insurance Form
                    // const SizedBox(height: 10.0),
                    //       Divider(
                    //         height: 10,
                    //         color: Colors.grey[800],
                    //         thickness: 0.5,
                    //       ),
                    // const SizedBox(height: 10),
                    // AbsorbPointer(
                    //   absorbing: !isDentalInsuranceEnabled, // Disable if not enabled
                    //   child: Opacity(
                    //     opacity: isDentalInsuranceEnabled ? 1.0 : 0.5, // Dim if disabled
                    //     child: Column(
                    //       children: [
                            // (Dental History fields)
                Step(
                  title: const Text('Dental Insurance'),
                  content: Form(
                              key: _dentalInsuranceFormKey,
                                child: Column(
                                  children: [
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
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            const Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Dental Insurance",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Divider(
                                              height: 10,
                                              color: Colors.grey[400],
                                              thickness: 0.5,
                                            ),
                                            const SizedBox(height: 10),
                                            
                                            // Dental Insurance and Effective Date
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: _insuranceNameController,
                                                    decoration: const InputDecoration(
                                                      labelText: "Dental Insurance",
                                                      border: OutlineInputBorder(),
                                                    ),
                                                    
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: _insuranceEffectiveDateController, // Controller to manage the selected date text
                                                    decoration: const InputDecoration(
                                                      labelText: "Effective Date (YYYY-MM-DD)",
                                                      border: OutlineInputBorder(),
                                                    ),
                                                    onTap: () async {
                                                      DateTime? pickedDate = await showDatePicker(
                                                        context: context,
                                                        initialDate: DateTime.now(),
                                                        firstDate: DateTime(1500), // Set a range if needed
                                                        lastDate: DateTime(2100),
                                                      );
        
                                                      if (pickedDate != null && pickedDate.isBefore(DateTime.now())) {
                                                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                        _insuranceEffectiveDateController.text = formattedDate; // Set the selected date
                                                      } else {
                                                        _insuranceEffectiveDateController.clear(); // Clear the field if no date is selected  
                                                      }
                                                    },
                                                    
                                                  ),
                                                ),
                                              ],
                                            ),
                                          //   const SizedBox(height: 20),
                                    
                                          //   Row(
                                          //     mainAxisAlignment: MainAxisAlignment.end,
                                          //       children: [
                                          //         //if (isDentalHistoryEnabled)
                                          //           ElevatedButton(
                                          //             onPressed: () async {
                                          //               _validateAndEnableNextSection(
                                          //                 _dentalInsuranceFormKey,
                                          //                 (isValid) => setState(() => isDentalHistoryEnabled = isValid),
                                          //               );
        
                                          //             },
                                          //             child: const Text("Next"),
                                          //           ),
                                          //     // Add more fields as needed for dental history
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                   ),
                                  ],
                                ),
                            ),
                            isActive: _currentStep >= 2,
                            state: _currentStep == 2 ? StepState.editing : StepState.complete,
                        ),
                      
                    //   ),
                    // ),
                    
        
                    // // Dental History Form
                    // const SizedBox(height: 10.0),
                    //       Divider(
                    //         height: 10,
                    //         color: Colors.grey[800],
                    //         thickness: 0.5,
                    //       ),
                    // const SizedBox(height: 10),
                    // AbsorbPointer(
                    //   absorbing: !isDentalHistoryEnabled, // Disable if not enabled
                    //   child: Opacity(
                    //     opacity: isDentalHistoryEnabled ? 1.0 : 0.5, // Dim if disabled
                    //     child: Column(
                    //       children: [
                            // (Dental History Form)
                Step(
                  title: const Text('Dental History'),
                  content: Form(
                              key: _dentalHistoryFormKey,
                                child: Column(
                                  children: [
                                    // (Dental History fields)
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
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            const Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Dental History",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Divider(
                                              height: 10,
                                              color: Colors.grey[400],
                                              thickness: 0.5,
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: _previousDentistController,
                                                    decoration: const InputDecoration(
                                                      labelText: "Previous Dentist",
                                                      border: OutlineInputBorder(),
                                                    ),
                                                    
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: _lastVisitController,
                                                    decoration: const InputDecoration(
                                                      labelText: "Latest Dental Visit (YYYY-MM-DD)",
                                                      border: OutlineInputBorder(),
                                                    ),
                                                    onTap: () async {
                                                      DateTime? pickedDate = await showDatePicker(
                                                        context: context,
                                                        initialDate: DateTime.now(),
                                                        firstDate: DateTime(1900), // Set a range if needed
                                                        lastDate: DateTime.now()
                                                      );
                                    
                                                      if (pickedDate != null) {
                                                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                        _lastVisitController.text = formattedDate; // Set the selected date
                                                      } else {
                                                        _lastVisitController.clear(); // Clear the field if no date is selected
                                                      }
                                                    },
                                                    
                                                  ),
                                                ),
                                              ],
                                            ),
                                          //   const SizedBox(height: 10),
                                          //   Row(
                                          //     mainAxisAlignment: MainAxisAlignment.end,
                                          //       children: [
                                          //         //if (isDentalHistoryEnabled)
                                          //           ElevatedButton(
                                          //             onPressed: () async 
                                          //             {
        
                                          //               _validateAndEnableNextSection(
                                          //                 _dentalHistoryFormKey,
                                          //                 (isValid) => setState(() => isMedicalHistoryEnabled = isValid),
                                          //               );
                                          //             },
                                          //             child: const Text("Next"),
                                          //           ),
                                          //     // Add more fields as needed for dental history
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            isActive: _currentStep >= 3,
                            state: _currentStep == 3 ? StepState.editing : StepState.complete,
                          
                        ),
                    //   ),
                    // ),
                    
                    
                    // // Medical History Form
                    // const SizedBox(height: 10.0),
                    //       Divider(
                    //         height: 10,
                    //         color: Colors.grey[800],
                    //         thickness: 0.5,
                    //       ),
                    // const SizedBox(height: 10),
                    // AbsorbPointer(
                    //   absorbing: !(isDentalHistoryEnabled && isMedicalHistoryEnabled), // Disable if not enabled
                    //   child: Opacity(
                    //     opacity: (isDentalHistoryEnabled && isMedicalHistoryEnabled) ? 1.0 : 0.5, // Dim if disabled
                    //     child: Column(
                    //       children: [
                            // (Medical History fields)
                Step(
                  title: const Text('Medical History'),
                  content: Form(
                            key: _medicalHistoryFormKey,
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
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Medical History",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Divider(
                                        height: 10,
                                        color: Colors.grey[400],
                                        thickness: 0.5,
                                      ),
                                      const SizedBox(height: 10),
        
                                      // Name of Physician and Specialty
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: _physicianNameController,
                                              decoration: const InputDecoration(
                                                labelText: "Name of Physician",
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: TextFormField(
                                              controller: _physicianSpecialtyController,
                                              decoration: const InputDecoration(
                                                labelText: "Specialty, if applicable",
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
        
                                      // Office Address and Office Number
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: _officeAddressController,
                                              decoration: const InputDecoration(
                                                labelText: "Office Address",
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: TextFormField(
                                              controller: _officeNumberController,
                                              decoration: const InputDecoration(
                                                labelText: "Office Number",
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
        
                                      // Question 1
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                              "1. Are you in good health?", 
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                          Row(
                                            children: [
                                              const Text("Yes"),
                                              Radio(value: true, groupValue: _isInGoodHealth, onChanged: (value) {
                                                setState(() {
                                                  _isInGoodHealth = value!;
                                                });
                                              }),
                                              const Text("No"),
                                              Radio(value: false, groupValue: _isInGoodHealth, onChanged: (value) {
                                                setState(() {
                                                  _isInGoodHealth = value!;
                                                });
                                              }),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      
                                      // Question 2
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Main question and radio buttons in the same row
                                              const Text(
                                                "2. Are you under medical treatment now?",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              Row(
                                                children: [
                                                  const Text("Yes"),
                                                  Radio<bool>(
                                                    value: true,
                                                    groupValue: _isUnderTreatment,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _isUnderTreatment = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text("No"),
                                                  Radio<bool>(
                                                    value: false,
                                                    groupValue: _isUnderTreatment,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _isUnderTreatment = value!;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              // Conditional question
                                              AbsorbPointer(
                                                absorbing: !_isUnderTreatment, // Disable interaction if not under treatment
                                                child: Opacity(
                                                  opacity: _isUnderTreatment ? 1.0 : 0.5, // Dim if disabled
                                                  child: Row(
                                                    children: [
                                                      const Text("If so, what condition being treated? "),
                                                      SizedBox(
                                                        width: 200, // Adjust width as needed
                                                        child: TextFormField(
                                                          controller: _treatmentDetailsController,
                                                          enabled: _isUnderTreatment, // Disable the field if not under treatment
                                                          decoration: const InputDecoration(
                                                            hintText: "Specify condition",
                                                            border: UnderlineInputBorder(),
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
        
                                      //Question 3
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Main question and radio buttons in the same row
                                              const Text(
                                                "3. Have you ever had serious illness or surgical operation?",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              Row(
                                                children: [
                                                  const Text("Yes"),
                                                  Radio<bool>(
                                                    value: true,
                                                    groupValue: _isSeriousIllness,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _isSeriousIllness = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text("No"),
                                                  Radio<bool>(
                                                    value: false,
                                                    groupValue: _isSeriousIllness,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _isSeriousIllness = value!;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              // Conditional question
                                              AbsorbPointer(
                                                absorbing: !_isSeriousIllness, // Disable interaction if not under treatment
                                                child: Opacity(
                                                  opacity: _isSeriousIllness ? 1.0 : 0.5, // Dim if disabled
                                                  child: Row(
                                                    children: [
                                                      const Text("If so, what illness or operation? "),
                                                      SizedBox(
                                                        width: 200, // Adjust width as needed
                                                        child: TextFormField(
                                                          controller: _seriousOperationDetailsController,
                                                          enabled: _isSeriousIllness, // Disable the field if not under treatment
                                                          decoration: const InputDecoration(
                                                            hintText: "Specify condition",
                                                            border: UnderlineInputBorder(),
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
        
                                      //Question 4
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Main question and radio buttons in the same row
                                              const Text(
                                                "4. have you ever been hospitalized?", 
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              Row(
                                                children: [
                                                  const Text("Yes"),
                                                  Radio<bool>(
                                                    value: true,
                                                    groupValue: _isHospitalized,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _isHospitalized = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text("No"),
                                                  Radio<bool>(
                                                    value: false,
                                                    groupValue: _isHospitalized,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _isHospitalized = value!;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              // Conditional question
                                              AbsorbPointer(
                                                absorbing: !_isHospitalized, // Disable interaction if not under treatment
                                                child: Opacity(
                                                  opacity: _isHospitalized ? 1.0 : 0.5, // Dim if disabled
                                                  child: Row(
                                                    children: [
                                                      const Text("If so, when and why? "),
                                                      SizedBox(
                                                        width: 200, // Adjust width as needed
                                                        child: TextFormField(
                                                          controller: _hospitalizedDetailsController,
                                                          enabled: _isHospitalized, // Disable the field if not under treatment
                                                          decoration: const InputDecoration(
                                                            hintText: "Specify condition",
                                                            border: UnderlineInputBorder(),
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
        
                                      //Question 5
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Main question and radio buttons in the same row
                                              const Text(
                                                "5. Are you taking any prescription/non-prescription medication?",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  ),
                                              ),
                                              Row(
                                                children: [
                                                  const Text("Yes"),
                                                  Radio<bool>(
                                                    value: true,
                                                    groupValue: _isTakingMedication,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _isTakingMedication = value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text("No"),
                                                  Radio<bool>(
                                                    value: false,
                                                    groupValue: _isTakingMedication,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _isTakingMedication = value!;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              // Conditional question
                                              AbsorbPointer(
                                                absorbing: !_isTakingMedication, // Disable interaction if not under treatment
                                                child: Opacity(
                                                  opacity: _isTakingMedication ? 1.0 : 0.5, // Dim if disabled
                                                  child: Row(
                                                    children: [
                                                      const Text("If so, please specify "),
                                                      SizedBox(
                                                        width: 200, // Adjust width as needed
                                                        child: TextFormField(
                                                          controller: _medicationDetailsController,
                                                          enabled: _isTakingMedication, // Disable the field if not under treatment
                                                          decoration: const InputDecoration(
                                                            hintText: "Specify condition",
                                                            border: UnderlineInputBorder(),
                                                            contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
        
                                      //Question 6
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "6. Do you use tobacco products?",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Row(
                                            children: [
                                              const Text("Yes"),
                                              Radio(value: true, groupValue: _isUsingTobacco, onChanged: (value) {
                                                setState(() {
                                                  _isUsingTobacco = value!;
                                                });
                                              }),
                                              const Text("No"),
                                              Radio(value: false, groupValue: _isUsingTobacco, onChanged: (value) {
                                                setState(() {
                                                  _isUsingTobacco = value!;
                                                });
                                              }),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
        
                                      //Question 7
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "7. Do you use alcohol, cocaine or other dangerous drugs?",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                ),
                                            ),
                                          Row(
                                            children: [
                                              const Text("Yes"),
                                              Radio(value: true, groupValue: _isUsingDangerousDrugs, onChanged: (value) {
                                                setState(() {
                                                  _isUsingDangerousDrugs = value!;
                                                });
                                              }),
                                              const Text("No"),
                                              Radio(value: false, groupValue: _isUsingDangerousDrugs, onChanged: (value) {
                                                setState(() {
                                                  _isUsingDangerousDrugs = value!;
                                                });
                                              }),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    
                                      //Question 8
                                      Row(
                                        children: [
                                          const Text(
                                            "8. Blood Type",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 200, // Adjust width as needed
                                            child: DropdownButtonFormField<String>(
                                              value: _bloodTypeController.text.isNotEmpty ? _bloodTypeController.text : null,
                                              decoration: const InputDecoration(
                                                hintText: "Select Blood Type",
                                                border: UnderlineInputBorder(),
                                                contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                              ),
                                              items: [
                                                'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-', 'Rh+'
                                              ].map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                _bloodTypeController.text = newValue ?? '';
                                              },
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'This item is required';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 10),

                                          const Text(
                                            "Blood Pressure ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          SizedBox(
                                            width: 200, // Adjust width as needed
                                            child: TextFormField(
                                              controller: _bloodPressureController,
                                              decoration: const InputDecoration(
                                                hintText: "",
                                                border: UnderlineInputBorder(),
                                                contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                              ),
                                              validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'This item is required';
                                              }
                                              return null;
                                            },
                                            ),
                                          ),                         
                                          const SizedBox(width: 10),
                                          const Text(
                                            "Bleeding Time ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                ),
                                            ),
                                          SizedBox(
                                            width: 200, // Adjust width as needed
                                            child: TextFormField(
                                              controller: _bleedingTimeController,
                                              decoration: const InputDecoration(
                                                hintText: "",
                                                border: UnderlineInputBorder(),
                                                contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                              ),
                                            ),
                                          ),
                                            
                                          
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                  
                                      // For Women
                                      AbsorbPointer(
                                        absorbing: selectedSex == 'Male',
                                        child: Opacity(
                                          opacity: selectedSex == 'Female' ? 1.0 : 0.5,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                                const Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children:[
                                                    Text(
                                                    "For Women", 
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                
                                                // Pregnant
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                        "Are you pregant?", 
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                    Row(
                                                      children: [
                                                        const Text("Yes"),
                                                        Radio(value: true, groupValue: _isPregnant, onChanged: (value) {
                                                          setState(() {
                                                            _isPregnant = value!;
                                                          });
                                                        }),
                                                        const Text("No"),
                                                        Radio(value: false, groupValue: _isPregnant, onChanged: (value) {
                                                          setState(() {
                                                            _isPregnant = value!;
                                                          });
                                                        }),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
        
                                                // Nursing
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                        "Are you nursing?", 
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                    Row(
                                                      children: [
                                                        const Text("Yes"),
                                                        Radio(value: true, groupValue: _isNursing, onChanged: (value) {
                                                          setState(() {
                                                            _isNursing = value!;
                                                          });
                                                        }),
                                                        const Text("No"),
                                                        Radio(value: false, groupValue: _isNursing, onChanged: (value) {
                                                          setState(() {
                                                            _isNursing = value!;
                                                          });
                                                        }),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
        
                                                // Birth Controls
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                        "Are you taking birth controls?", 
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                    Row(
                                                      children: [
                                                        const Text("Yes"),
                                                        Radio(value: true, groupValue: _isTakingBirthControl, onChanged: (value) {
                                                          setState(() {
                                                            _isTakingBirthControl = value!;
                                                          });
                                                        }),
                                                        const Text("No"),
                                                        Radio(value: false, groupValue: _isTakingBirthControl, onChanged: (value) {
                                                          setState(() {
                                                            _isTakingBirthControl = value!;
                                                          });
                                                        }),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                
        
                                                // Row(
                                                //   children: [
                                                //     const Text(
                                                //       "Bleeding Time ",
                                                //       style: TextStyle(
                                                //           fontSize: 15,
                                                //           fontWeight: FontWeight.bold,
                                                //           ),
                                                //       ),
                                                //     SizedBox(
                                                //       width: 200, // Adjust width as needed
                                                //       child: TextFormField(
                                                //         decoration: const InputDecoration(
                                                //           hintText: "",
                                                //           border: UnderlineInputBorder(),
                                                //           contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                                //         ),
                                                //       ),
                                                //     ),
                                                //   ],
                                                // ),
        
                                                const SizedBox(height: 20),
                                            ],
                                          ),
                                        ),
                                      ),
        
                                      // const SizedBox(height: 10),
                                      // // Submit Button
                                      // Row(
                                      //     mainAxisAlignment: MainAxisAlignment.end,
                                      //       children: [
                                      //         //if (isDentalHistoryEnabled)
                                      //           ElevatedButton(
                                      //             onPressed: () async {
        
                                      //               _validateAndEnableNextSection(
                                      //                 _medicalHistoryFormKey,
                                      //                 (isValid) => setState(() => isAllergicFormEnabled = isValid),
                                      //               );
        
                                      //             }, 
                                      //             child: const Text("Next"),
                                      //           ),
                                      //     // Add more fields as needed for dental history
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),//Form Medical History
                            isActive: _currentStep >= 4,
                            state: _currentStep == 4 ? StepState.editing : StepState.complete,
                          
                        ),
                    //   ),
                    // ),
                  
        
                    // //Are you alergic to the following
                    // const SizedBox(height: 10.0),
                    //       Divider(
                    //         height: 10,
                    //         color: Colors.grey[800],
                    //         thickness: 0.5,
                    //       ),
                    // const SizedBox(height: 10),
                    // AbsorbPointer(
                    //   absorbing: !isAllergicFormEnabled, // Disable if not enabled
                    //   child: Opacity(
                    //     opacity: isAllergicFormEnabled ? 1.0 : 0.5, // Dim if disabled
                    //     child: Column(
                    //       children: [
                            // (Allergies Form)
                Step(
                  title: const Text('Allergies Form'),
                  content: Form(  
                              key: _allergicFormKey,
                                child: Column(
                                  children: [
                                    // (ALlergies fields)
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
                                      child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              const Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Allergies",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Divider(
                                                height: 10,
                                                color: Colors.grey[400],
                                                thickness: 0.5,
                                              ),
                                              const SizedBox(height: 10),
                                              // Allergies Question
                                              Row(
                                              children: [
                                                const Text(
                                                  "Are you allergic to any of the following:",
                                                  style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                          ),
                                                ),
                                                const SizedBox(width: 10),
                                                Wrap(
                                                  spacing: 10,
                                                  runSpacing: 10,
                                                  children: [
                                                    Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const SizedBox(height: 50),
                                                        Checkbox(
                                                          value: _isAllergicToAnesthetic,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _isAllergicToAnesthetic = value!;
                                                            });
                                                          },
                                                        ),
                                                        const Text("Local Anesthetic (ex. Lidocaine)"),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const SizedBox(height: 50),
                                                        Checkbox(
                                                          value: _isAllergicToPenicillin,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _isAllergicToPenicillin = value!;
                                                            });
                                                          },
                                                        ),
                                                        const Text("Penicillin, Antibiotics"),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const SizedBox(height: 50),
                                                        Checkbox(
                                                          value: _isAllergicToSulfa,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _isAllergicToSulfa = value!;
                                                            });
                                                          },
                                                        ),
                                                        const Text("Sulfa drugs"),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const SizedBox(height: 50),
                                                        Checkbox(
                                                          value: _isAllergicToAspirin,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _isAllergicToAspirin = value!;
                                                            });
                                                          },
                                                        ),
                                                        const Text("Aspirin"),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const SizedBox(height: 50),
                                                        Checkbox(
                                                          value: _isAllergicToLatex,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _isAllergicToLatex = value!;
                                                            });
                                                          },
                                                        ),
                                                        const Text("Latex"),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Checkbox(
                                                          value: _isAllergicToOthers,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _isAllergicToOthers = value!;
                                                            });
                                                          },
                                                        ),
                                                        const Text("Others: "),
                                                        const SizedBox(width: 5),
                                                        // Text field for specifying other allergies
                                                        SizedBox(
                                                          width: 150, // Adjust width as needed
                                                          child: TextFormField(
                                                            controller: _otherAllergiesController,
                                                            enabled: _isAllergicToOthers,
                                                            decoration: const InputDecoration(
                                                              hintText: "Specify other allergies",
                                                              border: UnderlineInputBorder(),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          
                                            //   //Submit Button
                                            //   Row(
                                            //     mainAxisAlignment: MainAxisAlignment.end,
                                            //       children: [
                                            //         //if (isMedicalHistoryEnabled)
                                            //           ElevatedButton(
                                            //             onPressed: () async {
                                            //               _validateAndEnableNextSection(
                                            //                 _allergicFormKey,
                                            //                 (isValid) => setState(() => isDiseasesEnabled = isValid),
                                            //               );
                                            //             },
                                            //             child: const Text("Next"),
                                            //           ),
                                            //     // Add more fields as needed for dental history
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ),
                            isActive: _currentStep >= 5,
                            state: _currentStep == 5 ? StepState.editing : StepState.complete,
                        ),
                    //   ),
                    // ),
                    
                    // Diseases Form
                    // const SizedBox(height: 10.0),
                    //       Divider(
                    //         height: 10,
                    //         color: Colors.grey[800],
                    //         thickness: 0.5,
                    //       ),
                    // const SizedBox(height: 10),
                    // AbsorbPointer(
                    //   absorbing: !isDiseasesEnabled, // Disable if not enabled
                    //   child: Opacity(
                    //     opacity: isDiseasesEnabled ? 1.0 : 0.5, // Dim if disabled
                    //     child: Column(
                    //       children: [
                            // (Diseases Form)
              Step(
                  title: const Text('Diseases Form'),
                  content: Form(
                              key: _diseasesFormKey,
                                child: Column(
                                  children: [
                                    // (Diseases fields)
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
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            const Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Diseases",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Divider(
                                              height: 10,
                                              color: Colors.grey[400],
                                              thickness: 0.5,
                                            ),
                                            const SizedBox(height: 10),
        
                                            //Diseases
                                            const Row(
                                              children: [
                                                Text(
                                                      "Do you have or have you had any of the following? Check which apply",
                                                      style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.bold,
                                                              ),
                                                    ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                              Wrap(
                                                spacing: 10,
                                                runSpacing: 10,
                                                children: [
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isHighBlood,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isHighBlood = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("High Blood Pressure"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isLowBlood,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isLowBlood = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Low Blood Pressure"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isEpilepsy,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isEpilepsy = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Epilepsy / Convulsions"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isAIDSorHIV,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isAIDSorHIV = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("AIDS or HIV Infection"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              const SizedBox(height: 10),
                                                              Checkbox(
                                                                value: _isSTD,
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    _isSTD = value!;
                                                                  });
                                                                },
                                                              ),
                                                              const Text("Sexual Transmitted Disease"),
                                                            ],
                                                          ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isUlcers,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isUlcers = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Stomach Troubles / Ulcers"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isFaintingSeizure,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isFaintingSeizure = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Fainting Seizure"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              const SizedBox(height: 10),
                                                              Checkbox(
                                                                value: _isRapidWeigthLoss,
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    _isRapidWeigthLoss = value!;
                                                                  });
                                                                },
                                                              ),
                                                              const Text("Rapid weigth Loss"),
                                                            ],
                                                          ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isRadiationTherapy,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isRadiationTherapy = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Radiation Therapy"),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
        
        
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isJointReplacement,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isJointReplacement = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Joint Replacement / Implants"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isHeartSurgery,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isHeartSurgery = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Heart Surgery"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isHeartAttack,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isHeartAttack = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Heart Attack"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isThyroidProblem,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isThyroidProblem = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Thyroid Problem"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              const SizedBox(height: 10),
                                                              Checkbox(
                                                                value: _isHeartDisease,
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    _isHeartDisease = value!;
                                                                  });
                                                                },
                                                              ),
                                                              const Text("Heart Disease"),
                                                            ],
                                                          ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isHeartMurmur,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isHeartMurmur = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Heart Murmur"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isLiverDisease,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isLiverDisease = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Hepatitis / Liver Disease"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              const SizedBox(height: 10),
                                                              Checkbox(
                                                                value: _isRheumaticFever,
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    _isRheumaticFever = value!;
                                                                  });
                                                                },
                                                              ),
                                                              const Text("Rheumatic Fever"),
                                                            ],
                                                          ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isHayFever,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isHayFever = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Hay Fever / Allergies"),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
        
        
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isRespiratoryProblems,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isRespiratoryProblems = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Respiratory Problems"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isJaundice,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isJaundice = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Hepatitis / Jaundice"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isTuberculosis,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isTuberculosis = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Tuberculosis"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isSwollenAnkles,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isSwollenAnkles = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Swollen Ankles"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              const SizedBox(height: 10),
                                                              Checkbox(
                                                                value: _isKidneyDisease,
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    _isKidneyDisease = value!;
                                                                  });
                                                                },
                                                              ),
                                                              const Text("Kidney Disease"),
                                                            ],
                                                          ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isDiabetes,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isDiabetes = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Diabetes"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isChestPain,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isChestPain = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Chest Pain"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              const SizedBox(height: 10),
                                                              Checkbox(
                                                                value: _isStroke,
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    _isStroke = value!;
                                                                  });
                                                                },
                                                              ),
                                                              const Text("Stroke"),
                                                            ],
                                                          ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isCancer,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isCancer = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Cancer / Tumors"),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
        
                                                  
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isAnemia,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isAnemia = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Anemia"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isAngina,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isAngina = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Angina"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isAsthma,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isAsthma = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Asthma"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isEmphysema,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isEmphysema = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Emphysema"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              const SizedBox(height: 10),
                                                              Checkbox(
                                                                value: _isBleedingProblem,
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    _isBleedingProblem = value!;
                                                                  });
                                                                },
                                                              ),
                                                              const Text("Bleeding Problems"),
                                                            ],
                                                          ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isBloodDisease,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isBloodDisease = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Blood Diseases"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            const SizedBox(height: 10),
                                                            Checkbox(
                                                              value: _isHeadInjuries,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _isHeadInjuries = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Head Injuries"),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              const SizedBox(height: 10),
                                                              Checkbox(
                                                                value: _isArthritis,
                                                                onChanged: (value) {
                                                                  setState(() {
                                                                    _isArthritis = value!;
                                                                  });
                                                                },
                                                              ),
                                                              const Text("Arthritis / Rheumatism"),
                                                            ],
                                                          ),
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Checkbox(
                                                              value: _othersDisease,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  _othersDisease = value!;
                                                                });
                                                              },
                                                            ),
                                                            const Text("Others: "),
                                                            const SizedBox(width: 5),
                                                            // Text field for specifying other allergies
                                                            SizedBox(
                                                              width: 150, // Adjust width as needed
                                                              child: TextFormField(
                                                                controller: _otherConditionsController,
                                                                enabled: _othersDisease,
                                                                decoration: const InputDecoration(
                                                                  hintText: "Specify other disease",
                                                                  border: UnderlineInputBorder(),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
        
                                          //   //Submit Button
                                          //   Row(
                                          //     mainAxisAlignment: MainAxisAlignment.end,
                                          //       children: [
                                          //           ElevatedButton(
                                          //             onPressed: () async {
                                          //               _validateAndEnableNextSection(
                                          //                 _diseasesFormKey,
                                          //                 (isValid) => setState(() => isMedicalHistoryEnabled = isValid),
                                          //               );
                                          //               await _handleAddPatient();
                                          //               await _handleAddContact();
                                          //               await _handleAddInsurance();
                                          //               await _handleAddDental();
                                          //               await _handleAddMedical();
                                          //               await _handleAddAllergies();
                                          //               await _handleAddConditions();
                                          //             },
                                          //             child: const Text("Submit All"),
                                          //           ),
                                          //     // Add more fields as needed for dental history
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            isActive: _currentStep >= 6,
                            state: _currentStep == 6 ? StepState.editing : StepState.complete,
                        ),
                        ],
                      ),
      ),
    );
  }
}

