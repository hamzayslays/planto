import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../resources/app_Url.dart';

class FavRepo {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> addToFav(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        AppUrl.addToFav,
        data,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }



}
