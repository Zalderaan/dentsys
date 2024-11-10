import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

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
                  child: const Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Patient Record",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 66, 43, 21),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),

                // MAIN ROW CONTAINER FOR DETAILS, TREATMENT, APPOINTMENTS
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    // DETAILS CONTAINER
                    Expanded(
                      child: Container(
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
                            const Row(
                              children: [
                                Text(
                                  "Details",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 66, 43, 21),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                                      Divider(
                                        height: 10,
                                        color: Colors.grey[800],
                                        thickness: 0.5,
                                      ),
                                const SizedBox(height: 10),
                            
                            //NAME
                            const Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "NAME",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Vinsmoke Sanji",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            //AGE
                            const Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "AGE",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "21",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            //BIRTHDAY
                            const Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "BIRTHDAY",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "12-20-2003",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            //GENDER
                            const Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "GENDER",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Male",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            //OCCUPATION
                            const Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "OCCUPATION",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Chef",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            //HOME ADDRESS
                            const Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "HOME ADDRESS",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "North Blue",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            //CONTACT NUMBER
                            const Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "CONTACT NUMBER",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "09732178319",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            //EMAIL ADDRESS
                            const Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "EMAIL ADDRESS",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "sanjiv@gmail.com",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            //FAX NUMBER
                            const Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "FAX NUMBER",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Vinsmoke Sanji",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            //BLOOD TYPE
                            const Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "BLOOD TYPE",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "B",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            //ALLERGIES
                            const Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "ALLERGIES",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Latex",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            //DISEASES
                            const Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "DISEASES",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "High Blood Pressure",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 15.0),

                    // COLUMN FOR TREATMENT RECORD AND APPOINTMENTS
                    Expanded(
                      child: Column(
                        children: [
                          // TREATMENT RECORD CONTAINER
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      "Treatment Record",
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Divider(
                                  height: 10,
                                  color: Colors.grey[800],
                                  thickness: 0.5,
                                ),
                                const SizedBox(height: 5),
                                
                                // Table Headers
                                Table(
                                  columnWidths: const {
                                    0: FlexColumnWidth(3),  // Date-Time
                                    1: FlexColumnWidth(4),  // Procedure
                                    2: FlexColumnWidth(2),  // Price
                                  },
                                  border: TableBorder.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                  children: const [
                                    TableRow(
                                      
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Date-Time",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Procedure",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Price",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    
                                    // Example Row (Replace with dynamic data rows as needed)
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("2024-11-10 14:30"),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("Cleaning"),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("₱500"),
                                        ),
                                      ],
                                    ),
                                    // Additional rows can go here
                                  ],
                                ),

                                const SizedBox(height: 10.0),

                                // Totals Row
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Text(
                                      "Total Remaining Balance:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

              
                          const SizedBox(height: 15.0),

                          // APPOINTMENTS CONTAINER
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
                                const Row(
                                  children: [
                                    Text(
                                      "Appointments",
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 66, 43, 21),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                      Divider(
                                        height: 10,
                                        color: Colors.grey[800],
                                        thickness: 0.5,
                                      ),
                                const SizedBox(height: 10),

                                 Table(
                                  columnWidths: const {
                                    0: FlexColumnWidth(3),  // Date-Time
                                    1: FlexColumnWidth(4),  // Procedure
                                    2: FlexColumnWidth(2),  // Price
                                  },
                                  border: TableBorder.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                  children: const [
                                    TableRow(
                                      
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Date-Time",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Procedure",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Price",
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    
                                    // Example Row (Replace with dynamic data rows as needed)
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("2024-11-10 14:30"),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("Cleaning"),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("₱500"),
                                        ),
                                      ],
                                    ),
                                    // Additional rows can go here
                                  ],
                                ),


                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
