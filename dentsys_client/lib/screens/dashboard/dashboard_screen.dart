import 'dart:io';
import 'package:dentsys_client/models/patient_model.dart';
import 'package:dentsys_client/services/patient_service.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PatientService _patientService = PatientService();
  late Future<List<Patient>> patientRecords;
  List<Patient> filteredRecords = [];
  int totalPatients = 0;
  Map<String, int> genderDemographics = {'Male': 0, 'Female': 0};

  @override
  void initState() {
    super.initState();
    loadPatientRecords();
  }

  void loadPatientRecords() async {
    patientRecords = _patientService.getAllPatientsService();
    patientRecords.then((records) {
      setState(() {
        filteredRecords = records;
        totalPatients = records.length;

        // Calculate gender demographics
        genderDemographics = {'Male': 0, 'Female': 0};
        for (var patient in records) {
          if (patient.sex == 1) {
            genderDemographics['Male'] = genderDemographics['Male']! + 1;
          } else {
            genderDemographics['Female'] = genderDemographics['Female']! + 1;
          }
        }
      });
    }).catchError((error) {
      print('Error fetching patient records: $error');
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
                  child: const Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 66, 43, 21),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // NUMBER OF PATIENTS
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
                      const Text(
                        "Number of Patients",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 66, 43, 21),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "$totalPatients",
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // PIE CHART
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
                      const Text(
                        "Patient Demographics by Gender",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 66, 43, 21),
                        ),
                      ),
                      const SizedBox(height: 10),
                      AspectRatio(
                        aspectRatio: 1.5,
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                color: Colors.blue,
                                value: genderDemographics['Male']!.toDouble(),
                                title: 'Male',
                                radius: 50,
                                titleStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              PieChartSectionData(
                                color: Colors.pink,
                                value: genderDemographics['Female']!.toDouble(),
                                title: 'Female',
                                radius: 50,
                                titleStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
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
}
