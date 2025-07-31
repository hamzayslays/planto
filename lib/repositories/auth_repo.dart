

import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../resources/app_Url.dart';

class AuthRepository {

  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        AppUrl.loginEndPoint,
        data,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }


  Future<dynamic> signUpApi(dynamic data) async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(
        AppUrl.registerEndPointUrl,
        data,
      );
      return response;
    } catch (e) {
      throw e;
    }
  }

}
