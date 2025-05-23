import '../models/auth_response.dart';
import '../services/api_service.dart';
import '../services/auth_prefs.dart';

class AuthController {
  final ApiService _apiService;
  final AuthPrefs _authPrefs;

  AuthController({
    ApiService? apiService,
    AuthPrefs? authPrefs,
  })  : _apiService = apiService ?? ApiService(),
        _authPrefs = authPrefs ?? AuthPrefs();

  Future<AuthResponse> register(String email, String password) async {
    final data = await _apiService.post(
      '/register',
      data: {'email': email, 'password': password},
    );
    return AuthResponse.fromJson(data);
  }

  Future<AuthResponse> login(String email, String password) async {
    final data = await _apiService.post(
      '/login',
      data: {'email': email, 'password': password},
    );
    final response = AuthResponse.fromJson(data);
    if (response.token != null) {
      await _authPrefs.setLoggedIn(true); // Save login state on successful login
    }
    return response;
  }

  Future<void> signOut() async {
    await _authPrefs.clear(); // Clear login state on sign-out
  }
}