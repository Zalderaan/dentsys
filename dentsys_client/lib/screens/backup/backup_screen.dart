import 'dart:io';

import 'package:dentsys_client/services/backupService.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {

  String selectedFormat = "SQL"; // Default selected format

  // Function to show the confirmation dialog
  Future<void> showRestoreConfirmationDialog(BuildContext context, String filePath) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
              'Confirm Restore', 
              style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 66, 43, 21),
            ),
          ),
          content: Text(
              'Are you sure you want to restore the patient records from $filePath?\nThis will overwrite the existing data (unsaved data will be lost).',
              style: const TextStyle(
              fontSize: 16.0,
              color: Color.fromARGB(255, 66, 43, 21),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Proceed with restore
                BackupService().restoreDataService(filePath);
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

  Future<void> saveBackup() async {
    try {
      String sanitizedFileName = 'backup_${DateTime.now().toIso8601String().replaceAll(RegExp(r'[:\-]'), '_').replaceAll('T', '_')}.sql';
      String? selDir = await FilePicker.platform.saveFile(
        initialDirectory: "C:\\Program Files\\DentSys\\backups",
        fileName: sanitizedFileName,
        allowedExtensions: ['sql'],
        type: FileType.custom,
        dialogTitle: "Save Backup",
      );
      if (selDir == null) {
        print("selected directory: $selDir");
        return;
      } else { 
        BackupService().backupDataService(selDir);
      }
    } catch (error) {
      print("Error saving backup: $error");
    }
  }

  Future<void> restoreBackup() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        dialogTitle: "Select Backup File",
        type: FileType.custom,
        allowedExtensions: ['sql'],
      );
      if (result != null) {
        File file = File(result.files.single.path!);
        String filePath = file.path;
        // Show the confirmation dialog before restoring
        showRestoreConfirmationDialog(context, filePath);
      } else {
        print("No file selected");
      }
    } catch (error) {
      print("Error restoring backup: $error");
    }
  }

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
                //TITLE
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Back-Up Patient Records",
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 66, 43, 21),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color.fromARGB(255, 50, 171, 17), Color.fromARGB(255, 22, 21, 66)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ElevatedButton.icon(
                                  onPressed: () async {
                                    restoreBackup();
                                  },
                                  icon: const Icon(
                                    Icons.restore,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    "Restore",
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
                              
                              const SizedBox(width: 10.0),

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
                                  onPressed: () async {
                                    saveBackup();
                                  },
                                  icon: const Icon(
                                    Icons.backup,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    "Backup",
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
                            
                              const SizedBox(width: 10.0),
                              Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color.fromARGB(255, 94, 138, 226), Color.fromARGB(255, 22, 21, 66)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      String? selDir = await FilePicker.platform.getDirectoryPath();
                                      print("selected directory for csv export: $selDir");
                                      BackupService().exportCsvService(selDir);
                                    },
                                    icon: const Icon(
                                      Icons.file_download_rounded,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      "Export as CSV",
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
                        ],
                      ),
                    ],
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
