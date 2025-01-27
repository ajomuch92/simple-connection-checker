import 'package:http/http.dart' as http;

/// Checks if there is an internet connection on the web using the `http` package.
/// [url]: The URL to which the connection will be attempted (e.g., 'www.google.com').
/// Returns `true` if the connection is successful, otherwise `false`.
Future<bool> checkInternetConnectionWeb(String url) async {
  // Ensure the URL is properly formatted
  if (!url.startsWith(RegExp(r'https?://'))) {
    url = 'https://$url'; // Add 'https://' if not present
  }
  var client = http.Client();
  try {
    var uri = Uri.https(url);
    var response = await client.get(uri).timeout(const Duration(seconds: 5));
    // If you get here, the connection was successful
    return response.statusCode == 200;
  } catch (e) {
    // If an error occurs, there is no connection
    return false;
  } finally {
    client.close();
  }
}
