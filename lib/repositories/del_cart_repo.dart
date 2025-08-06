import 'package:planto/data/network/base_api_services.dart';
import 'package:planto/data/network/network_api_services.dart';
import 'package:planto/resources/app_Url.dart';

class DeleteCartRepository{

  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> deleteCartItem (String userId, String plantId) async{
    String url = AppUrl.deleteCartEndPointUrl
        .replaceAll('{userId}', userId)
        .replaceAll('{plantId}', plantId);
    try{
      final response = await _apiServices.deleteApi(url);
      return response;
    }catch(e){
      print(e.toString());
    }
  }

}