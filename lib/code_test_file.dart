import 'package:dio/dio.dart';
import '../models/user.dart';
import '../models/auth_response.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://reqres.in/api';
  final String _apiKey = 'reqres-free-v1';

  ApiService() {
    _dio.options.headers['x-api-key'] = _apiKey;
  }

  // Reusable GET method
  Future<dynamic> _get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
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

  Future<List<User>> fetchUsers({int page = 1}) async {
    final data = await _get('/users', queryParameters: {'page': page});
    List<dynamic> userData = data['data'];
    return userData.map((json) => User.fromJson(json)).toList();
  }

  Future<User> fetchUserDetails(int id) async {
    final data = await _get('/users/$id');
    return User.fromJson(data['data']);
  }

  Future<AuthResponse> register(String email, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/register',
        data: {'email': email, 'password': password},
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        return AuthResponse.fromJson(e.response!.data);
      }
      throw Exception('Error registering: $e');
    }
  }

  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/login',
        data: {'email': email, 'password': password},
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        return AuthResponse.fromJson(e.response!.data);
      }
      throw Exception('Error logging in: $e');
    }
  }
}