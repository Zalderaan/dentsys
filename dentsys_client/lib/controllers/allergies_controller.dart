import '../services/allergies_service.dart';
import '../models/allergies_model.dart';

class AllergiesController {
  final AllergiesService _allergiesService = AllergiesService();

  // POST
  Future<Allergies> createAllergy(Allergies allergies) async {
    try {
      final createdAllergies = await _allergiesService.addAllergyService(allergies);
      print('created allergies from frontend controller: $createdAllergies');
      return createdAllergies;
    } catch (error) {
      throw Exception('Error creating allergies in frontend controller: $error');
    }
  }
}