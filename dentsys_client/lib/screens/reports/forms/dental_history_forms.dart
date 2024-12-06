import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DentalHistoryForms extends StatefulWidget {
  final TextEditingController previousDentistController;
  final TextEditingController latestvisitController;

  const DentalHistoryForms({
    super.key, 
    required GlobalKey<FormState> formKey,
    required this.latestvisitController,
    required this.previousDentistController,
  });

  @override
  DentalHistoryFormsState createState() => DentalHistoryFormsState();
}

class DentalHistoryFormsState extends State<DentalHistoryForms> {
  final _dentalHistoryFormKey =  GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();

  void pickLatestVisitDate() async {
    DateTime? pickLatestVisitDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickLatestVisitDate != null) {
      setState(() {
        widget.latestvisitController.text = DateFormat('yyyy-MM-dd').format(pickLatestVisitDate);
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
      key: _dentalHistoryFormKey,
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
                  
                  // Dental Insurance and Effective Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: widget.previousDentistController,
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
                          controller: widget.latestvisitController, // Controller to manage the selected date text
                          decoration: const InputDecoration(
                            labelText: "Latest Dental Visit (MM-DD-YYYY)",
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true, // Make the field non-editable
                          onTap: () async {
                            DateTime? pickLatestVisitDate = await showDatePicker(
                              context: context,
                              initialDate: widget.latestvisitController.text.isNotEmpty ? DateFormat('yyyy-MM-dd').parse(widget.latestvisitController.text) : DateTime.now(),
                              firstDate: DateTime(1900), // Set a range if needed
                              lastDate: DateTime(2100),
                            );
          
                            if (pickLatestVisitDate != null) {
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickLatestVisitDate);
                              widget.latestvisitController.text = formattedDate; // Set the selected date
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
