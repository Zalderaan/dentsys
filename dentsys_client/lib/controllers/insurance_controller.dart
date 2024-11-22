import 'package:dentsys_client/models/insurance_model.dart';
import 'package:dentsys_client/services/insurance_service.dart';

class InsuranceController {
  final InsuranceService _insuranceService = InsuranceService();

  // POST
  Future<Insurance> createInsurance(Insurance insurance) async {
    try {
      final createdInsurance = await _insuranceService.addInsuranceService(insurance);
      print('created insurance from frontend controller: $createdInsurance');
      return createdInsurance;
    } catch (error) {
      throw Exception('Error adding insurance from frontend controller: $error');
    }
  }
  
  // GET

  // PUT
  Future<void> updateInsurance(Insurance insurance) async {
    try {
      await _insuranceService.updateInsuranceService(insurance);
    } catch (error) {
      throw Exception('Error updating insurance from frontend controller: $error');
    }
  }
}