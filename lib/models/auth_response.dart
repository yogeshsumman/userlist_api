class AuthResponse {
  final String? token;//? is used to indicate the value can also be null its a nullable type
  final int? id;
  final String? error;

  AuthResponse({this.token, this.id, this.error});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('error')) {
      return AuthResponse(error: json['error']);
    } else {
      return AuthResponse(token: json['token'], id: json['id']);
    }
  }
}
