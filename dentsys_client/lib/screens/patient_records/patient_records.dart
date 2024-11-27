import 'package:dentsys_client/screens/reports/reports_screen.dart';
import 'package:flutter/material.dart';
import  'package:dentsys_client/services/patient_service.dart';
import 'package:dentsys_client/models/patient_model.dart';

class PatientRecords extends StatefulWidget {
  final VoidCallback onAddPatient; // Add this parameter
  final Function(int?) onReports;

  const PatientRecords({super.key, required this.onAddPatient, required this.onReports});

  @override
  State<PatientRecords> createState() => _PatientRecordsState();
}

class _PatientRecordsState extends State<PatientRecords> {
  bool isExpanded = false;
  final List<bool> _filterSelections = [true, false, false, false];

  final PatientService _patientService = PatientService();
  late Future<List<Patient>> patientRecords;
  List<Patient> filteredRecords = [];
  List<Patient> currentRecords = []; // Records for the current page
  String searchQuery = '';
  int selectedFilter = 0;


  int currentPage = 1; // Current page number
  final int recordsPerPage = 10; // Max number of records per page
  

  @override
  void initState() {
    super.initState();
    loadPatientRecords();
  }

  void loadPatientRecords() async {
    patientRecords = _patientService.getAllPatientsService();
    patientRecords.then((records) {
      setState(() {
        filteredRecords = records; // Initially show all records
        updateCurrentRecords();
      });
    }).catchError((error) {
      print('Error fetching patient records: $error');
    });
  }

  void updateCurrentRecords() {
    final startIndex = (currentPage - 1) * recordsPerPage;
    final endIndex = startIndex + recordsPerPage;

    setState(() {
      currentRecords = filteredRecords.sublist(
        startIndex,
        endIndex > filteredRecords.length ? filteredRecords.length : endIndex,
      );
    });
  }

  void filterRecords() {
    patientRecords.then((records) {
      setState(() {
        filteredRecords = records.where((patient) {
          final fullName = "${patient.firstName} ${patient.lastName}".toLowerCase();
          return fullName.contains(searchQuery);
        }).toList();
      });
    }).catchError((error) {
      // ignore: avoid_print
      print('Error filtering records: $error');
    });
  }

  // void applyFilters() {
  //   patientRecords.then((records) {
  //     setState(() {
  //       filteredRecords = records.where((patient) {
  //         // Apply search filter
  //         final matchesSearch = searchQuery.isEmpty ||
  //             patient.firstName.toLowerCase().contains(searchQuery.toLowerCase()) ||
  //             patient.lastName.toLowerCase().contains(searchQuery.toLowerCase());

  //         // Apply status filter
  //         final matchesFilter = (selectedFilter == 0) ||
  //             (selectedFilter == 1 && patient.status == "Scheduled") ||
  //             (selectedFilter == 2 && patient.status == "New") ||
  //             (selectedFilter == 3 && patient.status == "Old");

  //         return matchesSearch && matchesFilter;
  //       }).toList();
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Dashboard content goes here
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: const Offset(0, 3), // Changes the position of the shadow (x, y)
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
                            "Patient Records",
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
                              borderRadius: BorderRadius.circular(8), // Match button shape
                            ),
                            child: ElevatedButton.icon(
                              onPressed: widget.onAddPatient,
                              icon: const Icon(Icons.add, color: Colors.white),
                              label: const Text(
                                "Add Patient",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent, // Remove shadow to avoid conflicts with gradient
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8), // Match container border radius
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0), // Adds spacing between the title and the row of cards
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: buildInfoCard(
                              "NUMBER OF PATIENTS",
                              ["Returnee: ", "14", "New: ", "10", "Total: ", "24"],
                              Icons.people,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: buildInfoCard(
                              "LAST PATIENT DONE",
                              [
                                "Patient Name: ",
                                "Godfrey Eclarinal",
                                "Procedure Done: ",
                                "Keme",
                                "Dentist: ",
                                "Dr. John Eric Dedicatoria"
                              ],
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: buildInfoCard(
                              "LATEST NEW PATIENT",
                              [
                                "Patient Name: ",
                                "Jane Doe",
                                "Procedure Done: ",
                                "Consultation",
                                "Dentist: ",
                                "Dr. John Eric Dedicatoria"
                              ],
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                buildSearchAndFilterSection(),
                const SizedBox(height: 30.0),
                SizedBox(
                  height: 400, // Set an appropriate height for the list
                  child: FutureBuilder<List<Patient>>(
                    future: patientRecords,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (filteredRecords.isEmpty) {
                        return const Center(child: Text('No patient records found.'));
                      } else {
                        return buildArticleList();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                buildPagination(),
              ],
            ),
          ),
        ),
      ),
    );
  }


 Widget buildInfoCard(String title, List<String> details, IconData icon, {Color color = Colors.white}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return Card(
        color: const Color.fromARGB(255, 66, 43, 21),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: constraints.maxWidth > 400
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Icon(icon, size: 80.0, color: color),
                      ],
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: color),
                          ),
                          const SizedBox(height: 10.0),
                          // Insert details based on the provided details list
                          for (int i = 0; i < details.length; i += 2)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(details[i], style: TextStyle(fontSize: 16, color: color)),
                                Text(details[i + 1], style: TextStyle(fontSize: 16, color: color)),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Icon(icon, size: 80.0, color: color)),
                    const SizedBox(height: 10.0),
                    Text(
                      title,
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: color),
                    ),
                    const SizedBox(height: 10.0),
                    // Insert details based on the provided details list
                    for (int i = 0; i < details.length; i += 2)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          
                          Row(
                            children: [
                              Text(details[i], style: TextStyle(fontSize: 16, color: color)),
                            ],
                          ),
                          Row(
                            children: [
                              Text(details[i + 1], style: TextStyle(fontSize: 16, color: color)),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
        ),
      );
    },
  );
}





  Widget buildSearchAndFilterSection() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Filter section
      Row(
        children: [
          // Switch-like filter options
          ToggleButtons(
            //borderWidth: 20.0,
            isSelected: _filterSelections,
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < _filterSelections.length; i++) {
                  _filterSelections[i] = i == index;
                }
              });
            },
            borderRadius: BorderRadius.circular(10.0),
            selectedColor: Colors.white,
            fillColor: Colors.brown[300],
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("All"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("Scheduled"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("New"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("Old"),
              ),
            ],
          ),
        ],
      ),

      // Search bar
      SizedBox(
        width: 300.0,
        child: TextField(
          onChanged: (value) {
            setState(() {
              searchQuery = value.toLowerCase();
              filterRecords();
            });
          },
          decoration: InputDecoration(
            hintText: "Search Patient Records",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
    ],
  );
}

   Widget buildArticleList() {
    return ListView.builder(
      itemCount: currentRecords.length,
      itemBuilder: (context, index) {
        final patient = currentRecords[index];
        return buildRecordItem("${patient.firstName} ${patient.lastName}", patient.id);
      },
    );
  }

  Widget buildRecordItem(String name, int? id) {
    return  TextButton(
    onPressed: () {
      // print ("Patient ID: $id"); // debug line
      widget.onReports(id);
      // Navigator.of(context).push(
      //   MaterialPageRoute(builder: (context) => ReportsScreen(patient_id: id,)),
      // ); 
    },
    child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Row (
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.brown[900],
                      ),
                      textAlign: TextAlign.left,
                    ),
                    // Text(
                    //   "ID: $id",
                    //   style: TextStyle(
                    //     fontSize: 16.0,
                    //     color: Colors.brown[600],
                    //   ),
                    // ),
                  ],
                ) 
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  "Patient",
                  style: TextStyle(
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    "Scheduled",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPagination() {
    final totalPages = (filteredRecords.length / recordsPerPage).ceil();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: currentPage > 1
              ? () {
                  setState(() {
                    currentPage--;
                    updateCurrentRecords();
                  });
                }
              : null,
          icon: const Icon(Icons.arrow_back),
        ),
        Text('Page $currentPage of $totalPages'),
        IconButton(
          onPressed: currentPage < totalPages
              ? () {
                  setState(() {
                    currentPage++;
                    updateCurrentRecords();
                  });
                }
              : null,
          icon: const Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}


