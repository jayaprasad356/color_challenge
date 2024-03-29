import 'dart:convert';
import 'dart:io';

import 'package:a1_ads/data/respons/error_response.dart';
import 'package:a1_ads/util/index_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;
import 'package:flutter/foundation.dart' as Foundation;
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ApiClient extends GetxService {
  late final String appBaseUrl;
  late final FlutterSecureStorage storageLocal;
  static const String noInternetMessage =
      'Connection to API server failed due to internet connection';
  final int timeoutInSeconds = 100;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.storageLocal}){
    updateHeader();
  }

  Future<void> updateHeader() async {
    String? tokenValue = await storageLocal.read(key: "tokenValue");
    _mainHeaders = {
      // 'User-Agent' : 'PostmanRuntime/7.32.3',
      // 'Accept' : '*/*',
      // 'Accept-Encoding' : 'gzip, deflate, br',
      // 'Connection' : 'keep-alive'
      // 'Content-Type': 'application/json; charset=utf-8',
      // 'Authorization': 'Bearer $tokenValue',
    };
  }

  // dynamic handleResponse(http.Response response, [String? uri])  {
  //   dynamic body ;
  //   Response responses;
  //   if (response.statusCode == 200) {
  //      body = jsonDecode(response.body);
  //     debugPrint('====> body: $body');
  //      responses = Response(body:body ,statusCode:response.statusCode,);
  //      return responses;
  //   } else if (response.statusCode == 401)  {
  //    Get.snackbar("Oops!", "message");
  //   }
  //   return null;
  // }

    Response handleResponse(Http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {
      // Handle JSON decoding error, if any
    }

    if (response.statusCode == 200) {
      // Successful response
      return Response(
        body: body ?? response.body,
        bodyString: response.body.toString(),
        headers: response.headers,
        statusCode: response.statusCode,
        statusText: response.reasonPhrase,
      );
    } else {
      // Error response
      if (body != null && body is! String) {
        if (body.toString().startsWith('{errors: [{code:')) {
          ErrorResponse errorResponse = ErrorResponse.fromJson(body);
          return Response(
            statusCode: response.statusCode,
            body: body,
            statusText: errorResponse.errors[0].message,
          );
        } else if (body.toString().startsWith('{message')) {
          return Response(
            statusCode: response.statusCode,
            body: body,
            statusText: body['message'],
          );
        }
      }
      return Response(
        statusCode: response.statusCode,
        body: body ?? response.body,
        statusText: response.reasonPhrase,
      );
    }
  }


  Future<dynamic> getData(String uri, Map<String, String>? headers) async {
    final url = Uri.parse(appBaseUrl+uri);

    try {
      debugPrint('====> Get API Call: $url\nHeader: $_mainHeaders');
      Http.Response response = await Http.post(url,
          headers: headers ?? _mainHeaders);
      debugPrint("response : $response");
      return handleResponse(response,uri);
    } catch (e) {
      debugPrint('====> getData error: $e');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(
      String uri,  Map<String, dynamic> body, Map<String, String>? headers) async {
    final url = Uri.parse(uri);

    try {
      debugPrint('====> Post API Call: $url\nHeader: $headers, $_mainHeaders, $body');
      Http.Response response = await Http.post(
        url,
        headers: headers ?? _mainHeaders,
        body: body,
      );
      debugPrint("response : $response");
      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('====> postData error: $e');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }


  // Future<Response> postData(
  //     String uri, dynamic body, Map<String, String>? headers) async {
  //   final url = Uri.parse(uri);
  //
  //   try {
  //     debugPrint('====> Post API Call: $url\nHeader: $headers, $_mainHeaders, $body');
  //     Http.Response response = await Http.post(url,
  //         headers: headers ?? _mainHeaders, body: jsonDecode(body));
  //     debugPrint("response : $response");
  //     return handleResponse(response, uri);
  //   } catch (e) {
  //     debugPrint('====> postData error: $e');
  //     return const Response(statusCode: 1, statusText: noInternetMessage);
  //   }
  // }

  Future<dynamic> putData(
      String uri, dynamic body, Map<String, String>? headers) async {
    final url = Uri.parse(appBaseUrl+uri);

    try {
      debugPrint('====> Put API Call: $uri\nHeader: $_mainHeaders');
      Http.Response response = await Http.put(url,
          headers: headers ?? _mainHeaders, body: body);
      debugPrint("response : $response");
      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('====> putData error: $e');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<dynamic> deleteData(String uri, Map<String, String>? headers) async {
    final url = Uri.parse(appBaseUrl+uri);

    try {
      debugPrint('====> Delete API Call: $uri\nHeader: $_mainHeaders');
      Http.Response response = await Http.delete(url,
          headers: headers ?? _mainHeaders);
      debugPrint("response : $response");
      return handleResponse(response, uri);
    } catch (e) {
      debugPrint('====> deleteData error: $e');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<dynamic> postMultipartData(String uri, dynamic body, List<MultipartBody> multipartBody) async {
    try {
      debugPrint('====> Post Multipart API Call: $uri\nbody: $body\nmultipartBody: $multipartBody');
      Http.MultipartRequest request = await Http.MultipartRequest('POST', Uri.parse(uri));

      // Set Content-Type header
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });

      for (MultipartBody multipart in multipartBody) {
        if (multipart.isNetworkImage) {
          var response = await http.get(Uri.parse(multipart.file.path));
          var part = http.MultipartFile.fromBytes(
            multipart.key,
            response.bodyBytes,
            filename: '${multipart.key}.jpg', // Use a generic filename for network images
          );
          request.files.add(part);
        } else {
          // Handle local files as usual
          var part = http.MultipartFile.fromBytes(
            multipart.key,
            multipart.file.readAsBytesSync(),
            filename: '${multipart.key}.jpg',
          );
          request.files.add(part);
        }
      }
      debugPrint('====> Post part API Call: $request');

      for (var entry in body.entries) {
        request.fields[entry.key] = entry.value;
      }
      debugPrint('====> Post part API Call: $request');

      var response = await Http.Response.fromStream(await request.send());
      debugPrint('====> Post part API Call response: $response');

      // Handle the response
      return handleResponse(response, uri);
    } catch (e) {
      return Http.Response('Error: $e', 500);
    }
  }
}

class MultipartBody {
  final String key;
  final File file;
  final bool isNetworkImage; // Add a property to indicate if it's a network image

  MultipartBody({
    required this.key,
    required this.file,
    this.isNetworkImage = false,
  });
}

// class ApiClient extends GetxService {
//   late final String appBaseUrl;
//   late final FlutterSecureStorage flutterSecureStorage;
//   static const String noInternetMessage =
//       'Connection to API server failed due to internet connection';
//   final int timeoutInSeconds = 100;
//
//   late String token;
//   late Map<String, String> _mainHeaders;
//
//   ApiClient({required this.appBaseUrl, required this.flutterSecureStorage}) {
//     updateHeader();
//   }
//
//   Future<void> updateHeader() async {
//     String? tokenValue = await flutterSecureStorage.read(key: "tokenValue");
//     _mainHeaders = {
//       'Content-Type': 'application/json; charset=UTF-8',
//       'Authorization': 'Bearer $tokenValue'
//     };
//   }
//
//   Future<Response> getData(String uri,
//       {Map<String, dynamic>? query, Map<String, String>? headers}) async {
//     try {
//       debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
//       Http.Response response = await retry(
//           () => Http.get(
//                 Uri.parse(appBaseUrl + uri),
//                 headers: headers ?? _mainHeaders,
//               ),
//           retryIf: (e) => e is SocketException || e is TimeoutException);
//       return handleResponse(response, uri);
//     } catch (e) {
//       return const Response(statusCode: 1, statusText: noInternetMessage);
//     }
//   }
//
//   Future<Response> postData(String uri, dynamic body,
//       {Map<String, String>? headers}) async {
//     try {
//       debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
//       debugPrint('====> API Body: $body');
//       Http.Response response = await Http.post(
//         Uri.parse(appBaseUrl + uri),
//         body: jsonEncode(body),
//         headers: headers ?? _mainHeaders,
//       ).timeout(Duration(seconds: timeoutInSeconds));
//       return handleResponse(response, uri);
//     } catch (e) {
//       return const Response(statusCode: 1, statusText: noInternetMessage);
//     }
//   }
//
//   Future<Response> postMultipartData(
//       String uri, Map<String, String> body, List<MultipartBody> multipartBody,
//       {required Map<String, String> headers}) async {
//     try {
//       debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
//       debugPrint('====> API Body: $body with ${multipartBody.length} files');
//       Http.MultipartRequest request =
//           Http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
//       request.headers.addAll(headers ?? _mainHeaders);
//       for (MultipartBody multipart in multipartBody) {
//         if (multipart.file != null) {
//           if (Foundation.kIsWeb) {
//             Uint8List list = await multipart.file.readAsBytes();
//             Http.MultipartFile part = Http.MultipartFile(
//               multipart.key,
//               multipart.file.readAsBytes().asStream(),
//               list.length,
//               filename: basename(multipart.file.path),
//               contentType: MediaType('image', 'jpg'),
//             );
//             request.files.add(part);
//           } else {
//             File file = File(multipart.file.path);
//             request.files.add(Http.MultipartFile(
//               multipart.key,
//               file.readAsBytes().asStream(),
//               file.lengthSync(),
//               filename: file.path.split('/').last,
//             ));
//           }
//         }
//       }
//       request.fields.addAll(body);
//       Http.Response response =
//           await Http.Response.fromStream(await request.send());
//       return handleResponse(response, uri);
//     } catch (e) {
//       return const Response(statusCode: 1, statusText: noInternetMessage);
//     }
//   }
//
//   Future<Response> putData(String uri, dynamic body,
//       {required Map<String, String> headers}) async {
//     try {
//       debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
//       debugPrint('====> API Body: $body');
//       Http.Response response = await Http.put(
//         Uri.parse(appBaseUrl + uri),
//         body: jsonEncode(body),
//         headers: headers ?? _mainHeaders,
//       ).timeout(Duration(seconds: timeoutInSeconds));
//       return handleResponse(response, uri);
//     } catch (e) {
//       return const Response(statusCode: 1, statusText: noInternetMessage);
//     }
//   }
//
//   Future<Response> deleteData(String uri,
//       {required Map<String, String> headers}) async {
//     try {
//       debugPrint('====> API Call: $uri\nHeader: $_mainHeaders');
//       Http.Response response = await Http.delete(
//         Uri.parse(appBaseUrl + uri),
//         headers: headers ?? _mainHeaders,
//       ).timeout(Duration(seconds: timeoutInSeconds));
//       return handleResponse(response, uri);
//     } catch (e) {
//       return const Response(statusCode: 1, statusText: noInternetMessage);
//     }
//   }
//
//   Response handleResponse(Http.Response response, String uri) {
//     dynamic body;
//     try {
//       body = jsonDecode(response.body);
//     } catch (e) {
//       // Handle JSON decoding error, if any
//     }
//
//     if (response.statusCode == 200) {
//       // Successful response
//       return Response(
//         body: body ?? response.body,
//         bodyString: response.body.toString(),
//         headers: response.headers,
//         statusCode: response.statusCode,
//         statusText: response.reasonPhrase,
//       );
//     } else {
//       // Error response
//       if (body != null && body is! String) {
//         if (body.toString().startsWith('{errors: [{code:')) {
//           ErrorResponse errorResponse = ErrorResponse.fromJson(body);
//           return Response(
//             statusCode: response.statusCode,
//             body: body,
//             statusText: errorResponse.errors[0].message,
//           );
//         } else if (body.toString().startsWith('{message')) {
//           return Response(
//             statusCode: response.statusCode,
//             body: body,
//             statusText: body['message'],
//           );
//         }
//       }
//       return Response(
//         statusCode: response.statusCode,
//         body: body ?? response.body,
//         statusText: response.reasonPhrase,
//       );
//     }
//   }
// }
//
// class MultipartBody {
//   String key;
//   XFile file;
//
//   MultipartBody(this.key, this.file);
// }
