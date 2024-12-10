// lib/forms/personal_info_form.dart
import 'package:dentsys_client/models/insurance_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dentsys_client/models/insurance_model.dart';

class DentalInsuranceForms extends StatefulWidget {
  final TextEditingController insuranceNameController;
  final TextEditingController effectivedateController;
  final Insurance? insurance;

  const DentalInsuranceForms({
    required this.effectivedateController, 
    required this.insuranceNameController,
    super.key, 
    required GlobalKey<FormState> formKey, 
    this.insurance
  });

  @override
  DentalInsuranceFormsState createState() => DentalInsuranceFormsState();
}

class DentalInsuranceFormsState extends State<DentalInsuranceForms> {
  final _dentalInsuranceFormKey =  GlobalKey<FormState>();

  void pickEffectiveDate() async {
    DateTime? pickedEffectiveDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedEffectiveDate != null) {
      setState(() {
        widget.effectivedateController.text = DateFormat('yyyy-MM-dd').format(pickedEffectiveDate);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // widget.effectivedateController.dispose(); // Dispose the controller when the widget is disposed
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
                          controller: widget.insuranceNameController,
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
                          controller: widget.effectivedateController, // Controller to manage the selected date text
                          decoration: const InputDecoration(
                            labelText: "Effective Date (MM-DD-YYYY)",
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true, // Make the field non-editable
                          onTap: () async {
                            DateTime? pickedEffectiveDate = await showDatePicker(
                              context: context,
                              initialDate: widget.effectivedateController.text.isNotEmpty ? DateFormat('yyyy-MM-dd').parse(widget.effectivedateController.text) : DateTime.now(),
                              firstDate: DateTime(1500), // Set a range if needed
                              lastDate: DateTime(2100),
                            );
          
                            if (pickedEffectiveDate != null) {
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedEffectiveDate);
                              widget.effectivedateController.text = formattedDate; // Set the selected date
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
