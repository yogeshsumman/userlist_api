import 'package:flutter/material.dart';
import '../../models/user.dart';
import 'user_details_body.dart';

class UserDetailsScreen extends StatelessWidget {
  final User user; // Change to accept User object

  const UserDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: UserDetailsBody(user: user), // Pass user to body
    );
  }
}