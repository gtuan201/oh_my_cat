import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;

  ApiClient({required this.baseUrl});

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    final uri = Uri.parse('$baseUrl/$endpoint').replace(queryParameters: queryParams);
    final response = await http.get(uri,headers: {
      "Accept-Language" : "vi-VN,vi;q=0.9,en-US;q=0.6,en;q=0.5"
    });
    return _handleResponse(response);
  }

  Future<Response> post(String endpoint, {Map<String, dynamic>? body}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<Response> put(String endpoint, {Map<String, dynamic>? body}) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<Response> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  Response _handleResponse(http.Response response) {
    dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Response(
        body: body ?? response.body,
        bodyString: response.body.toString(),
        request: Request(
            headers: response.request!.headers,
            method: response.request!.method,
            url: response.request!.url),
        headers: response.headers,
        statusCode: response.statusCode,
        statusText: response.reasonPhrase,
      );
    } else {
      throw Exception('HTTP error ${response.statusCode}: ${response.body}');
    }
  }
}