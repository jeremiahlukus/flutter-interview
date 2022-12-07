import 'package:mocktail/mocktail.dart';
import 'package:otto_flutter_core/connectivity/connectivity.dart';
import 'package:otto_flutter_core/services/api/otto_api_client.dart';

class MockOttoApiClient extends Mock implements OttoApiClient {}

class MockNetworkConnection extends NetworkConnection {
  @override
  Future<bool> get isDeviceConnected async => true;
}
