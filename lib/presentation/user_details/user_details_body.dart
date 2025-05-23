import 'package:flutter/material.dart';
import '../../models/user.dart';

class UserDetailsBody extends StatelessWidget {
  final User user;

  const UserDetailsBody({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // User avatar
                CircleAvatar(
                  radius: 60,
                  backgroundImage: user.avatar.isNotEmpty ? NetworkImage(user.avatar) : null,
                  backgroundColor: Colors.grey[200],
                  child: user.avatar.isEmpty
                      ? const Icon(Icons.person, size: 60, color: Colors.grey)
                      : null,
                ),
                const SizedBox(height: 24),
                // First Name with Icon
                _buildInfoRow(
                  icon: Icons.account_circle_rounded, // Changed icon
                  iconColor: Colors.blue, // Blue color
                  label: 'First Name',
                  value: user.firstName,
                ),
                const SizedBox(height: 16),
                // Last Name with Icon
                _buildInfoRow(
                  icon: Icons.badge_rounded, // Changed icon
                  iconColor: Colors.blue, // Blue color
                  label: 'Last Name',
                  value: user.lastName,
                ),
                const SizedBox(height: 16),
                // Email with Icon
                _buildInfoRow(
                  icon: Icons.alternate_email_rounded, // Changed icon
                  iconColor: Colors.blue, // Blue color
                  label: 'Email',
                  value: user.email,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build a row with icon, label, and value
  Widget _buildInfoRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: iconColor, // Use the passed color
          size: 28,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}