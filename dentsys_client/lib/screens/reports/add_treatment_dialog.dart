import 'package:flutter/material.dart';
import 'package:dentsys_client/controllers/procedure_controller.dart';
import 'package:dentsys_client/models/procedure_model.dart';

class AddTreatmentDialog extends StatefulWidget {
  const AddTreatmentDialog({super.key});

  @override
  _AddTreatmentDialogState createState() => _AddTreatmentDialogState();
}

class _AddTreatmentDialogState extends State<AddTreatmentDialog> {
  // List of procedures that have been selected by the user.
  List<String> proceduresDone = [];

  // List of all available procedures fetched from the backend
  List<Procedure> servicesOffered1 = [];

  // A map to group procedures by their categories
  Map<String, List<Procedure>> categorizedProcedures = {};


  // final Map<String, List<String>> servicesOffered = {
  //   "Consultations": ["General Consultation", "Specialized Consultation"],
  //   "Oral Surgery": ["Tooth Extraction", "Impacted Tooth Surgery"],
  //   "Dentures": ["Standard Complete", "Flexible Complete", "Flexible Partial"],
  // };
  
 

  @override
  void initState() {
    super.initState();
    loadProcedures();
  }

  Future<void> loadProcedures() async {
    final List<Procedure> procedures = await ProcedureController().getAllProcedures();
    setState(() {
      servicesOffered1 = procedures;
      categorizedProcedures = groupProceduresByCategory(procedures); // Group procedures by category.
    });

    print(servicesOffered1);
  }

  // Groups procedures by their `category` field. 
  //Returns a map where the key is the category name, and the value is a list of procedures in that category.
  Map<String, List<Procedure>> groupProceduresByCategory(List<Procedure> procedures) {
    Map<String, List<Procedure>> grouped = {};
    for (var procedure in procedures) {
      grouped.putIfAbsent(procedure.category, () => []).add(procedure);
    }
    return grouped;
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
                      // Dynamically generate dropdowns for each category.
                      children: categorizedProcedures.keys.map((category) {
                        return DropdownButtonFormField<Procedure>(
                          decoration: InputDecoration(
                            labelText: category,
                            border: const UnderlineInputBorder(),
                          ),
                          items: categorizedProcedures[category]!
                              .map((procedure) => DropdownMenuItem<Procedure>(
                                    value: procedure,
                                    child: Text(procedure.name),
                                  ))
                              .toList(),
                          onChanged: (Procedure? selectedProcedure) {
                            // Add the selected procedure to the list if it's not already selected.
                            if (selectedProcedure != null &&
                                !proceduresDone.contains(selectedProcedure.name)) {
                              setState(() {
                                proceduresDone.add(selectedProcedure.name);
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




