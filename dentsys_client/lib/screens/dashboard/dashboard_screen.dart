import 'package:dentsys_client/screens/reports/reports_screen.dart';
import 'package:dentsys_client/screens/services/services_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import 'package:dentsys_client/screens/patient_records/patient_records.dart';
import 'package:dentsys_client/screens/patient_records/add_patient_record_screen.dart';
import 'package:dentsys_client/screens/add_appointment/add_appointment_screen.dart';
import 'package:dentsys_client/screens/add_appointment/appointment_screen.dart';
//import 'package:dentsys_client/screens/reports/reports_screen.dart';
//import 'package:dentsys_client/screens/services/services_screen.dart';
// Uncomment and import your other screens as needed
// import 'package:dentsys_client/screens/scheduling_screen.dart';
// import 'package:dentsys_client/screens/records_screen.dart';
// import 'package:dentsys_client/screens/reports_screen.dart';
// import 'package:dentsys_client/screens/services_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isExpanded = false;
  int selectedIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const AppointmentScreen(),
      const AddAppointmentScreen(),
      PatientRecords(
        onAddPatient: _handleAddPatient, 
        onReports: _handlePatientReports,
      ),
      const AddPatientRecordScreen(),
      const ReportsScreen(),
      const ServicesScreen(),
    ];
  }

  // Helper method to handle the onAddPatient action
  void _handleAddPatient() {
    setState(() {
      selectedIndex = 3; // Set index for AddPatientRecordScreen
    });
  }

void _handlePatientReports(int? id) {
  if (id != null) {
    print('Selected patient ID: $id');
    _screens[4] = ReportsScreen(patient_id: id);
    setState(() {
      selectedIndex = 4; // Set index for ReportsScreen
    });
  } else {
    print('No patient ID provided.');
  }
}

Future<void> _showLogoutDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Logout'),
            onPressed: () {
              Navigator.of(context).pop();
              _performLogout();
              // Perform logout action here
            },
          ),
        ],
      );
    },
  );
}

void _performLogout() {
  Navigator.of(context).pushReplacementNamed('/login');
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 134, 103, 74),
              borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
            ),
            child: NavigationRail(
              extended: isExpanded,
              backgroundColor: Colors.transparent,
              unselectedIconTheme: const IconThemeData(color: Colors.white, opacity: 1),
              unselectedLabelTextStyle: const TextStyle(color: Colors.white),
              selectedIconTheme: const IconThemeData(color: Colors.brown),
              selectedIndex: selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  selectedIndex = index;
                });

                if (index == 3) {
                  _handleAddPatient();
                }

              },
              leading: Column(
                children: [
                  Ink.image(
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitHeight,
                    image: const AssetImage('assets/images/YNS Logo1.png'),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'YNS',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.date_range),
                  label: Text("Appointments"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.schedule),
                  label: Text("Scheduling"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person),
                  label: Text("Records"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.add),
                  label: Text("Add Records"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.report),
                  label: Text("Reports"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.miscellaneous_services),
                  label: Text("Services"),
                ),
              ],
              trailing: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: _showLogoutDialog,
                  tooltip: 'Logout',
                )
              )
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          icon: const Icon(Icons.menu),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 20.0),
                            const SizedBox(width: 8.0),
                            Text(
                              DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now()),
                              style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: _screens[selectedIndex], // Display the selected screen
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
