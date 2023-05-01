import 'dart:async';

abstract class DataClient {
  Future<dynamic> get(String api);
}

