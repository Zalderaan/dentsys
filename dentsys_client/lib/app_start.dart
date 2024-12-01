import 'dart:io';
import 'package:process_run/process_run.dart';

Future<void> startProcesses() async {
  try {

    // dev paths
    const XAMPP_PATH = 'C:/xampp/xampp_start.exe';
    const MYSQL_PATH = 'C:/xampp/mysql/bin/mysqld.exe';
    const NODEJS_PATH = 'C:/xampp/htdocs/dentsys/dentsys-api/dentsys-api.exe';


    // production paths
    // const XAMPP_PATH = 'C:/xampp/xampp_start.exe';
    // const MYSQL_PATH = 'C:/xampp/mysql/bin/mysqld.exe';
    // const NODEJS_PATH = 'C:/Program Files/DentSys/dentsys-api.exe';

    // run XAMPP 
    await Process.run(
      'powershell',
      [
        '-Command',
        'Start-Process',
        '-FilePath',
        '"$XAMPP_PATH"',
        '-Verb',
        'runAs'
      ],
      runInShell: true,
    );

    // start MySQL
    await Process.start(MYSQL_PATH, [], mode: ProcessStartMode.detached);

    // start nodejs server
    await Process.start(NODEJS_PATH, [], mode: ProcessStartMode.detached);

  } catch (error) {
    print('Error starting processes: $error');
    exit(1);
  }
}