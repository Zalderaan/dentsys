import 'package:flutter/material.dart';
import 'package:dentsys_client/models/procedure_model.dart';
import 'package:dentsys_client/controllers/procedure_controller.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController _procedureNameController = TextEditingController();
  final TextEditingController _procedureBasePriceController = TextEditingController();
  final TextEditingController _procedureMinDPController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final ProcedureController _procedureController = ProcedureController();

  Future<List<Procedure>>? procedures; // = _procedureController.getAllProcedures();
  List<Procedure> allProcedures = []; // For storing all procedures
  List<Procedure> filteredProcedures = []; // For displaying filtered procedures

  // Track the selected service
  String? selectedService;
  String? selectedPaymentType;

  // Function to handle adding a service
  Future<void> handleAddService() async {
    final Procedure newProcedure = Procedure(
      name: _procedureNameController.text,
      category: selectedService!,
      priceType: selectedPaymentType!,
      basePrice: double.parse(_procedureBasePriceController.text),
      minDP: double.tryParse(_procedureMinDPController.text),
    );

    try {
      await _procedureController.createProcedure(newProcedure);
      print('Procedure added successfully');

    // Reload the procedures to refresh the table
    final updatedProcedures = await _procedureController.getAllProcedures();

    setState(() {
      allProcedures = updatedProcedures; // Update the list of all procedures
      filteredProcedures = List.from(allProcedures); // Refresh the filtered list
    });
    } catch (error) {
      print('Error adding procedure: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    // print('procedures: $procedures');
    // Initially load procedures when the screen is displayed
    loadProcedures();
  }

  Future<void> loadProcedures() async {
    try {
      final proceduresList = await _procedureController.getAllProcedures();
      setState(() {
        allProcedures = proceduresList; // Store all procedures
        filteredProcedures = List.from(allProcedures); // Initialize with all procedures
      });
    } catch (error) {
      print('Error loading procedures: $error');
    }
  }

  void searchProcedures(String query) {
    setState(() {
      filteredProcedures = allProcedures.where((procedure) {
        final matchesService = selectedService == null ||
            selectedService == 'All Procedures' ||
            procedure.category == selectedService;
        final matchesQuery = procedure.name.toLowerCase().contains(query.toLowerCase());
        return matchesService && matchesQuery;
      }).toList();
    });
  }

 

 void _showDeleteConfirmationDialog(BuildContext context, Function onDeleteConfirmed) {
   showDialog(
     context: context,
     builder: (BuildContext context) {
       return AlertDialog(
         title: const Text('Confirm Deletion'),
         content: const Text('Are you sure you want to delete this procedure?'),
         actions: [
           TextButton(
             onPressed: () {
               Navigator.of(context).pop();
             },
             child: const Text('Cancel'),
           ),
           TextButton(
             onPressed: () {
               onDeleteConfirmed(); 
               Navigator.of(context).pop(); 
             },
             child: const Text(
               'Delete',
               style: TextStyle(color: Colors.red),
             ),
           ),
         ],
       );
     },
   );
 }

  @override
  void dispose() {
    _procedureNameController.dispose();
    _procedureBasePriceController.dispose();
    _procedureMinDPController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //TITLE
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Services Offered",
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 66, 43, 21),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFE2AD5E), Color(0xFF422B15)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _showAddServiceDialog(context);
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Add Procedure",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15.0),

                // Dropdown Selection for Services and Search Bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedService,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedService = newValue!;
                              searchProcedures(_searchController.text); // Update filtered list
                            });
                          },
                          items: [
                            'All Procedures',
                            'Consultation',
                            'Oral Prophylaxis',
                            'Oral Surgery',
                            'Tooth Restoration',
                            'Crowns & Veneers',
                            'Dentures',
                            'Root Canal Treatment',
                            'Orthodontic Braces',
                            'TMJ Therapy',
                            'Whitening',
                            'Implant',
                          ].map<DropdownMenuItem<String>>((String service) {
                            return DropdownMenuItem<String>(
                              value: service,
                              child: Text(service),
                            );
                          }).toList(),
                          underline: Container(),
                          dropdownColor: Colors.white,
                          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF422B15)),
                        ),
                      ),
                    ),
                    
                    const SizedBox(width: 10),

                    // Search Bar
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (query) => searchProcedures(query),
                          decoration: const InputDecoration(
                            hintText: 'Search Procedures...',
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search, color: Color(0xFF422B15)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15.0),

               
                // Table for Procedures (filtered by selected service)
                // Procedure Table
              if (filteredProcedures.isEmpty)
                const Center(child: Text('No matching procedures found.'))
              else Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
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
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(2),  // Procedure
                          1: FlexColumnWidth(1),  // Price
                          2: FlexColumnWidth(1),  // Price Type
                          3: FlexColumnWidth(1),  // Downpayment
                          4: FlexColumnWidth(1), // Action
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "PROCEDURE",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "PRICE",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "PRICE TYPE",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "DOWN PAYMENT",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "ACTION",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ],
                          ),


                          for (var procedure in filteredProcedures)
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    procedure.name,
                                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                                    ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text('₱ ${procedure.basePrice.toStringAsFixed(2)}',
                                  style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(procedure.priceType,
                                  style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text('\₱ ${procedure.minDP?.toStringAsFixed(2) ?? '0.00'}',
                                  style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                                  ),
                                ),
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () {
                                        _showEditServiceDialog(context, procedure);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        _showDeleteConfirmationDialog(context, (){
                                          _deleteService(procedure);

                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Add Service Dialog
  void _showAddServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        //String? selectedPaymentType = 'Cash'; // Variable to track the selected payment type
        // String? selectedPaymentType; // Variable to track the selected payment type

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                'Add Procedures',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
              content: SizedBox(
                width: 500,
                height: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(
                      height: 10,
                      color: Colors.grey[800],
                      thickness: 0.5,
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Enter Procedure Details",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Service Name
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _procedureNameController,
                            decoration: const InputDecoration(
                              labelText: 'Procedure Name',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Procedure Category
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Procedure Category',
                              border: UnderlineInputBorder(),
                            ),
                            items: <String>[
                              'Consultation',
                              'Oral Prophylaxis',
                              'Oral Surgery',
                              'Tooth Restoration',
                              'Crowns & Veneers',
                              'Dentures',
                              'Root Canal Treatment',
                              'Orthodontic Braces',
                              'TMJ Therapy',
                              'Whitening',
                              'Implant',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedService = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Payment Type
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Payment Type',
                              border: UnderlineInputBorder(),
                            ),
                            items: <String>['Fixed', 'Variable', 'Down Payment', 'Unit']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedPaymentType = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Base Price
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _procedureBasePriceController,
                            decoration: const InputDecoration(
                              labelText: 'Base Price',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Minimum Down Payment
                    Row(
                      children: [
                        Expanded(
                          child: AbsorbPointer(
                            absorbing: selectedPaymentType != 'Down Payment',
                            child: TextField(
                              controller: _procedureMinDPController,
                              decoration: InputDecoration(
                                labelText: 'Minimum Downpayment',
                                border: const UnderlineInputBorder(),
                                enabled: selectedPaymentType == 'Down Payment',
                              ),
                            ),
                          ),
                        ),
                      ],
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
                  child: const Text('Add Service'),
                  onPressed: () async {
                    // Add service to the database
                    await handleAddService();
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


  void _deleteService(Procedure procedure) async {
    try {
      await _procedureController.deleteProcedure(procedure.id.toString());
      setState(() {
        procedures = _procedureController.getAllProcedures();
      });
    } catch (error) {
      print('Error deleting procedure: $error');
    }
  }

 //Edit Service Dialog
  void _showEditServiceDialog(BuildContext context, Procedure procedure) {

    final TextEditingController _editProcedureNameController = TextEditingController(text: procedure.name);
    final TextEditingController _editProcedureBasePriceController = TextEditingController(text: procedure.basePrice.toString());
    final TextEditingController _editProcedureMinDPController = TextEditingController(text: procedure.minDP?.toString());
    String? editSelectedService = procedure.category;
    String? editSelectedPaymentType = procedure.priceType;

    Future<void> saveUpdateService() async {
      final Procedure updatedProcedure = Procedure(
        id: procedure.id,
        name: _editProcedureNameController.text,
        category: editSelectedService!,
        priceType: editSelectedPaymentType!,
        basePrice: double.parse(_editProcedureBasePriceController.text),
        minDP: double.tryParse(_editProcedureMinDPController.text),
      );

      try{
        await _procedureController.updateProcedure(updatedProcedure);
        print('Procedure updated successfully');

        // Reload the procedures to refresh the table
        setState(() {
          procedures = _procedureController.getAllProcedures();
        });
      } catch (error) {
        print('Error updating procedure: $error');
      }
    }
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        //String? selectedPaymentType = 'Cash'; // Variable to track the selected payment type
        // String? selectedPaymentType; // Variable to track the selected payment type

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                'Edit Procedures',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
              content: SizedBox(
                width: 500,
                height: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(
                      height: 10,
                      color: Colors.grey[800],
                      thickness: 0.5,
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Edit Procedure Details",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Service Name
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _editProcedureNameController,
                            decoration: const InputDecoration(
                              labelText: 'Procedure Name',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Procedure Category
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: editSelectedService,
                            decoration: const InputDecoration(
                              labelText: 'Procedure Category',
                              border: UnderlineInputBorder(),
                            ),
                            items: <String>[
                              'Consultation',
                              'Oral Prophylaxis',
                              'Oral Surgery',
                              'Tooth Restoration',
                              'Crowns & Veneers',
                              'Dentures',
                              'Root Canal Treatment',
                              'Orthodontic Braces',
                              'TMJ Therapy',
                              'Whitening',
                              'Implant',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                editSelectedService = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Payment Type
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: editSelectedPaymentType,
                            decoration: const InputDecoration(
                              labelText: 'Payment Type',
                              border: UnderlineInputBorder(),
                            ),
                            items: <String>['Fixed', 'Variable', 'Down Payment', 'Unit']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                editSelectedPaymentType = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Base Price
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _editProcedureBasePriceController,
                            decoration: const InputDecoration(
                              labelText: 'Base Price',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Minimum Down Payment
                    Row(
                      children: [
                        Expanded(
                          child: AbsorbPointer(
                            absorbing: selectedPaymentType == 'Down Payment',
                            child: TextField(
                              controller: _editProcedureMinDPController,
                              decoration: InputDecoration(
                                labelText: 'Minimum Downpayment',
                                border: const UnderlineInputBorder(),
                                enabled: selectedPaymentType == 'Down Payment',
                              ),
                            ),
                          ),
                        ),
                      ],
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
                  child: const Text('Edit Procedure'),
                  onPressed: () async {
                    // Edit service to the database
                    await saveUpdateService();
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

}

