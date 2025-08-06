import 'package:flutter/cupertino.dart';
import 'package:planto/data/reponse/api_response.dart';
import 'package:planto/model/plant_model_description.dart';
import 'package:planto/repositories/plants_repo.dart';

class OrderViewModel with ChangeNotifier {

  PlantsRepo plantsRepo = PlantsRepo();

  ApiResponse<PlantModelDescription> getPlantById = ApiResponse.loading();


  void setPlantById(ApiResponse<PlantModelDescription> response){
    getPlantById=response;
    notifyListeners();
  }

  int _quantity = 1;

  int get quantity => _quantity;

  void increment() {
    _quantity++;
    notifyListeners();
  }

  void decrement() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }




  Future<void> getPlantbyId(dynamic id) async {
    print("Fetching Plants by id...");

    setPlantById(ApiResponse.loading()); // Set loading state

    try {
      // Fetch data from the repository (with delay handled inside the repository)

      final response = await plantsRepo.getPlantsById(id);

      print("API Response: $response");

      // Check success field

      if (response != null) {
        // Parse and set data if successful

        final PlantModelDescription plantModelDescription = PlantModelDescription.fromJson(response);

        setPlantById(ApiResponse.completed(plantModelDescription));
      } else {
        // Handle failure

        final String message = response['message'] ?? "An error occurred";

        print("Error message from API: $message");

        setPlantById(ApiResponse.error(message)); // Update to ERROR state
      }
    } catch (error) {
      // Handle exceptions and update the state to ERROR

      print("Exception occurred: $error");

      setPlantById(ApiResponse.error(error.toString()));
    }
  }
}
