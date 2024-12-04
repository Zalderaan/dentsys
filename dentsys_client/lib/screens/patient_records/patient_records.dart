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
  final List<bool> _filterSelections = [true, false, false];

  final PatientService _patientService = PatientService();
  late Future<List<Patient>> patientRecords;
  List<Patient> filteredRecords = [];
  List<Patient> currentRecords = []; // Records for the current page
  String searchQuery = '';
  int selectedFilter = 0;
  int numberOfOldPatients = 0;
  int numberOfNewPatients = 0;
  int totalPatients = 0;
  Patient? latestNewPatient;
  Patient? latestEditedPatient;


  int currentPage = 1; // Current page number
  final int recordsPerPage = 10; // Max number of records per page
  

  @override
  void initState() {
    super.initState();
    loadPatientRecords();
    computeDashboardData();
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
        final now = DateTime.now();
        filteredRecords = records.where((patient) {
          // Filter by "New" and "Old" criteria
          if (selectedFilter != 0 && patient.createdAt != null) {
            final createdAt = DateTime.tryParse(patient.createdAt!);
            if (createdAt != null) {
              final difference = now.difference(createdAt).inDays;
              if (selectedFilter == 1 && difference > 30) return false; // New only
              if (selectedFilter == 2 && difference <= 30) return false; // Old only
            }
          }

          // Filter by search query
          if (searchQuery.isNotEmpty) {
            final query = searchQuery.toLowerCase();
            final fullName = '${patient.firstName} ${patient.lastName}'.toLowerCase();
            if (!fullName.contains(query)) return false; // Exclude if name doesn't match
          }

          return true;
        }).toList();

        currentPage = 1; // Reset pagination
        updateCurrentRecords(); // Apply filtered results to the current view
      });
    }).catchError((error) {
      print('Error filtering records: $error');
    });
  }

  // Update toggle button selection
  void handleFilterSelection(int index) {
    setState(() {
      selectedFilter = index; // Track the selected filter
      for (int i = 0; i < _filterSelections.length; i++) {
        _filterSelections[i] = i == index;
      }
      filterRecords(); // Apply the selected filter
    });
  }

 void computeDashboardData() {
  patientRecords.then((records) {
    setState(() {
      final now = DateTime.now();

      // Count new and old patients
      numberOfOldPatients = records.where((patient) {
        final createdAt = DateTime.tryParse(patient.createdAt ?? "");
        return createdAt != null && now.difference(createdAt).inDays > 30;
      }).length;

      numberOfNewPatients = records.where((patient) {
        final createdAt = DateTime.tryParse(patient.createdAt ?? "");
        return createdAt != null && now.difference(createdAt).inDays <= 30;
      }).length;

      totalPatients = records.length;

      // Find latest new patient (based on createdAt)
      latestNewPatient = records.lastWhere(
        (patient) {
          final createdAt = DateTime.tryParse(patient.createdAt ?? "");
          return createdAt != null && now.difference(createdAt).inDays <= 30;
        },
        orElse: () => Patient(
          id: 0,
          firstName: "No data",
          lastName: "",
          createdAt: null, 
          middleName: '', 
          birthDate: '', 
          age: 0, 
          sex: '',
          nationality: '', 
          religion: '', 
          occupation: '', 
          reason: '',
        ),
      );

      // Find latest edited patient (based on updatedAt, ignoring createdAt)
      latestEditedPatient = records.lastWhere(
        (patient) {
          final updatedAt = DateTime.tryParse(patient.updatedAt ?? "");
          final createdAt = DateTime.tryParse(patient.createdAt ?? "");
          return updatedAt != null && 
                 (createdAt == null || updatedAt.isAfter(createdAt)) &&
                 now.difference(updatedAt).inDays <= 30;
        },
        orElse: () => Patient(
          id: 0,
          firstName: "No data",
          lastName: "",
          createdAt: null, 
          middleName: '', 
          birthDate: '', 
          age: 0, 
          sex: '',
          nationality: '', 
          religion: '', 
          occupation: '', 
          reason: '',
        ),
      );
    });
  }).catchError((error) {
    print('Error computing dashboard data: $error');
  });
}


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
                              [
                                "Old: ", "$numberOfOldPatients",
                                "New: ", "$numberOfNewPatients",
                                "Total: ", "$totalPatients"
                              ],
                              Icons.people,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: buildInfoCard(
                              "LASTEST UPDATED PATIENT",
                              [
                                "Patient Name: ",
                                latestEditedPatient?.firstName ?? "No data",
                                "Age: ",
                                latestEditedPatient?.age.toString() ?? "N/A",
                                "Sex at Birth: ",
                                latestEditedPatient?.sex ?? "N/A"
                              ],
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: buildInfoCard(
                              "LATEST NEW PATIENT",
                              latestNewPatient != null
                                  ? [
                                      "Patient Name: ", "${latestNewPatient!.firstName} ${latestNewPatient!.lastName}",
                                      "Age: ", (latestNewPatient!.age).toString(),
                                      "Sex at Birth: ", (latestNewPatient!.sex).toString(),
                                      //"Procedure Done: ", latestNewPatient!.lastProcedure ?? "N/A",
                                      //"Dentist: ", latestNewPatient!.dentistName ?? "N/A",
                                    ]
                                  : ["No data available", "", "", "", "", ""],
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
                
                // Search and Filter
                buildSearchAndFilterSection(),
                const SizedBox(height: 30.0),

                // Patient Record List
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

                // Pagination
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
            isSelected: _filterSelections,
            onPressed: handleFilterSelection,
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
      return buildRecordItem(patient); // Pass the Patient object directly
    },
  );
}

 Widget buildRecordItem(Patient patient) {
  final DateTime now = DateTime.now();
  
  // Handle nullable createdAt
  final DateTime createdAt = patient.createdAt != null
      ? DateTime.parse(patient.createdAt!)
      : now; // Default to now if null
  
  final bool isOld = now.difference(createdAt).inDays > 30; // Check if older than 30 days

  final String label = isOld ? "Old" : "New";
  final Color labelColor = isOld ? Colors.blue[300]! : Colors.green[300]!;

  return TextButton(
    onPressed: () {
      widget.onReports(patient.id);
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
              child: Row(
                children: [
                  Text(
                    "${patient.firstName} ${patient.lastName}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.brown[900],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
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
                  color: labelColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
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
      mainAxisAlignment: MainAxisAlignment.end,
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


