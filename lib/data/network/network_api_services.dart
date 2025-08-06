import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;

import '../app_exceptions.dart';
import 'base_api_services.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(Duration(seconds: 120));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    try {
      Response response = await post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      ).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    print('Raw api status code : ${response.statusCode}');
    print('Raw api response body : ${response.body}');
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201: // Accept 201 as success
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
          'Error occurred while communicating with server ' +
              'with status code' +
              response.statusCode.toString(),
        );
    }
  }

  @override
  Future deleteApi(String url) async {
    dynamic responseJson;
    try {
      final response = await http.delete(Uri.parse(url));
      responseJson = returnResponse(response);
    } catch (e) {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }


}
