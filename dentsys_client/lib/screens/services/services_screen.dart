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
  // final TextEditingController _procedureCategoryController = TextEditingController();
  // final TextEditingController _procedurePriceTypeController = TextEditingController();
  final TextEditingController _procedureBasePriceController = TextEditingController();
  final TextEditingController _procedureMinDPController = TextEditingController();
  final ProcedureController _procedureController = ProcedureController();

  // List of procedures
  late Future<List<Procedure>> procedures = _procedureController.getAllProcedures();

  // Track the selected service
  String? selectedService;
  String? selectedPaymentType;
  String? selectedProcedureCategory;

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
    } catch (error) {
      // Handle error
      print('Error adding procedure: $error');
    }
  }

  @override
  void initState(){
    super.initState();
    loadProcedures();
  }

  Future<void> loadProcedures() async {
    try{
      final proceduresList = await _procedureController.getAllProcedures();
      print('Procedures: $proceduresList'); // debug line
      if(proceduresList.isNotEmpty){
        setState(() {
          procedures = Future.value(proceduresList);
        });
      } else {
        throw Exception('No procedures found');
      }
    } catch (error) {
      print('Error loading procedures: $error');
    }
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
                // TITLE
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
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
                                "Add Services",
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
                
                // Scrollable Selection List with Arrows
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      // Left Arrow Button
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          scrollController.animateTo(
                            scrollController.offset - 200,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                  
                      // Scrollable List of Services
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          controller: scrollController,
                          child: Row(
                            children: [
                              for (var service in [
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
                              ])
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedService = service;
                                      });
                                    },
                                    child: Chip(
                                      label: Text(
                                        service,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: selectedService == service
                                          ? const Color.fromARGB(255, 151, 115, 61) // Color for selected chip
                                          : const Color(0xFF422B15), // Default color
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      // Right Arrow Button
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          scrollController.animateTo(
                            scrollController.offset + 200,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              
                const SizedBox(height: 15.0),
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
                      const SizedBox(height: 10),

                      // Table
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
                              color: Colors.grey[200], // Light background for header row
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
                                    "DOWNPAYMENT",
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
                              )
                            ],
                          ),

                          // Example Row (replace with dynamic data rows as needed)
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Check-up & Consultation",
                                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "300",
                                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "FIXED",
                                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "-",
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
                                        // Handle edit action
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        // Handle delete action
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Add more rows here if needed
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                            absorbing: selectedPaymentType == 'Down Payment',
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
}
