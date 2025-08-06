import 'package:planto/data/network/base_api_services.dart';
import 'package:planto/data/network/network_api_services.dart';

class PlantsRepo {
  BaseApiServices baseApiServices = NetworkApiService();

  Future<dynamic> getPlants() async {
    final url =
        'https://eb-project-backend-kappa.vercel.app/api/v0/plants/getAll';

    try {
      final response = await baseApiServices.getGetApiResponse(url);
      print("Raw Response: $response");
      return response;
    } catch (e) {
      print("Error in API call: $e");
      throw Exception("Error fetching PLants: $e");
    }
  }

  Future<dynamic> getPlantsById(dynamic id) async {
    try {
      final response = await baseApiServices.getGetApiResponse(
        'https://eb-project-backend-kappa.vercel.app/api/v0/plants/getOne/$id',
      );
      print("Raw Response: $response");
      return response;
    } catch (e) {
      print("Error in API call: $e");
      throw Exception("Error fetching PLants: $e");
    }
  }
}
