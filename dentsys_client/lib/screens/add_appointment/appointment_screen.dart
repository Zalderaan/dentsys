import 'package:dentsys_client/screens/add_appointment/add_appointment_screen.dart';
import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  // Sample appointment data
  final List<Map<String, String>> appointments = [
    {"name": "Nami Navigator", "time": "8:00 AM - 9:00 AM", "service": "Cleaning"},
    {"name": "Soul King", "time": "8:00 AM - 9:00 AM", "service": "Brace Adjustment"},
    {"name": "Nico Robin", "time": "8:00 AM - 9:00 AM", "service": "Check-Up"},
    {"name": "Tony Chopper", "time": "8:00 AM - 9:00 AM", "service": "Tooth Extraction"},
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Today's Appointments",
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 66, 43, 21),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE2AD5E), Color(0xFF422B15)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const AddApppointmentScreen()),
                            );
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Add Appointment",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Appointment list
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = appointments[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appointment["name"] ?? "",
                                style: const TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                appointment["time"] ?? "",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Color(0xFF666666),
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                appointment["service"] ?? "",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Color(0xFF0066CC),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                ),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 15.0),
                              ElevatedButton(
                                onPressed: () {
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                ),
                                child: const Text(
                                  "Done",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
