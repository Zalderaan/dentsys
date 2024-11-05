import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:dentsys_client/screens/add_appointment/appointment_screen.dart';
import 'package:dentsys_client/screens/patient_records/patient_records.dart';
import 'package:dentsys_client/screens/patient_records/add_patient_record_screen.dart';
// Uncomment and import your other screens as needed
// import 'package:dentsys_client/screens/add_appointment/add_appointment_screen.dart';
// import 'package:dentsys_client/screens/scheduling_screen.dart';
// import 'package:dentsys_client/screens/records_screen.dart';
// import 'package:dentsys_client/screens/reports_screen.dart';
// import 'package:dentsys_client/screens/services_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isExpanded = false;
  int selectedIndex = 0;

  // List of screens for each destination
  final List<Widget> _screens = [
    const AppointmentScreen(),
    const PatientRecords(),
    const AddPatientRecordScreen(),
  ];

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
                              DateFormat('EEEE, MMMM d, yyyy, h:mm a').format(DateTime.now()),
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
