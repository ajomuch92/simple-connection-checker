library simple_connection_checker;

import 'dart:io';

class SimpleConnectionChecker {

  /// Static method to check if it's connected to internet
  /// lookUpAddress: String to use as lookup address to check internet connection
  static Future<bool> isConnectedToInternet({String? lookUpAddress}) async {
    try {
      if(lookUpAddress == null) {
        lookUpAddress = 'www.google.com';
      }
      final result = await InternetAddress.lookup(lookUpAddress);
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty)
        return true;
      return false;
    } on SocketException catch(_) {
      return false;
    }
  }
}