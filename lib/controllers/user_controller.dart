import '../models/user.dart';
import '../models/update_user_response.dart';
import '../services/api_service.dart';

class UserController {
  final ApiService _apiService;

  UserController({ApiService? apiService}) : _apiService = apiService ?? ApiService();

  Future<List<User>> getUsers({int page = 1}) async {
    final data = await _apiService.get('/users', queryParameters: {'page': page});
    List<dynamic> userData = data['data'] ?? [];
    return userData.map((json) => User.fromJson(json)).toList();
  }

  Future<User> getUserDetails(int id) async {
    final data = await _apiService.get('/users/$id');
    final userData = data['data'];
    if (userData == null) {
      throw Exception('User data not found');
    }
    return User.fromJson(userData);
  }

  Future<UpdateUserResponse> updateUser(int id, String name, String job) async {
    if (name.trim().isEmpty) {
      throw Exception('Name cannot be empty');
    }
    final data = await _apiService.put(
      '/users/$id',
      data: {'name': name, 'job': job},
    );
    if (data == null) {
      throw Exception('Failed to update user: No data returned');
    }
    return UpdateUserResponse.fromJson(data);
  }
}