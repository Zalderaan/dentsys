import 'dart:io';
import 'package:dentsys_client/models/patient_model.dart';
import 'package:dentsys_client/services/patient_service.dart';
import 'package:dentsys_client/controllers/procedure_controller.dart';
import 'package:dentsys_client/models/procedure_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PatientService _patientService = PatientService();
  late Future<List<Patient>> patientRecords;
  List<Patient> filteredRecords = [];

  List<Procedure> servicesOffered = []; // List of all available procedures fetched from the backend
  Map<String, List<Procedure>> categorizedProcedures = {}; // A map to group procedures by their categories

  int maleCount = 0;
  int femaleCount = 0;
  List<ChartData> genderChartData = [];
  List<ChartData> ageChartData = [];
  List<MonthlyPatientData> monthlyPatientData = [];
  int selectedYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    loadPatientRecords();
    loadProcedures();
  }

  void loadPatientRecords() async {
    patientRecords = _patientService.getAllPatientsService();
    patientRecords.then((records) {
      setState(() {
        filteredRecords = records;
        calculateGenderCounts();
        calculateAgeGroups();
        calculateMonthlyPatientData();
      });
    }).catchError((error) {
      print('Error fetching patient records: $error');
    });
  }

  Future<void> loadProcedures() async {
    final List<Procedure> procedures = await ProcedureController().getAllProcedures();
    setState(() {
      servicesOffered = procedures;
      categorizedProcedures = groupProceduresByCategory(procedures); // Group procedures by category.
    });

    // print(servicesOffered);
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

  void calculateGenderCounts() {
    setState(() {
      maleCount = filteredRecords.where((patient) => patient.sex == "Male").length;
      femaleCount = filteredRecords.where((patient) => patient.sex == "Female").length;

      genderChartData = [
        ChartData('Male', maleCount, const Color(0xFF422B15)),
        ChartData('Female', femaleCount, const Color(0xFFE2AD5E)),
      ];
    });
  }

  void calculateAgeGroups() {
    // Define age groups (you can adjust the ranges as needed)
    Map<String, int> ageGroups = {
      '0-18': 0,
      '19-35': 0,
      '36-50': 0,
      '51+': 0,
    };

    for (var patient in filteredRecords) {
      if (patient.age <= 18) {
        ageGroups['0-18'] = ageGroups['0-18']! + 1;
      } else if (patient.age >= 19 && patient.age <= 35) {
        ageGroups['19-35'] = ageGroups['19-35']! + 1;
      } else if (patient.age >= 36 && patient.age <= 50) {
        ageGroups['36-50'] = ageGroups['36-50']! + 1;
      } else {
        ageGroups['51+'] = ageGroups['51+']! + 1;
      }
    }

    setState(() {
      ageChartData = ageGroups.entries.map((entry) {
        return ChartData(entry.key, entry.value, const Color(0xFFE2AD5E));
      }).toList();
    });
  }


  void calculateMonthlyPatientData() {
    // Initialize all months with a count of zero
    Map<String, int> monthCounts = {
      'Jan': 0,
      'Feb': 0,
      'Mar': 0,
      'Apr': 0,
      'May': 0,
      'Jun': 0,
      'Jul': 0,
      'Aug': 0,
      'Sep': 0,
      'Oct': 0,
      'Nov': 0,
      'Dec': 0,
    };

    // Filter records based on the selected year
    List<Patient> filteredByYear = filteredRecords.where((patient) {
      try {
        if (patient.createdAt != null) {
          final DateTime createdAt = DateTime.parse(patient.createdAt!);
          return createdAt.year == selectedYear; // Match the selected year
        }
      } catch (e) {
        print('Error parsing createdAt: $e');
      }
      return false;
    }).toList();

    // Update counts based on actual data
    for (var patient in filteredByYear) {
      try {
        final DateTime createdAt = DateTime.parse(patient.createdAt!);
        final String month = DateFormat('MMM').format(createdAt);
        monthCounts[month] = (monthCounts[month] ?? 0) + 1;
      } catch (e) {
        print('Error parsing createdAt: $e');
      }
    }

    // Sort months in chronological order
    final sortedMonths = monthCounts.entries.toList()
      ..sort((a, b) => DateFormat('MMM')
          .parse(a.key)
          .month
          .compareTo(DateFormat('MMM').parse(b.key).month));

    setState(() {
      monthlyPatientData = sortedMonths
          .map((entry) => MonthlyPatientData(entry.key, entry.value))
          .toList();
    });
  }

  void changeYear(int year) {
    setState(() {
      selectedYear = year;
      calculateMonthlyPatientData(); // Recalculate data for the new year
    });
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
                  child: const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dashboard",
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 66, 43, 21),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    // NUMBER OF PATIENTS AND TREATMENTS
                    Expanded(
                      child: Column(
                        children: [
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Statistics",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 66, 43, 21),
                                  ),
                                ),
                                Divider(height: 10, color: Colors.grey[800], thickness: 0.5),
                            
                                Row(
                                  children: [
                                    // Number of Patients Container
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE2AD5E),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Number of Patients",
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(255, 66, 43, 21),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  filteredRecords.length.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                const Icon(
                                                  Icons.person, // Icon for Number of Patients
                                                  size: 24.0,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    // Number of Treatments Container
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE2AD5E),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Services Offered",
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(255, 66, 43, 21),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  servicesOffered.length.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                const Icon(
                                                  Icons.medical_services, // Icon for Services Offered
                                                  size: 24.0,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Conditions of Patients",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 66, 43, 21),
                                  ),
                                ),
                                Divider(height: 10, color: Colors.grey[800], thickness: 0.5),
                                const Row(
                                  children: [
                                   ],
                                ),
                              ],
                            ),
                          ),
                        
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    // PATIENT DEMOGRAPHICS BY AGE
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
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Patient Demographics by Age",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 66, 43, 21),
                                  ),
                                ),
                              ],
                            ),
                            Divider(height: 10, color: Colors.grey[800], thickness: 0.5),
                            SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              title: ChartTitle(text: 'Age Distribution'),
                              series: <ChartSeries>[
                                ColumnSeries<ChartData, String>(
                                  dataSource: ageChartData,
                                  xValueMapper: (ChartData data, _) => data.label,
                                  yValueMapper: (ChartData data, _) => data.value,
                                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                                  color: const Color(0xFF422B15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    // PATIENT DEMOGRAPHICS BY GENDER
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
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const Text(
                              "Patient Demographics by Gender",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 66, 43, 21),
                              ),
                            ),
                            const SizedBox(height: 10),
                            filteredRecords.isEmpty
                                ? const CircularProgressIndicator() // Show loading indicator while fetching data
                                : genderChartData.isEmpty
                                    ? const Text(
                                        "No data available",
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    : SfCircularChart(
                                        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
                                        series: <CircularSeries>[
                                          PieSeries<ChartData, String>(
                                            dataSource: genderChartData,
                                            xValueMapper: (ChartData data, _) => data.label,
                                            yValueMapper: (ChartData data, _) => data.value,
                                            dataLabelSettings: const DataLabelSettings(isVisible: true),
                                            pointColorMapper: (ChartData data, _) => data.color,
                                          ),
                                        ],
                                      ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 10),

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
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Number of Patients Per Year",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 66, 43, 21),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.arrow_back),
                                      onPressed: () {
                                        if (selectedYear > 2000) {
                                          changeYear(selectedYear - 1);
                                        }
                                      },
                                    ),
                                    Text(
                                      '$selectedYear',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.arrow_forward),
                                      onPressed: () {
                                        if (selectedYear < DateTime.now().year) {
                                          changeYear(selectedYear + 1);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(height: 10, color: Colors.grey[800], thickness: 0.5),
                            //Line Chart
                              SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              title: ChartTitle(text: 'Patients Admitted Per Year'),
                              series: <LineSeries<MonthlyPatientData, String>>[
                                LineSeries<MonthlyPatientData, String>(
                                  dataSource: monthlyPatientData,
                                  xValueMapper: (data, _) => data.month,
                                  yValueMapper: (data, _) => data.count,
                                  markerSettings: const MarkerSettings(isVisible: true),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final String label;
  final int value;
  final Color color;

  ChartData(this.label, this.value, this.color);
}

class MonthlyPatientData {
  final String month;
  final int count;

  MonthlyPatientData(this.month, this.count);
}