import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../models/user.dart';
import '../user_details/user_details_screen.dart';
import '../user_details/update_user_screen.dart';

class UserCard extends StatelessWidget {
  final User user;
  final Function(User) onUpdate;

  const UserCard({super.key, required this.user, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Enable sliding from right to left
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (context) async {
              final updatedUser = await Navigator.push<User>(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateUserScreen(
                    user: user,
                    onUpdate: () {}, // No-op since we're returning the updated user
                  ),
                ),
              );
              if (updatedUser != null) {
                onUpdate(updatedUser);
              }
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Update',
          ),
        ],
      ),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: user.avatar.isNotEmpty ? NetworkImage(user.avatar) : null,
            child: user.avatar.isEmpty ? const Icon(Icons.person) : null,
          ),
          title: Text(user.fullName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.email),
              if (user.job != null && user.job!.isNotEmpty)
                Text(
                  'Job: ${user.job}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserDetailsScreen(user: user),
              ),
            );
          },
        ),
      ),
    );
  }
}