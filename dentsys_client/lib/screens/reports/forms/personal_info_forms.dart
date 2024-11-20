import 'package:dentsys_client/controllers/patient_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PersonalInfoForms extends StatefulWidget {
  final TextEditingController birthdateController;

  const PersonalInfoForms({super.key, required this.birthdateController, required GlobalKey<FormState> formKey});

  @override
  PersonalInfoFormsState createState() => PersonalInfoFormsState();
}

class PersonalInfoFormsState extends State<PersonalInfoForms> {
  final _personalInfoFormKey = GlobalKey<FormState>();
  

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
  final PatientController patientController = PatientController();
  

  String? selectedSex;
  int userAge = 0;
  
  
  void pickBirthdate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        widget.birthdateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }
  @override
  void dispose() {
    _dateController.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return  Form(
      key: _personalInfoFormKey,
      child: Column(
        children: [
          // (Personal Information fields)
          Padding(
            padding: const EdgeInsets.all(10.0),
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
    
                  // Lastname, Firstname, Middle Name, Nickname
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                          controller: _nicknameController,
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
                          readOnly: false, // Make the field non-editable
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900), // Set a range if needed
                              lastDate: DateTime(2100),
                            );
          
                            if (pickedDate != null) {
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              _dateController.text = formattedDate; // Set the selected date
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
    
                  
                 ],
              ),
            ),
          
        ],
      ),
    );
  }
}