import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiChecker {
  static Future<bool> isApiAvailable(String apiUrl) async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      return response.statusCode == 200;
    } catch (e) {
      debugPrint("Api Checker: $e");
      return false;
    }
  }
}



// class ApiChecker {
//   static void checkApi(Response response) {
//     if (response.statusCode == 401) {
//       // Get.find<AuthController>().clearSharedData();
//       // Get.find<AuthController>().stopLocationRecord();
//       Get.offAllNamed(const AuthLayout() as String);
//     } else {
//       // Show a custom snackbar with the response status text
//       // showCustomSnackBar(response.statusText);
//       debugPrint("Api Checker: ${response.statusText}");
//     }
//   }
// }