import 'dart:js' as js;

/// Private method to verify when there is internet connection for web, using the fetch method from JS
Future<bool> checkInternetConnectionWeb(String url) async {
  try {
    await js.context.callMethod('fetch', [url]);
    // If you get here, the connection was successful
    return true;
  } catch (e) {
    // If an error occurs, there is no connection
    return false;
  }
}
