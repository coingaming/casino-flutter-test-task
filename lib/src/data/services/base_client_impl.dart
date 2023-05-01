import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:casino_test/src/constants.dart';
import 'package:casino_test/src/data/services/app_exceptions.dart';
import 'package:casino_test/src/data/services/base_client.dart';
import 'package:casino_test/src/utils/network_info.dart';
import 'package:http/http.dart' as http;

class DataClientImp implements DataClient {
  final http.Client _client;
  final NetworkInfo _networkInfo;

  const DataClientImp(
      {required NetworkInfo networkInfo, required http.Client client})
      : this._client = client,
        this._networkInfo = networkInfo;

  Future<dynamic> get(String api) async {
    var uri = Uri.parse(BASE_URL + api);

    try {
      if (!await _networkInfo.isConnected) {
        throw NoInternetException('No Internet connection');
      }
      var response =
          await _client.get(uri).timeout(Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw NoInternetException('No Internet connection');
    } on TimeoutException {
      throw ApiNotRespondingException('API took too long to respond');
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(jsonEncode(response.body));
      case 401:
      case 403:
        throw UnAuthorizedException(jsonEncode(response.body));
      case 500:
      default:
        throw FetchDataException(
            'Error occurred with code : ${response.statusCode}');
    }
  }
}
