import 'package:flutter/material.dart';
import '../../controllers/user_controller.dart';
import '../../models/user.dart';

class UpdateUserScreen extends StatefulWidget {
  final User user;
  final VoidCallback onUpdate;

  const UpdateUserScreen({super.key, required this.user, required this.onUpdate});

  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final _nameController = TextEditingController();
  final _jobController = TextEditingController();
  final UserController _userController = UserController();
  String? _errorMessage;
  String? _successMessage;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.fullName;
    _jobController.text = widget.user.job ?? '';
  }

  Future<void> _updateUser() async {
    if (_isUpdating) return; // Prevent multiple submissions

    setState(() {
      _isUpdating = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      final response = await _userController.updateUser(
        widget.user.id,
        _nameController.text,
        _jobController.text.isEmpty ? 'Unknown' : _jobController.text, // Fallback for empty job
      );
      final updatedUser = widget.user.copyWith(
        name: response.name,
        job: response.job,
      );
      setState(() {
        _successMessage = 'User updated successfully!';
      });
      // Ensure the widget is still mounted before navigating
      if (mounted) {
        widget.onUpdate();
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          Navigator.pop(context, updatedUser); // Return the updated user
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString().replaceFirst('Exception: ', '');
          _isUpdating = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update User')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                'Update User Details',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person_outlined),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _jobController,
                decoration: const InputDecoration(
                  labelText: 'Job',
                  prefixIcon: Icon(Icons.work_outlined),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isUpdating ? null : _updateUser, // Disable button while updating
                child: _isUpdating
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Update'),
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                    textAlign: TextAlign.center,
                  ),
                ),
              if (_successMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    _successMessage!,
                    style: const TextStyle(color: Colors.green),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}