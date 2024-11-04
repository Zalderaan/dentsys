import 'package:dentsys_client/screens/patient_records/patient_records.dart';
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
      title: 'Responsive Layout',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const DashboardScreen(),
    );
  }
}

