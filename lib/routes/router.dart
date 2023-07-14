import 'package:flutter/material.dart';
import 'package:flutter_dicoding_story/pages/error_page.dart';
import 'package:flutter_dicoding_story/pages/product_detail_page.dart';
import 'package:flutter_dicoding_story/pages/products_page.dart';
import 'package:flutter_dicoding_story/pages/settings_page.dart';
import 'package:go_router/go_router.dart';
import '../pages/home_page.dart';

part 'route_name.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  errorBuilder: (context, state) => const ErrorPage(),
  routes: <RouteBase>[
    // Kalau 1 level -> Push Replacement
    // Kalau Sub level -> Push (Biasa)
    // Prioritas dalam pembuatan GoRoute (urutan dari atas -> bawah)
    GoRoute(
      path: '/',
      name: Routes.home,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
            path: 'products',
            name: Routes.products,
            builder: (BuildContext context, GoRouterState state) {
              return const ProductsPage();
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'detail',
                name: Routes.productsDetail,
                builder: (BuildContext context, GoRouterState state) {
                  return ProductDetailPage(
                    id: state.queryParameters['id'].toString(),
                  );
                },
              )
            ]),
      ],
    ),
    GoRoute(
      path: '/settings',
      name: Routes.settings,
      builder: (BuildContext context, GoRouterState state) {
        return const SettingsPage();
      },
    ),
  ],
);
