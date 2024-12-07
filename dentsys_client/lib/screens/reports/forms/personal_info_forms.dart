import 'package:dentsys_client/controllers/patient_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:dentsys_client/models/patient_model.dart';


class PersonalInfoForms extends StatefulWidget {
  final Patient? patient;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController middleNameController;
  final TextEditingController nicknameController;
  final String? selectedSex;
  final TextEditingController ageController;
  final TextEditingController religionController;
  final TextEditingController nationalityController;
  final TextEditingController occupationController;
  final TextEditingController parentNameController;
  final TextEditingController parentOccupationController;
  final TextEditingController referrerController;
  final TextEditingController reasonController;
  final TextEditingController birthdateController;
  final Function(String?) onSexChanged;

  const PersonalInfoForms({
    super.key, 
    required GlobalKey<FormState> formKey, this.patient,
    required this.firstNameController,
    required this.lastNameController,
    required this.middleNameController,
    required this.nicknameController,
    required this.selectedSex,
    required this.ageController,
    required this.birthdateController, 
    required this.religionController,
    required this.nationalityController,
    required this.occupationController,
    required this.referrerController,
    required this.reasonController,
    required this.parentNameController,
    required this.parentOccupationController,
    required this.onSexChanged,
  });

  @override
  PersonalInfoFormsState createState() => PersonalInfoFormsState();
}

class PersonalInfoFormsState extends State<PersonalInfoForms> {
  final _personalInfoFormKey = GlobalKey<FormState>();
  String? selectedSex;
  int userAge = 0;
  
  
  void pickBirthdate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.birthdateController.text.isNotEmpty ? DateFormat('yyyy-MM-dd').parse(widget.birthdateController.text) : DateTime.now(),
      firstDate: DateTime(1900), // Set a range if needed
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      widget.birthdateController.text = formattedDate; // Set the selected date
    }
  }
  @override
  void dispose() {
    // _dateController.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  @override 
  void initState(){
    super.initState();
    selectedSex = widget.selectedSex; // initial data for patient sex
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
                          controller: widget.firstNameController,
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
                          controller: widget.middleNameController,
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
                          controller: widget.lastNameController,
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
                          controller: widget.nicknameController,
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
                          controller: widget.birthdateController, // Controller to manage the selected date text
                          decoration: const InputDecoration(
                            labelText: "Birth Date (YYYY-MM-DD)",
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true, // Make the field non-editable
                          onTap: () async {
                            pickBirthdate(); // Show the date picker
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
                          controller: widget.ageController,
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
                              widget.onSexChanged(selectedSex);
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
                          controller: widget.religionController,
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
                          controller: widget.nationalityController,
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
                          controller: widget.occupationController,
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
                                    controller: widget.parentNameController,
                                    decoration: const InputDecoration(
                                      labelText: "Parent/Guardian's Name",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    controller: widget.parentOccupationController,
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
                          controller: widget.referrerController,
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
                          controller: widget.reasonController,
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
