import 'package:flutter/material.dart';
import 'package:flutter_dicoding_story/routes/router.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ini Halaman Home Page'),
            ElevatedButton(
              onPressed: () {
                context.goNamed(Routes.settings);
              },
              child: Text('Settings Page'),
            ),
            ElevatedButton(
              onPressed: () {
                context.goNamed(Routes.products);
              },
              child: Text('Products Page'),
            ),
          ],
        ),
      ),
    );
  }
}
