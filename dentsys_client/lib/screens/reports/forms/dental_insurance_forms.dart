// lib/forms/personal_info_form.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DentalInsuranceForms extends StatefulWidget {
  final TextEditingController effectivedateController;

   const DentalInsuranceForms({super.key, required GlobalKey<FormState> formKey, required this.effectivedateController});

  @override
  DentalInsuranceFormsState createState() => DentalInsuranceFormsState();
}

class DentalInsuranceFormsState extends State<DentalInsuranceForms> {
  final _dentalInsuranceFormKey =  GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();

  void pickEffectiveDate() async {
    DateTime? pickEffectiveDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickEffectiveDate != null) {
      setState(() {
        widget.effectivedateController.text = DateFormat('yyyy-MM-dd').format(pickEffectiveDate);
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
    return Form(
      key: _dentalInsuranceFormKey,
        child: Column(
          children: [
            Padding(
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
                          controller: _dateController, // Controller to manage the selected date text
                          decoration: const InputDecoration(
                            labelText: "Effective Date (MM-DD-YYYY)",
                            border: OutlineInputBorder(),
                          ),
                          readOnly: false, // Make the field non-editable
                          onTap: () async {
                            DateTime? pickEffectiveDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900), // Set a range if needed
                              lastDate: DateTime(2100),
                            );
          
                            if (pickEffectiveDate != null) {
                              String formattedDate = DateFormat('MM-dd-yyyy').format(pickEffectiveDate);
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
