import 'dart:async';

import 'package:casino_test/src/data/services/connectivity_service.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final class ConnectivityServiceImpl implements ConnectivityService {
  ConnectivityServiceImpl(InternetConnectionChecker instance) {
    _listener = instance.onStatusChange.listen((InternetConnectionStatus status) {
      _connectivityController.add(status);
    });
  }
  late final StreamSubscription<InternetConnectionStatus> _listener;

  final StreamController<InternetConnectionStatus> _connectivityController =
      StreamController<InternetConnectionStatus>();

  @override
  Stream<InternetConnectionStatus> get statusStream => _connectivityController.stream;

  @override
  void dispose() {
    _listener.cancel();
  }
}
