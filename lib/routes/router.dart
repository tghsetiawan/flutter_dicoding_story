import 'package:flutter/material.dart';
import 'package:flutter_dicoding_story/pages/error_page.dart';
import 'package:flutter_dicoding_story/pages/sign_in_page.dart';
import 'package:flutter_dicoding_story/pages/product_detail_page.dart';
import 'package:flutter_dicoding_story/pages/products_page.dart';
import 'package:flutter_dicoding_story/pages/settings_page.dart';
import 'package:flutter_dicoding_story/pages/sign_up_page.dart';
import 'package:flutter_dicoding_story/services/auth_service.dart';
import 'package:go_router/go_router.dart';
import '../pages/home_page.dart';

part 'route_name.dart';

bool isLogin = false;
String? email;

Future<void> validateAuth() async {
  email = await AuthService().getCredentialFromLocal().toString();
}

bool getValidateAuth() {
  validateAuth();
  print('email : $email');
  if (email == null || email == '') {
    isLogin = false;
  }
  return isLogin;
}

/// The route configuration.
final GoRouter router = GoRouter(
  initialLocation: getValidateAuth() ? '/' : '/signup',
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
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/settings',
      name: Routes.settings,
      builder: (BuildContext context, GoRouterState state) {
        return const SettingsPage();
      },
    ),
    GoRoute(
      path: '/signup',
      name: Routes.singUp,
      builder: (BuildContext context, GoRouterState state) {
        return SignUpPage();
      },
    ),
    GoRoute(
      path: '/signin',
      name: Routes.singIn,
      builder: (BuildContext context, GoRouterState state) {
        return SignInPage();
      },
    ),
  ],
);
