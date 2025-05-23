import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://reqres.in/api';
  final String _apiKey = 'reqres-free-v1';

  ApiService() {
    _dio.options.headers['x-api-key'] = _apiKey;
  }

  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(
        '$_baseUrl$endpoint',
        queryParameters: queryParameters,
      );
      return response.data;
    } catch (e) {
      throw Exception('Error with GET request to $endpoint: $e');
    }
  }

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(
        '$_baseUrl$endpoint',
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data;
      }
      throw Exception('Error with POST request to $endpoint: $e');
    }
  }

  // New reusable PUT method
  Future<dynamic> put(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(
        '$_baseUrl$endpoint',
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data;
      }
      throw Exception('Error with PUT request to $endpoint: $e');
    }
  }
}