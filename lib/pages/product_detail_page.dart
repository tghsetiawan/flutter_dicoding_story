import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final String? id;
  const ProductDetailPage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Product Page'),
      ),
      body: Center(
        child: Text('Detail of Product ${id}'),
      ),
    );
  }
}
