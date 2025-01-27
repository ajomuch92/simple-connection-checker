import 'package:http/http.dart' as http;

/// Private method to verify when there is internet connection for web, using the http package
Future<bool> checkInternetConnectionWeb(String url) async {
  var client = http.Client();
  try {
    var uri = Uri.https(url);
    var response = await client.get(uri);
    // If you get here, the connection was successful
    return response.statusCode == 200;
  } catch (e) {
    // If an error occurs, there is no connection
    return false;
  } finally {
    client.close();
  }
}
