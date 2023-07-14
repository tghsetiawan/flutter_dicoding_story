import 'package:flutter/material.dart';
import 'package:flutter_dicoding_story/routes/router.dart';
import 'package:go_router/go_router.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Products Page'),
        ),
        body: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                print('${index + 1}');
                var paramId = index + 1;
                context.goNamed(Routes.productsDetail,
                    queryParameters: {'id': paramId.toString()});
              },
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text('Product ${index + 1}'),
            );
          },
        ));
  }
}
