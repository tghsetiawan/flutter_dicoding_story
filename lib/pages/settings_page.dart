import 'package:flutter/material.dart';
import 'package:flutter_dicoding_story/routes/router.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Ini Halaman Setting Page'),
            ElevatedButton(
              onPressed: () {
                context.goNamed(Routes.home);
              },
              child: Text('Back To Home Page'),
            ),
          ],
        ),
      ),
    );
  }
}
