import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:dentsys_client/screens/patient_records/patient_records.dart';
import 'package:dentsys_client/screens/patient_records/add_patient_record_screen.dart';
import 'package:dentsys_client/screens/reports/reports_screen.dart';
import 'package:dentsys_client/screens/services/services_screen.dart';
import 'package:dentsys_client/screens/backup/backup_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isExpanded = false;
  int selectedIndex = 0;
  bool showSubItems = false; // Controls visibility of sub-items
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      PatientRecords(
        onAddPatient: _handleAddPatient,
        onReports: _handlePatientReports,
      ),
      const AddPatientRecordScreen(),
      const ReportsScreen(),
      const ServicesScreen(),
      const BackupScreen(),
    ];
  }

  void _handleAddPatient() {
    setState(() {
      selectedIndex = 1; // Index for Add Patient Screen
    });
  }

  void _handlePatientReports(int? id) {
    if (id != null) {
      print('Selected patient ID: $id');
      setState(() {
        selectedIndex = 2; // Index for Reports Screen
        _screens[2] = ReportsScreen(patient_id: id);
      });
    } else {
      print('No patient ID provided.');
    }
  }

void _handleNavigation(int index) {
  setState(() {
    if (showSubItems) {
      // Adjust indices when sub-items are visible
      if (index == 0) {
        selectedIndex = 0; // Patient Records
      } else if (index == 1) {
        selectedIndex = 1; // Add Patient
      } else if (index == 2) {
        selectedIndex = 2; // Reports
      } else if (index == 3) {
        selectedIndex = 3; // Services
      } else if (index == 4) {
        selectedIndex = 4; // Backup
      }
    } else {
      // Adjust indices when sub-items are hidden
      if (index == 0) {
        selectedIndex = 0; // Patient Records
      } else if (index == 1) {
        selectedIndex = 3; // Services
      } else if (index == 2) {
        selectedIndex = 4; // Backup
      }
    }

    // Toggle `showSubItems` dynamically
    showSubItems = selectedIndex <= 2; // Show sub-items only for indices 0, 1, or 2
  });
}

  void _toggleSubItems() {
    setState(() {
      showSubItems = !showSubItems;
      // Reset index if toggling sub-items affects navigation
      if (!showSubItems && selectedIndex != 0) {
        selectedIndex = 0;
      }
    });
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
            borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
          ),
          child: NavigationRail(
            selectedIndex: showSubItems ? selectedIndex : (selectedIndex > 2 ? selectedIndex - 2 : selectedIndex),
            onDestinationSelected: _handleNavigation,
            labelType: isExpanded
                ? NavigationRailLabelType.none
                : NavigationRailLabelType.all,
            backgroundColor: Colors.transparent,
            groupAlignment: -1.0,
            leading: Column(
              children: [
                Ink.image(
                  width: isExpanded ? 150 : 100,
                  height: isExpanded ? 150 : 100,
                  fit: BoxFit.fitHeight,
                  image: const AssetImage('assets/images/YNS Logo1.png'),
                ),
                const SizedBox(height: 10),
                Text(
                  'YNS',
                  style: TextStyle(
                    fontSize: isExpanded ? 24 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.logout, color: Colors.red),
              onPressed: () => _showLogoutDialog(),
            ),
            destinations: [
              NavigationRailDestination(
                icon: InkWell(
                  onTap: _toggleSubItems,
                  child: const Icon(Icons.person_outline, color: Colors.white),
                ),
                selectedIcon:
                    const Icon(Icons.person, color: Color.fromARGB(255, 130, 99, 4)),
                label: const Text(
                  "Patient Records",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              if (showSubItems) ...[
                const NavigationRailDestination(
                  icon: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Icon(Icons.add_box_outlined, color: Colors.white),
                  ),
                  selectedIcon: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Icon(Icons.add_box, color: Color.fromARGB(255, 130, 99, 4)),
                  ),
                  label: Text(
                    "Add Patient",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const NavigationRailDestination(
                  icon: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Icon(Icons.report_outlined, color: Colors.white),
                  ),
                  selectedIcon: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Icon(Icons.report, color: Color.fromARGB(255, 130, 99, 4)),
                  ),
                  label: Text(
                    "Reports",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
              const NavigationRailDestination(
                icon: Icon(Icons.miscellaneous_services_outlined, color: Colors.white),
                selectedIcon: Icon(Icons.miscellaneous_services,
                    color: Color.fromARGB(255, 130, 99, 4)),
                label: Text("Services", style: TextStyle(color: Colors.white)),
              ),
              const NavigationRailDestination(
                icon: Icon(Icons.backup, color: Colors.white),
                selectedIcon: Icon(Icons.backup, color: Color.fromARGB(255, 130, 99, 4)),
                label:
                    Text("Backup Records", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
        const VerticalDivider(thickness: 1, width: 1),
        Expanded(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        icon: Icon(isExpanded ? Icons.menu_open : Icons.menu),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 20.0),
                          const SizedBox(width: 8.0),
                          Text(
                            DateFormat('EEEE, MMMM d, yyyy')
                                .format(DateTime.now()),
                            style: const TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  layoutBuilder: (currentChild, previousChildren) => Stack(
                    children: <Widget>[
                      ...previousChildren,
                      if (currentChild != null) currentChild,
                    ],
                  ),
                  child: _screens[selectedIndex],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}