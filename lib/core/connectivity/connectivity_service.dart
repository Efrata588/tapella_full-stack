import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

final isOnlineProvider = StreamProvider<bool>((ref) {
  return ref.watch(connectivityServiceProvider).onlineStream;
});

class ConnectivityService {
  final _connectivity = Connectivity();

  Stream<bool> get onlineStream async* {
    final initial = await _connectivity.checkConnectivity();
    yield _isOnline(initial);
    await for (final result in _connectivity.onConnectivityChanged) {
      yield _isOnline(result);
    }
  }

  Future<bool> get isOnline async {
    final result = await _connectivity.checkConnectivity();
    return _isOnline(result);
  }

  bool _isOnline(List<ConnectivityResult> results) {
    return results.any((r) => r != ConnectivityResult.none);
  }
}
