import 'package:dentsys_client/screens/patient_records/patient_records.dart';
import 'package:dentsys_client/screens/reports/reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:dentsys_client/screens/login/login_screen.dart';
import 'package:dentsys_client/screens/dashboard/dashboard_screen.dart';
import 'package:dentsys_client/screens/patient_records/add_patient_record_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DentSys',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/patient_records': (context) => PatientRecords(
          onAddPatient: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddPatientRecordScreen()),
            );
          }, onReports: () { 
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ReportsScreen()),
            ); 
          },
        ),
      }
    );
  }
}

