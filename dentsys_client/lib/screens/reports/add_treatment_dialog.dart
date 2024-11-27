import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:dentsys_client/controllers/procedure_controller.dart';
import 'package:dentsys_client/models/procedure_model.dart';
import 'package:flutter/services.dart';
import 'package:dentsys_client/models/treatments_model.dart';
import 'package:dentsys_client/controllers/treatment_controller.dart';

class AddTreatmentDialog extends StatefulWidget {
  final int patient_id;
  final VoidCallback onTreatmentAdded;
  const AddTreatmentDialog({super.key, required this.patient_id, required this.onTreatmentAdded});
  

  @override
  _AddTreatmentDialogState createState() => _AddTreatmentDialogState();
}

class _AddTreatmentDialogState extends State<AddTreatmentDialog> {
  List<String> proceduresDone = []; // List of procedures that have been selected by the user.
  List<Procedure> servicesOffered = []; // List of all available procedures fetched from the backend
  Map<String, List<Procedure>> categorizedProcedures = {}; // A map to group procedures by their categories

  // to be used for separation of procedures done
  List<String> procedureNames = [];
  double totalPrice = 0.0;

  TextEditingController amountPaidController = TextEditingController();
  TextEditingController toothNoController = TextEditingController();
  TextEditingController dentistNameController = TextEditingController();
  TreatmentController treatmentController = TreatmentController(); // treatment controller
  @override
  void initState() {
    super.initState();
    loadProcedures();
  }

  Future<void> loadProcedures() async {
    final List<Procedure> procedures = await ProcedureController().getAllProcedures();
    setState(() {
      servicesOffered = procedures;
      categorizedProcedures = groupProceduresByCategory(procedures); // Group procedures by category.
    });

    // print(servicesOffered);
  }

  Future<void> handleAddTreatment() async {
    final treatment = PatientTreatment(
      patient_id: widget.patient_id, // Assume the patient ID is 1
      treatment_prcdName: proceduresDone.join(', '), // Join the procedures with a comma and space
      treatment_dentist: dentistNameController.text,
      treatment_charged: calculateTotalPrice(),
      treatment_paid: double.parse(amountPaidController.text), 
      treatment_balance: await calculateBalance(),
      treatment_date: DateTime.now().toString(),
      treatment_toothNo: toothNoController.text,
    );
    try {
      final createdTreatment = await treatmentController.createTreatment(treatment);
      print('Treatment added: $createdTreatment');

      widget.onTreatmentAdded();
    } catch (error) {
      print('Error adding treatment: $error');
    }
  }

  dynamic calculateTotalPrice() {
    try {
      totalPrice = 0.0;
      for (var procedure in proceduresDone) {
        final priceString = procedure.split('(₱')[1].split(')')[0];
        final price = double.tryParse(priceString) ?? 0.0; // Provide a default value of 0.0 if parsing fails
        totalPrice += price;
      }
      print('total price: $totalPrice');
      return totalPrice;
    } catch (error) {
      print('Error calculating total price: $error');
    }
  }

  dynamic takeProcedureNames() {
    for (var procedure in proceduresDone) {
      final name = procedure.split(' (₱')[0];
      procedureNames.add(name);
    }
    print('procedure names: $procedureNames');
    var cleanProcedureNames = procedureNames.join(', '); // Joins with a comma and space    
    print ('clean procedure names: $cleanProcedureNames');
    return cleanProcedureNames;
  }

  Future<double> calculateBalance() async {
    
    try {
      final last_balance = await treatmentController.getPatientLastBalance(widget.patient_id.toString());
      final total_price = calculateTotalPrice();
      final amount_paid = double.parse(amountPaidController.text);
      final balance = (total_price - amount_paid) + last_balance;
      print('balance: $balance');
      return balance;
    } catch (error) {
      print('Error calculating balance: $error');
      throw Exception('Error calculating balance: $error');// Return a default value in case of an error
    }    
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
        width: 900,
        height: 500,
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

                  // display amount charged
                  const SizedBox(height: 15),
                  
                  TextFormField(
                    controller: TextEditingController(text: '₱${calculateTotalPrice().toStringAsFixed(2)}'),
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Amount Charged',
                      border: UnderlineInputBorder(), 
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: amountPaidController,
                    decoration: const InputDecoration(
                      labelText: 'Amount Paid',
                      border: UnderlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),

                  const SizedBox(height: 15),
                  
                  TextFormField(
                    controller: toothNoController,
                    decoration: const InputDecoration(
                      labelText: 'Tooth No.',
                      border: UnderlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),

                  const SizedBox(height: 15),
                  
                  TextFormField(
                    controller: dentistNameController,
                    decoration: const InputDecoration(
                      labelText: 'Dentist Name',
                      border: UnderlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text
                  )
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
                          onChanged: (Procedure? selectedProcedure) async {
                            if (selectedProcedure != null) {
                              final existingProcedure = proceduresDone.firstWhere(
                                (proc) => proc.startsWith(selectedProcedure.name),
                                orElse: () => '',
                              );

                              if (existingProcedure.isEmpty) {
                                // If the procedure is not already in the list, proceed to show the pricing dialog
                                if (selectedProcedure.priceType == 'Unit') {
                                  await showPricingDialog(context, selectedProcedure, (selectedPrice) {
                                    setState(() {
                                      proceduresDone.add('${selectedProcedure.name} (₱${selectedPrice.toStringAsFixed(2)})');
                                      print(proceduresDone);
                                    });
                                  });
                                } else {
                                  await showPricingDialogFixed(context, selectedProcedure, (selectedPrice) {
                                    setState(() {
                                      proceduresDone.add('${selectedProcedure.name} (₱${selectedPrice.toStringAsFixed(2)})');
                                    });
                                  });
                                }
                              } else {
                                // If the procedure is already in the list, show a message
                                
                                AnimatedSnackBar.material(
                                  '${selectedProcedure.name} is already added.',
                                  type: AnimatedSnackBarType.warning,
                                  duration: const Duration(seconds: 3),
                                ).show(context);
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //     content: Text('${selectedProcedure.name} is already added.'),
                                //   ),
                                // );
                              }
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
          onPressed: () async {
            await handleAddTreatment();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

Future<void> showPricingDialog(BuildContext context, Procedure procedure, Function(double) onPriceSelected) async {
  double basePrice = procedure.basePrice; // Assume `Procedure` has a `basePrice` field.
  double? customPrice;
  bool isCustomPriceSelected = false;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text(
              'Pricing',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                // Base Price Field
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Unit/Teeth/Quadrant Amount',
                    border: UnderlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 15),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Base Price',
                    border: UnderlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  controller: TextEditingController(
                    text: basePrice.toStringAsFixed(2),
                  ),
                  readOnly: true, // Base price is always read-only.
                ),
                const SizedBox(height: 15),
                const Center(
                  child: Text(
                    'or',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 15),
                // Custom Price Field with Radio Button
                Row(
                  children: [
                    Radio<bool>(
                      value: true,
                      groupValue: isCustomPriceSelected,
                      onChanged: (value) {
                        setState(() {
                          isCustomPriceSelected = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: AbsorbPointer(
                        absorbing: !isCustomPriceSelected,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Custom Price',
                            border: const OutlineInputBorder(),
                            enabled: isCustomPriceSelected,
                          ),
                          
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            customPrice = double.tryParse(value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: const Text('Confirm'),
                onPressed: () {
                  double selectedPrice = isCustomPriceSelected && customPrice != null
                      ? customPrice!
                      : basePrice;
                  onPriceSelected(selectedPrice);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
  );
}

Future<void> showPricingDialogFixed(BuildContext context, Procedure procedure, Function(double) onPriceSelected) async {
  double basePrice = procedure.basePrice; // Assume `Procedure` has a `basePrice` field.
  double? customPrice;
  bool isCustomPriceSelected = false;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text(
              'Pricing',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                // Base Price Field
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Base Price',
                    border: UnderlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  controller: TextEditingController(
                    text: basePrice.toStringAsFixed(2),
                  ),
                  readOnly: true, // Base price is always read-only.
                ),
                const SizedBox(height: 15),
                const Center(
                  child: Text(
                    'or',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 15),
                // Custom Price Field with Radio Button
                Row(
                  children: [
                    Radio<bool>(
                      value: true,
                      groupValue: isCustomPriceSelected,
                      onChanged: (value) {
                        setState(() {
                          isCustomPriceSelected = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: AbsorbPointer(
                        absorbing: !isCustomPriceSelected,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Custom Price',
                            border: const OutlineInputBorder(),
                            enabled: isCustomPriceSelected,
                          ),
                          
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            customPrice = double.tryParse(value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: const Text('Confirm'),
                onPressed: () {
                  double selectedPrice = isCustomPriceSelected && customPrice != null
                      ? customPrice!
                      : basePrice;
                  onPriceSelected(selectedPrice);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
  );
}


// void showAddTreatmentDialog(BuildContext context, int patientId) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AddTreatmentDialog(patient_id: patientId, onTreatmentAdded: () {  },);
//     },
//   );
// }




