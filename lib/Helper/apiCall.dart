import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> apiCall(
    String urlString, Map<String, dynamic> bodyObject) async {
  // Make the HTTP request
  var response = await http.post(Uri.parse(urlString), body: bodyObject);

  // Check the status code
  if (response.statusCode == 200) {
    // The request was successful
    Map<String, dynamic> data = jsonDecode(response.body);
    return response.body;
  } else {
    // The request failed
    throw Exception('API call failed with status code: ${response.statusCode}');
  }
}

Future<dynamic> dataCall(String url) async {
  var response = await http.post(Uri.parse(url));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('API call failed with status code: ${response.statusCode}');
  }
}
