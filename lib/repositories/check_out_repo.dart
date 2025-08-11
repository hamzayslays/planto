import 'package:planto/data/network/base_api_services.dart';
import 'package:planto/data/network/network_api_services.dart';
import 'package:planto/model/place_order.dart';
import 'package:planto/resources/app_Url.dart';

class CheckOutRepo{

  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> createOrder (PlaceOrder order) async{
try{
  dynamic response = await _apiServices.getPostApiResponse(
      AppUrl.createOrderEndPointUrl,
      order
  );
  return response;
}catch(e){
  print('error--------> ${e.toString()}');
}
  }

}