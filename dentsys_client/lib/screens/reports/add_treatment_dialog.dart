import 'package:flutter/material.dart';
import 'package:dentsys_client/controllers/procedure_controller.dart';
import 'package:dentsys_client/models/procedure_model.dart';

class AddTreatmentDialog extends StatefulWidget {
  const AddTreatmentDialog({super.key});

  @override
  _AddTreatmentDialogState createState() => _AddTreatmentDialogState();
}

class _AddTreatmentDialogState extends State<AddTreatmentDialog> {


  List<String> proceduresDone = [];
  final Map<String, List<String>> servicesOffered = {
    "Consultations": ["General Consultation", "Specialized Consultation"],
    "Oral Surgery": ["Tooth Extraction", "Impacted Tooth Surgery"],
    "Dentures": ["Standard Complete", "Flexible Complete", "Flexible Partial"],
  };
  List<Procedure> proceduresDone1 = [];

  @override
  void initState() {
    super.initState();
    loadProcedures();
  }

  Future<void> loadProcedures() async {
    final List<Procedure> procedures = await ProcedureController().getAllProcedures();
    setState(() {
      proceduresDone1 = procedures;
    });

    print(proceduresDone1);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Add Patient Treatment',
        textAlign: TextAlign.left,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
      ),
      content: SizedBox(
        width: 700,
        height: 400,
        child: Row(
          children: [
            // Left Side: Procedure/s Done
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Procedure/s Done',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView.builder(
                      itemCount: proceduresDone.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(proceduresDone[index]),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                proceduresDone.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const VerticalDivider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            const SizedBox(width: 10),
            // Right Side: Services Offered
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Services Offered',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView(
                      children: servicesOffered.keys.map((category) {
                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: category,
                            border: const UnderlineInputBorder(),
                          ),
                          items: servicesOffered[category]!
                              .map((service) => DropdownMenuItem<String>(
                                    value: service,
                                    child: Text(service),
                                  ))
                              .toList(),
                          onChanged: (String? selectedService) {
                            if (selectedService != null &&
                                !proceduresDone.contains(selectedService)) {
                              setState(() {
                                proceduresDone.add(selectedService);
                              });
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
          child: const Text('Add Treatment'),
          onPressed: () {
            // Logic to save the data
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}


void showAddTreatmentDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const AddTreatmentDialog();
    },
  );
}