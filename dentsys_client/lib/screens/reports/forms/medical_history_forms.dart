// lib/forms/personal_info_form.dart
import 'package:flutter/material.dart';

class MedicalHistoryForms extends StatefulWidget {
  
  const MedicalHistoryForms({super.key, required GlobalKey<FormState> formKey});

  @override
  MedicalHistoryFormsState createState() => MedicalHistoryFormsState();
}

class MedicalHistoryFormsState extends State<MedicalHistoryForms> {
  final _medicalHistoryFormKey = GlobalKey<FormState>();
  
  String? selectedSex;
  bool _isInGoodHealth = false;
  bool _isUnderTreatment = false;
  bool _isSeriousIllness = false;
  bool _isHospitalized = false;
  bool _isTakingMedication = false;
  bool _isUsingTobacco = false;
  bool _isUsingDangerousDrugs = false;
  bool _isPregnant = false;
  bool _isNursing = false;
  bool _isTakingBirthControl = false;

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

            const SizedBox(height: 10),
            // Submit Button
          ],
        ),
      ),
    );//Form Medical History
  }
}
