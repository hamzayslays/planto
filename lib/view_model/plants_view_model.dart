import 'package:flutter/cupertino.dart';
import 'package:planto/data/reponse/api_response.dart';
import 'package:planto/model/plants_model.dart';
import 'package:planto/repositories/plants_repo.dart';

class PlantsViewModel with ChangeNotifier {
  final PlantsRepo plantsRepo = PlantsRepo();

  ApiResponse<PlantsModel> getPlants = ApiResponse.loading();

  void setPlantLoading(ApiResponse<PlantsModel> response) {
    getPlants = response;
    notifyListeners();
  }

  Future<void> getAllPlants() async {
    print("Fetching Plants data...");

    setPlantLoading(ApiResponse.loading()); // Set loading state

    try {
      // Fetch data from the repository (with delay handled inside the repository)

      final response = await plantsRepo.getPlants();

      print("API Response: $response");

      // Check success field

      if (response != null) {
        // Parse and set data if successful

        final PlantsModel plantsModel = PlantsModel.fromJson(response);

        setPlantLoading(ApiResponse.completed(plantsModel));
      } else {
        // Handle failure

        final String message = response['message'] ?? "An error occurred";

        print("Error message from API: $message");

        setPlantLoading(ApiResponse.error(message)); // Update to ERROR state
      }
    } catch (error) {
      // Handle exceptions and update the state to ERROR

      print("Exception occurred: $error");

      setPlantLoading(ApiResponse.error(error.toString()));
    }
  }
}
