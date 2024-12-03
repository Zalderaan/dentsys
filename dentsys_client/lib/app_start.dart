// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:ui';
import 'package:window_manager/window_manager.dart';

Future<void> startProcesses() async {
  try {
    // // dev and testing paths  
    // var NODEJS_PATH = 'C:/xampp/htdocs/dentsys/dentsys-api/dentsys-api.exe';
    
    // production path
    var NODEJS_PATH = 'C:/Program Files/DentSys/dentsys-api.exe';
    
    // Check and start Apache server
    final apacheStatus = await Process.run('sc', ['query', 'Apache2.4'], runInShell: true);
    // print('Apache status: ${apacheStatus.stdout}');

    // Check if the service is running
    if (apacheStatus.stdout.toString().contains('RUNNING')) {
      print('Apache server is already running');
    } else {
      print('Starting Apache server...');
      final startResult = await Process.run('sc', ['start', 'Apache2.4'], runInShell: true);
      if (startResult.exitCode == 0) {
        print('Apache server started successfully.');
      } else {
        print(startResult.stdout.toString());
        print(startResult.stderr.toString());
        print('Failed to start Apache server: ${startResult.stderr}');
      }
    }

    // start mysql
    final mysqlStatus =  await Process.run('sc', ['query', 'mysql'], runInShell: true);
    // print('MySQL status: ${mysqlStatus.stdout}');
    if (mysqlStatus.stdout.toString().contains('RUNNING')) {
      print('MySQL server already running');
    } else {
      print('Starting MySQL server');
      final mysql_start_status = await Process.run('sc', ['start', 'mysql'], runInShell: true);
      if (mysql_start_status.exitCode == 0) {
        print('MySQL server started successfully.');
      } else {
        print(mysql_start_status.stdout.toString());
        print(mysql_start_status.stderr.toString());
        print('Failed to start MySQL server: ${mysql_start_status.stderr}');
      }
    }

    // start node server
    final nodeStatus = await isProcessRunning('dentsys-api.exe');
    print(nodeStatus);
    if (!nodeStatus) {
      print('Starting Node server');
      await Process.start(NODEJS_PATH, [], mode: ProcessStartMode.detached);
    } else {
      print('Node server already running');
    }

  } catch (error) {
    print('Error starting processes: $error');
    throw Exception('Error starting processes: $error');
  }
}

Future<bool> isProcessRunning(String processName) async {
  try {
    final ProcessResult processResult =  await Process.run('tasklist', ['/FI', 'IMAGENAME eq $processName'], runInShell: true);
    if (processResult.exitCode == 0) {
      return processResult.stdout.toString().contains(processName);
    } else {
      print('Error checking if process is running: ${processResult.stderr}');
      throw Exception('Error checking if process is running: ${processResult.stderr}');
    }
  } catch (error) {
    print('Error checking if process is running: $error');
    throw Exception('Error checking if process is running: $error');
  }
}

Future<void> stopProcesses() async {
  windowManager.setPreventClose(true);
  try {

    print ('Stopping processes...');
    // stop apache
    final apacheStatus = await Process.run('sc', ['query', 'Apache2.4'], runInShell: true);
    print('Apache status: ${apacheStatus.stdout}');
    if (apacheStatus.stdout.toString().contains('RUNNING')) {
      print('Stopping Apache server...');
      final stopResult = await Process.run('sc', ['stop', 'Apache2.4'], runInShell: true);
      if (stopResult.exitCode == 0) {
        print('Apache server stopped successfully.');
      } else {
        print(stopResult.stdout.toString());
        print(stopResult.stderr.toString());
        print('Failed to stop Apache server: ${stopResult.stderr}');
      }
    } else {
      print('Apache server is already stopped');
    }

    // stop mysql
    final mysqlStatus =  await Process.run('sc', ['query', 'mysql'], runInShell: true);
    print('MySQL status: ${mysqlStatus.stdout}');
    if (mysqlStatus.stdout.toString().contains('RUNNING')) {
      print('Stopping MySQL server');
      final mysql_stop_status = await Process.run('sc', ['stop', 'mysql'], runInShell: true);
      if (mysql_stop_status.exitCode == 0) {
        print('MySQL server stopped successfully.');
      } else {
        print(mysql_stop_status.stdout.toString());
        print(mysql_stop_status.stderr.toString());
        print('Failed to stop MySQL server: ${mysql_stop_status.stderr}');
      }
    } else {
      print('MySQL server is already stopped');
    }

    // stop node server
    final nodeStatus = await isProcessRunning('dentsys-api.exe');
    if (nodeStatus) {
      print('Stopping Node server');
      final node_stop_status = await Process.run('taskkill', ['/IM', 'dentsys-api.exe', '/F'], runInShell: true);
      if (node_stop_status.exitCode == 0) {
        print('Node server stopped successfully.');
      } else {
        print(node_stop_status.stdout.toString());
        print(node_stop_status.stderr.toString());
        print('Failed to stop Node server: ${node_stop_status.stderr}');
      }
    } else {
      print('Node server is already stopped');
    }

    windowManager.setPreventClose(false);

  } catch (error) {
    print('Error stopping processes: $error');
    throw Exception('Error stopping processes: $error');
  }
}