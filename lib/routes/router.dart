import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dicoding_story/model/response_getstory_model.dart';
import 'package:flutter_dicoding_story/model/story_model.dart';
import 'package:flutter_dicoding_story/pages/camera_page.dart';
import 'package:flutter_dicoding_story/pages/create_new_story_page.dart';
import 'package:flutter_dicoding_story/pages/error_page.dart';
import 'package:flutter_dicoding_story/pages/home_page.dart';
import 'package:flutter_dicoding_story/pages/maps_page.dart';
import 'package:flutter_dicoding_story/pages/sign_in_page.dart';
import 'package:flutter_dicoding_story/pages/product_detail_page.dart';
import 'package:flutter_dicoding_story/pages/products_page.dart';
import 'package:flutter_dicoding_story/pages/settings_page.dart';
import 'package:flutter_dicoding_story/pages/sign_up_page.dart';
import 'package:flutter_dicoding_story/pages/splash_page.dart';
import 'package:flutter_dicoding_story/pages/stroy_detail_page.dart';
import 'package:go_router/go_router.dart';
part 'route_name.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  errorBuilder: (context, state) => const ErrorPage(),
  routes: <RouteBase>[
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
        GoRoute(
          path: 'maps',
          name: Routes.maps,
          builder: (BuildContext context, GoRouterState state) {
            List<ListStory> listStoryModel = state.extra as List<ListStory>;
            return MapsPage(
              listStory: listStoryModel,
            );
          },
        ),
        GoRoute(
          path: 'story_detail',
          name: Routes.storyDetail,
          builder: (BuildContext context, GoRouterState state) {
            ListStory storyModel = state.extra as ListStory;
            return StoryDetailPage(
              story: storyModel,
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/add_story',
      name: Routes.storyAdd,
      builder: (BuildContext context, GoRouterState state) {
        return const CreateNewStoryPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'camera',
          name: Routes.camera,
          builder: (BuildContext context, GoRouterState state) {
            List<CameraDescription> cameraList =
                state.extra as List<CameraDescription>;
            return CameraPage(
              cameras: cameraList,
            );
          },
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
    GoRoute(
      path: '/splash',
      name: Routes.splash,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
    ),
  ],
  initialLocation: '/splash',
);
