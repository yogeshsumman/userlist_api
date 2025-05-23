// import 'package:flutter/material.dart';

class UpdateUserResponse {
  final String name;
  final String job;
  final DateTime updatedAt;

  UpdateUserResponse({
    required this.name,
    required this.job,
    required this.updatedAt,
  });

  factory UpdateUserResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserResponse(
      name: (json['name'] as String?) ?? 'Unknown',
      job: (json['job'] as String?) ?? 'Unknown',
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}