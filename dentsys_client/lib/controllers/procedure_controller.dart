import 'package:dentsys_client/models/procedure_model.dart';
import 'package:dentsys_client/services/procedure_service.dart';

class ProcedureController {
  final ProcedureService _procedureService = ProcedureService();

  // POST
  Future<Procedure> createProcedure(Procedure procedure) async {
    try {
      final createdProcedure = await _procedureService.addProcedureService(procedure);
      return createdProcedure;
    } catch (error) {
      throw Exception('Error creating procedure in frontend controller: $error');
    }
  }

  // GET
  Future<List<Procedure>> getAllProcedures() async {
    try {
      final fetchedProcedures = await _procedureService.getAllProceduresService();
      return fetchedProcedures;
    } catch (error) {
      throw Exception('Error getting all procedures in frontend controller: $error');
    }
  }

  // PUT
  Future<void> updateProcedure(Procedure procedure) async {
    try {
      await _procedureService.updateProcedureService(procedure);
    } catch (error) {
      throw Exception('Error updating procedure in frontend controller: $error');
    }
  }

  // DELETE
  Future<void> deleteProcedure(String procedureId) async {
    try {
      await _procedureService.deleteProcedureService(procedureId);
    } catch (error) {
      throw Exception('Error deleting procedure in frontend controller: $error');
    }
  }
}
