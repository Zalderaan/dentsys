import 'package:flutter/material.dart';

class AddPatientRecordScreen extends StatefulWidget {
  const AddPatientRecordScreen({super.key});

  @override
  State<AddPatientRecordScreen> createState() => _AddPatientRecordScreenState();
}

class _AddPatientRecordScreenState extends State<AddPatientRecordScreen> {
  final _personalInfoFormKey = GlobalKey<FormState>();
  final _dentalHistoryFormKey = GlobalKey<FormState>();
  final _medicalHistoryFormKey = GlobalKey<FormState>();

  String? selectedSex;
  bool isDentalHistoryEnabled = false;
  bool isMedicalHistoryEnabled = false;
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
  

  void _validateAndEnableNextSection(GlobalKey<FormState> formKey, Function(bool) setEnabled) {
    if (formKey.currentState?.validate() ?? false) {
      setEnabled(true);
    } else {
      setEnabled(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
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
                  child: const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Add Patient Records",
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 66, 43, 21),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                // Personal Information Form
                Form(
                  key: _personalInfoFormKey,
                  child: Column(
                    children: [
                      // (Personal Information fields)
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
                                        decoration: const InputDecoration(
                                          labelText: "Nickname",
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
                                const SizedBox(height: 15),
                                // Birth Date, Age, Sex
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          labelText: "Birth Date (YYYY-MM-DD)",
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
                                        decoration: const InputDecoration(
                                          labelText: "Age",
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
                                const SizedBox(height: 15),
                                // Home Address
                                TextFormField(
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
                                const SizedBox(height: 15),
                                // Religion, Nationality, Occupation
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
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
                                        decoration: const InputDecoration(
                                          labelText: "Occupation",
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
                                const SizedBox(height: 15),
                                // Dental Insurance and Effective Date
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          labelText: "Dental Insurance",
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
                                        decoration: const InputDecoration(
                                          labelText: "Effective Date (YYYY-MM-DD)",
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
                                const SizedBox(height: 20),
                                // Submit Button
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => _validateAndEnableNextSection(
                                        _personalInfoFormKey,
                                        (isValid) => setState(() => isDentalHistoryEnabled = isValid),
                                      ),
                                      child: const Text("Next"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      
                    ],
                  ),
                ),
                
                
                // Dental History Form
                const SizedBox(height: 10.0),
                      Divider(
                        height: 10,
                        color: Colors.grey[800],
                        thickness: 1,
                      ),
                const SizedBox(height: 10),
                AbsorbPointer(
                  absorbing: !isDentalHistoryEnabled, // Disable if not enabled
                  child: Opacity(
                    opacity: isDentalHistoryEnabled ? 1.0 : 0.5, // Dim if disabled
                    child: Form(
                      key: _dentalHistoryFormKey,
                      child: Column(
                        children: [
                          // (Dental History fields)
                          Form(
                              child: Container(
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
                                        thickness: 1,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                            decoration: const InputDecoration(
                                              labelText: "Previous Dentist",
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
                                            decoration: const InputDecoration(
                                              labelText: "Latest Dental Visit",
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            //if (isDentalHistoryEnabled)
                                              ElevatedButton(
                                                onPressed: () => _validateAndEnableNextSection(
                                                  _dentalHistoryFormKey,
                                                  (isValid) => setState(() => isMedicalHistoryEnabled = isValid),
                                                ),
                                                child: const Text("Next"),
                                              ),
                                        // Add more fields as needed for dental history
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                
                // Medical History Form
                const SizedBox(height: 10.0),
                      Divider(
                        height: 10,
                        color: Colors.grey[800],
                        thickness: 1,
                      ),
                const SizedBox(height: 10),
                AbsorbPointer(
                  absorbing: !(isDentalHistoryEnabled && isMedicalHistoryEnabled), // Disable if not enabled
                  child: Opacity(
                    opacity: (isDentalHistoryEnabled && isMedicalHistoryEnabled) ? 1.0 : 0.5, // Dim if disabled
                    child: Column(
                      children: [
                        // (Medical History fields)
                        Form(
                        key: _medicalHistoryFormKey,
                          child: Container(
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
                                    thickness: 1,
                                  ),
                                  const SizedBox(height: 10),

                                  // Name of Physician and Specialty
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            labelText: "Name of Physician",
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TextFormField(
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
                                          decoration: const InputDecoration(
                                            labelText: "Office Address",
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TextFormField(
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

                                  // Question 8 - Allergies
                                  const Text(
                                    "8. Are you allergic to any of the following:",
                                    style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            ),
                                  ),
                                  const SizedBox(height: 10),
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
                                  const SizedBox(height: 10),

                                  //Question 9
                                  Row(
                                    children: [
                                      const Text(
                                        "9. Bleeding Time ",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            ),
                                        ),
                                      SizedBox(
                                        width: 200, // Adjust width as needed
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            hintText: "",
                                            border: UnderlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 30),
                                      const Text(
                                        "Blood Type ",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      SizedBox(
                                        width: 200, // Adjust width as needed
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            hintText: "",
                                            border: UnderlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 30),
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
                                          decoration: const InputDecoration(
                                            hintText: "",
                                            border: UnderlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  //Question 11
                                  Row(
                                    children: [
                                    ],
                                  ),


                                  const SizedBox(height: 10),
                                  // Submit Button
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          if (_medicalHistoryFormKey.currentState?.validate() ?? false) {
                                            // Submit all forms data
                                          }
                                        },
                                        child: const Text("Submit All"),
                                      ),
                                    ],
                                  ),
                                  
                                ],
                              ),
                            ),
                          ),
                        ),//Form Medical History

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

