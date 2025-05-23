import 'package:flutter/material.dart';
import '../../controllers/user_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../models/user.dart';
import '../widgets/user_card.dart';
import '../auth/login_screen.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final UserController _userController = UserController();
  final AuthController _authController = AuthController();
  List<User> _users = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final users = await _userController.getUsers();
      setState(() {
        _users = users;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching users: $e')),
        );
      }
    }
  }

  void _updateUser(User updatedUser) {
    setState(() {
      final index = _users.indexWhere((user) => user.id == updatedUser.id);
      if (index != -1) {
        _users[index] = updatedUser;
      } else {
        _users.add(updatedUser);
      }
    });
  }

  Future<void> _signOut() async {
    await _authController.signOut();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false, // Clear the navigation stack
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign Out',
            onPressed: _signOut,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _users.isEmpty
              ? const Center(child: Text('No users found'))
              : ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    return UserCard(
                      user: _users[index],
                      onUpdate: _updateUser,
                    );
                  },
                ),
    );
  }
}