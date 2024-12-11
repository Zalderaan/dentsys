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
  late BuildContext dialogContext; // To store the context for the dialog

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    windowManager.setPreventClose(true); // Prevent close by default
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  // Show a confirmation dialog when trying to close the window
  Future<void> showCloseConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: navigatorKey.currentState!.overlay!.context, // Ensure we use a valid context
      barrierDismissible: false, // Prevent dismissing by tapping outside the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirm Close',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 66, 43, 21),
            ),
          ),
          content: const Text('Are you sure you want to close the application?',
            style: TextStyle(
              fontSize: 18.0,
              color: Color.fromARGB(255, 66, 43, 21),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog, do not close the app
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the confirmation dialog
                // Show loading dialog after confirmation
                showLoadingDialog(context);
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Show loading dialog while performing shutdown tasks
  Future<void> showLoadingDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog
      builder: (BuildContext context) {
        dialogContext = context; // Store the context for later
        return const AlertDialog(
          title: Text(
            'Closing Application',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 66, 43, 21),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
                Text(
                  'Please wait while the application is shutting down...',
                  style: TextStyle(
                  fontSize: 18.0,
                  color: Color.fromARGB(255, 66, 43, 21),
                ),
              ),
            ],
          ),
        );
      },
    );

    // Perform shutdown tasks
    await Future.delayed(const Duration(seconds: 2), () async {
      await stopProcesses();
      Navigator.of(dialogContext).pop(); // Close the loading dialog
      await windowManager.destroy(); // Close the window
    });
  }

  @override
  void onWindowClose() async {
    // When the user tries to close the window, show the confirmation dialog
    showCloseConfirmationDialog(context);
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
        '/add-patient': (context) => const AddPatientRecordScreen(),
        '/reports': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as int?; // get the arguments passed to the route
          return ReportsScreen(patient_id: args);
        },
      },
    );
  }
}
