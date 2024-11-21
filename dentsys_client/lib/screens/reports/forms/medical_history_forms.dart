// lib/forms/personal_info_form.dart
import 'package:flutter/material.dart';

class MedicalHistoryForms extends StatefulWidget {
  final TextEditingController physicianNameController;
  final TextEditingController physicianSpecialtyController;
  final TextEditingController officeAddressController;
  final TextEditingController officeNumberController;
  final TextEditingController medicalTreatmentDetailsController;
  final TextEditingController seriousIllnessDetailsController;
  final TextEditingController hospitalizationDetailsController;
  final TextEditingController medicationDetailsController;
  final TextEditingController bloodTypeController;
  final TextEditingController bloodPressureController;
  final TextEditingController bleedingTimeController;
  final bool isInGoodHealth;
  final bool isUnderTreatment;
  final bool isSeriousIllness;
  final bool isHospitalized;
  final bool isTakingMedication;
  final bool isUsingTobacco;
  final bool isUsingDangerousDrugs;
  final bool? isPregnant;
  final bool? isNursing;
  final bool? isTakingBirthControl;
  final Function(bool, bool, bool, bool, bool, bool, bool, bool?, bool?, bool?) onUpdated; // callback function
  
  MedicalHistoryForms({
    super.key, 
    required GlobalKey<FormState> formKey,
    required this.physicianNameController,
    required this.physicianSpecialtyController,
    required this.officeAddressController,
    required this.officeNumberController,
    required this.medicalTreatmentDetailsController,
    required this.seriousIllnessDetailsController,
    required this.hospitalizationDetailsController,
    required this.medicationDetailsController,
    required this.bloodTypeController,
    required this.bloodPressureController,
    required this.bleedingTimeController,
    required this.isInGoodHealth,
    required this.isUnderTreatment,
    required this.isSeriousIllness,
    required this.isHospitalized,
    required this.isTakingMedication,
    required this.isUsingTobacco,
    required this.isUsingDangerousDrugs,
    required this.isPregnant,
    required this.isNursing,
    required this.isTakingBirthControl,
    required this.onUpdated,
  });

  @override
  MedicalHistoryFormsState createState() => MedicalHistoryFormsState();
}

class MedicalHistoryFormsState extends State<MedicalHistoryForms> {
  final _medicalHistoryFormKey = GlobalKey<FormState>();
  
  String? selectedSex;
  late bool _isInGoodHealth;
  late bool _isUnderTreatment;
  late bool _isSeriousIllness;
  late bool _isHospitalized;
  late bool _isTakingMedication;
  late bool _isUsingTobacco;
  late bool _isUsingDangerousDrugs;
  late bool? _isPregnant;
  late bool? _isNursing;
  late bool? _isTakingBirthControl;

  @override
  void initState() {
    super.initState();
    _isInGoodHealth = widget.isInGoodHealth;
    _isUnderTreatment = widget.isUnderTreatment;
    _isSeriousIllness = widget.isSeriousIllness;
    _isHospitalized = widget.isHospitalized;
    _isTakingMedication = widget.isTakingMedication;
    _isUsingTobacco = widget.isUsingTobacco;
    _isUsingDangerousDrugs = widget.isUsingDangerousDrugs;
    _isPregnant = widget.isPregnant;
    _isNursing = widget.isNursing;
    _isTakingBirthControl = widget.isTakingBirthControl;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
    key: _medicalHistoryFormKey,
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
                    controller: widget.physicianNameController,
                    decoration: const InputDecoration(
                      labelText: "Name of Physician",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: widget.physicianSpecialtyController,
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
                    controller: widget.officeAddressController,
                    decoration: const InputDecoration(
                      labelText: "Office Address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: widget.officeNumberController,
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
                      widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);
                    }),
                    const Text("No"),
                    Radio(value: false, groupValue: _isInGoodHealth, onChanged: (value) {
                      setState(() {
                        _isInGoodHealth = value!;
                      });
                      widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);
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
                            widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);
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
                            widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);
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
                                controller: widget.medicalTreatmentDetailsController,
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
                            widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);
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
                            widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);
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
                                controller: widget.seriousIllnessDetailsController,
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
                            widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);
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
                            widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);
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
                                controller: widget.hospitalizationDetailsController,
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
                            widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);
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
                            widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);
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
                                controller: widget.medicationDetailsController,
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
                      widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);
                    }),
                    const Text("No"),
                    Radio(value: false, groupValue: _isUsingTobacco, onChanged: (value) {
                      setState(() {
                        _isUsingTobacco = value!;
                      });
                      widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);                      
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
                      widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);
                    }),
                    const Text("No"),
                    Radio(value: false, groupValue: _isUsingDangerousDrugs, onChanged: (value) {
                      setState(() {
                        _isUsingDangerousDrugs = value!;
                      });
                      widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);
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
                  "8. Blood Type ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  width: 200, // Adjust width as needed
                  child: TextFormField(
                    controller: widget.bloodTypeController,
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
                  "Blood Pressure ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  width: 200, // Adjust width as needed
                  child: TextFormField(
                    controller: widget.bloodPressureController,
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
                    controller: widget.bleedingTimeController,
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
                                widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);
                              }),
                              const Text("No"),
                              Radio(value: false, groupValue: _isPregnant, onChanged: (value) {
                                setState(() {
                                  _isPregnant = value!;
                                });
                                widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);
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
                                widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);
                              }),
                              const Text("No"),
                              Radio(value: false, groupValue: _isNursing, onChanged: (value) {
                                setState(() {
                                  _isNursing = value!;
                                });
                                widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);
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
                                widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);
                              }),
                              const Text("No"),
                              Radio(value: false, groupValue: _isTakingBirthControl, onChanged: (value) {
                                setState(() {
                                  _isTakingBirthControl = value!;
                                });
                                widget.onUpdated(_isInGoodHealth, _isUnderTreatment, _isSeriousIllness, _isHospitalized, _isTakingMedication, _isUsingTobacco, _isUsingDangerousDrugs, _isPregnant, _isNursing, _isTakingBirthControl);
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

            const SizedBox(height: 10),
            // Submit Button
          ],
        ),
      ),
    );//Form Medical History
  }
}
