import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkConnection {
  Future<bool> get isDeviceConnected;

  // ignore: lines_longer_than_80_chars
  ///We can implement streams later if we need to continually listen to connectivity status.
}

class NetworkConnectionImpl implements NetworkConnection {
  final Connectivity _connectivity;
  NetworkConnectionImpl(this._connectivity);

  @override
  Future<bool> get isDeviceConnected async {
    final ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();

    switch (connectivityResult) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
        return true;

      case ConnectivityResult.none:
        return false;

      default:
        return false;
    }
  }
}
