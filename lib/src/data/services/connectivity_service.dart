abstract interface class ConnectivityService {
  Stream get statusStream;
  void dispose();
}
