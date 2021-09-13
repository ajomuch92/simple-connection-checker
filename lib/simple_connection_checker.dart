library simple_connection_checker;

import 'dart:async';
import 'package:universal_io/io.dart';

class SimpleConnectionChecker {
  /// Static method to check if it's connected to internet
  /// lookUpAddress: String to use as lookup address to check internet connection
  static Future<bool> isConnectedToInternet({String? lookUpAddress}) async {
    if (lookUpAddress == null) {
      lookUpAddress = 'www.google.com';
    }
    try {
      final result = await InternetAddress.lookup(lookUpAddress);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) return true;
      return false;
    } on SocketException catch (_) {
      return false;
    } catch (e) {
      var connectOk = await _lookupDoH(lookUpAddress);
      return connectOk;
    }
  }

  /// Timer to check periodically the internet status
  Timer? _timerHandler;

  /// Last status for connection
  bool? _lastStatus;

  /// String to use as look up address
  String? _lookUpAddress;

  /// Value to indicate to timer the duration of every loop
  final Duration _duration = const Duration(milliseconds: 1500);

  /// Stream controller to emit a notifier when connection status changes
  final StreamController<bool> _streamController =
      StreamController<bool>.broadcast();

  /// Get method to return the stream from stream controller
  Stream<bool> get onConnectionChange => _streamController.stream;

  /// Constructor to return the same instance for every new initialization
  factory SimpleConnectionChecker() => _instance;

  /// Private instance for current class
  static final SimpleConnectionChecker _instance = SimpleConnectionChecker._();

  /// Factory to init the class constructor
  SimpleConnectionChecker._() {
    _streamController.onListen = () => {_checkInternetStatus()};

    _streamController.onCancel = () {
      _timerHandler?.cancel();
      _lastStatus = null;
    };
  }

  /// Method to set the lookup address
  void setLookUpAddress(String? lookUpAddress) {
    _lookUpAddress = lookUpAddress;
  }

  /// Method to check the connection status according the duration
  void _checkInternetStatus([Timer? timer]) async {
    _timerHandler?.cancel();
    timer?.cancel();

    bool isConnected = await SimpleConnectionChecker.isConnectedToInternet(
        lookUpAddress:
            _lookUpAddress == null ? 'www.google.com' : _lookUpAddress);

    if (_lastStatus != isConnected && _streamController.hasListener)
      _streamController.add(isConnected);

    if (!_streamController.hasListener) return;

    _timerHandler = Timer(_duration, _checkInternetStatus);

    _lastStatus = isConnected;
  }

  /// Utility to resolve DNS over HTTPs (DoH)
  /// Credit: https://github.com/oonid/ntp/commit/40380ccc390a752788c24671171c35d4c000252a
  static Future<bool> _lookupDoH(String host) async {
    final httpClient = HttpClient();
    final query = 'https://dns.google/resolve?name=$host&type=a&do=1';
    final request = await httpClient.getUrl(Uri.parse(query));
    final response = await request.close();
    if (response.statusCode == 200) {
      // HTTP OK
      return true;
    }
    return false;
  }
}
