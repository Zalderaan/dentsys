import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'package:dentsys_client/screens/login/register_screen.dart';
import 'package:dentsys_client/screens/patient_records/patient_records.dart';
import 'package:dentsys_client/screens/reports/reports_screen.dart';
import 'package:dentsys_client/screens/login/login_screen.dart';
import 'package:dentsys_client/screens/dashboard/dashboard_screen.dart';
import 'package:dentsys_client/screens/patient_records/add_patient_record_screen.dart';

import 'package:dentsys_client/app_start.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    showDialog(
      context: navigatorKey.currentState!.overlay!.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false, // Prevent back navigation
          child: const AlertDialog(
            title: Text('Closing Application'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Please wait while the application is shutting down...'),
              ],
            ),
          ),
        );
      },
    );

    // Perform shutdown tasks
    await Future.delayed(const Duration(seconds: 2), () async {
      await stopProcesses();
      Navigator.of(navigatorKey.currentState!.overlay!.context).pop(); // Close the dialog
      await windowManager.destroy();
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DentSys',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      navigatorKey: navigatorKey, // Assign the navigatorKey here
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/patient_records': (context) => PatientRecords(
          onAddPatient: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddPatientRecordScreen()),
            );
          },
          onReports: (int? id) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ReportsScreen(patient_id: id)),
            );
          },
        ),
      },
    );
  }
}
