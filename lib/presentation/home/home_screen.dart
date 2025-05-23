import 'package:flutter/material.dart';
import 'home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReqRes Users'),
      ),
      body: const HomeBody(),
    );
  }
}