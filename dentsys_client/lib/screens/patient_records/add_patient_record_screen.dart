import 'package:flutter/material.dart';

class AddPatientRecordScreen extends StatefulWidget {
  const AddPatientRecordScreen({super.key});


  @override
State<AddPatientRecordScreen> createState() => _AddPatientRecordScreenState();
}

class _AddPatientRecordScreenState extends State<AddPatientRecordScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Dashboard content goes here
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: const Offset(0, 3), // Changes the position of the shadow (x, y)
                      ),
                    ],
                  ),
                  
                  padding: const EdgeInsets.all(20.0),
                  child: const Column(
                  children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Add Patient Records",
                            style: TextStyle(
                              fontSize:32.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 66, 43, 21),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                //PERSONAL INFORMATION SECTION
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: const Offset(0, 3), // Changes the position of the shadow (x, y)
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0), // Add some padding
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Personal Information", 
                              style: TextStyle(
                                fontSize: 20, 
                                fontWeight: FontWeight.bold),
                                ),
                          ],
                        ),
                        const SizedBox(height: 10), // Add space between title and fields
                        Divider(
                          height: 10,
                          color: Colors.grey[400],
                          thickness: 1,
                        ),
                        const SizedBox(height: 10),
                        // Lastname, Firstname, Middle Name, Nickname
                        Form(
                          child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: "Lastname",
                                      border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'This item is required';
                                        }
                                        return null;
                                        }
                                      ),
                                    ),
                                const SizedBox(width: 10),
                                Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Firstname", border: OutlineInputBorder()))),
                                const SizedBox(width: 10),
                                Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Middle Name", border: OutlineInputBorder()))),
                                const SizedBox(width: 10),
                                Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Nickname", border: OutlineInputBorder()))),
                              ],
                            ),
                          ],
                        ),
                        ),
                        const SizedBox(height: 15),
        
                        // Birth Date, Age, Sex
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Birth Date (YYYY-MM-DD)", border: OutlineInputBorder()))),
                            const SizedBox(width: 10),
                            Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Age", border: OutlineInputBorder()))),
                            const SizedBox(width: 10),
                            Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Sex", border: OutlineInputBorder()))),
                          ],
                        ),
                        const SizedBox(height: 15),
        
                        // Home Address
                        TextFormField(
                          decoration: const InputDecoration(labelText: "Home Address", border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 15),
        
                        // Religion, Nationality, Occupation
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Religion", border: OutlineInputBorder()))),
                            const SizedBox(width: 10),
                            Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Nationality", border: OutlineInputBorder()))),
                            const SizedBox(width: 10),
                            Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Occupation", border: OutlineInputBorder()))),
                          ],
                        ),
                        const SizedBox(height: 15),
        
                        // Dental Insurance and Effective Date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Dental Insurance", border: OutlineInputBorder()))),
                            const SizedBox(width: 10),
                            Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Effective Date (YYYY-MM-DD)", border: OutlineInputBorder()))),
                          ],
                        ),
                        const SizedBox(height: 20),
        
                        // Submit Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Add your submission logic here
                              },
                              child: const Text("Next"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Divider(
                          height: 10,
                          color: Colors.grey[800],
                          thickness: 1,
                        ),
                //DENTAL HISTORY SECTION
                const SizedBox(height: 15.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: const Offset(0, 3), // Changes the position of the shadow (x, y)
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0), // Add some padding
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Dental History", 
                              style: TextStyle(
                                fontSize: 20, 
                                fontWeight: FontWeight.bold),
                                ),
                          ],
                        ),
                        const SizedBox(height: 10), // Add space between title and fields
                        Divider(
                          height: 10,
                          color: Colors.grey[400],
                          thickness: 1,
                        ),
                        const SizedBox(height: 10),
                        // Lastname, Firstname, Middle Name, Nickname
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Lastname", border: OutlineInputBorder()))),
                                const SizedBox(width: 10),
                                Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Firstname", border: OutlineInputBorder()))),
                                const SizedBox(width: 10),
                                Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Middle Name", border: OutlineInputBorder()))),
                                const SizedBox(width: 10),
                                Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Nickname", border: OutlineInputBorder()))),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
        
                        // Birth Date, Age, Sex
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Birth Date (YYYY-MM-DD)", border: OutlineInputBorder()))),
                            const SizedBox(width: 10),
                            Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Age", border: OutlineInputBorder()))),
                            const SizedBox(width: 10),
                            Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Sex", border: OutlineInputBorder()))),
                          ],
                        ),
                        const SizedBox(height: 15),
        
                        // Home Address
                        TextFormField(
                          decoration: const InputDecoration(labelText: "Home Address", border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 15),
        
                        // Religion, Nationality, Occupation
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Religion", border: OutlineInputBorder()))),
                            const SizedBox(width: 10),
                            Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Nationality", border: OutlineInputBorder()))),
                            const SizedBox(width: 10),
                            Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Occupation", border: OutlineInputBorder()))),
                          ],
                        ),
                        const SizedBox(height: 15),
        
                        // Dental Insurance and Effective Date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Dental Insurance", border: OutlineInputBorder()))),
                            const SizedBox(width: 10),
                            Expanded(child: TextFormField(decoration: const InputDecoration(labelText: "Effective Date (YYYY-MM-DD)", border: OutlineInputBorder()))),
                          ],
                        ),
                        const SizedBox(height: 20),
        
                        // Submit Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Add your submission logic here
                              },
                              child: const Text("Next"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
