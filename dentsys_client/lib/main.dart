import 'dart:io';
import 'package:flutter/material.dart';

import 'package:dentsys_client/screens/login/register_screen.dart';
import 'package:dentsys_client/screens/patient_records/patient_records.dart';
import 'package:dentsys_client/screens/reports/reports_screen.dart';
import 'package:dentsys_client/screens/login/login_screen.dart';
import 'package:dentsys_client/screens/dashboard/dashboard_screen.dart';
import 'package:dentsys_client/screens/patient_records/add_patient_record_screen.dart';

import 'package:dentsys_client/app_start.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  // for prod only
  WidgetsFlutterBinding.ensureInitialized(); // ensures async calls work before runApp is called
  await startProcesses();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WindowListener {

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    windowManager.setPreventClose(true);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    if (_isPreventClose) {
      await stopProcesses();
      await windowManager.destroy();
    }
  }

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
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/patient_records': (context) => PatientRecords(
          onAddPatient: () {
            // print('onAddPatient in main');
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddPatientRecordScreen()),
            );
          }, onReports: (int? id) { 
            // print('onReports in main $id');
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ReportsScreen(patient_id: id,)),
            ); 
          },
        ),
        // '/patient-details': (context) => const ReportsScreen(),
      }
    );
  }
}

