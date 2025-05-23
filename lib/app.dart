import 'package:flutter/material.dart';
import 'presentation/auth/login_screen.dart';
import 'presentation/home/home_body.dart';
import 'services/auth_prefs.dart';
import 'theme.dart';

class App extends StatelessWidget {
  final AuthPrefs authPrefs;

  App({super.key, AuthPrefs? authPrefs}) : authPrefs = authPrefs ?? AuthPrefs(); // Add default value

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User List App',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: FutureBuilder<bool>(
        future: authPrefs.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          final isLoggedIn = snapshot.data ?? false;
          return isLoggedIn ? const HomeBody() : const LoginScreen();
        },
      ),
    );
  }
}