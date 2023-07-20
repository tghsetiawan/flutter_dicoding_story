import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_story/bloc/bloc/auth_bloc.dart';
import 'package:flutter_dicoding_story/model/story_model.dart';
import 'package:flutter_dicoding_story/routes/router.dart';
import 'package:flutter_dicoding_story/services/auth_service.dart';
import 'package:flutter_dicoding_story/services/story_service.dart';
import 'package:flutter_dicoding_story/widgets/StoryListItem.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _pageSize = 5;

  final PagingController<int, StoryModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await AuthService().getStory(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Home Page'),
  //     ),
  //     body: BlocConsumer<AuthBloc, AuthState>(
  //       listener: (context, state) {
  //         if (state is AuthFailed) {
  //           Fluttertoast.showToast(msg: state.e);
  //         }

  //         if (state is AuthInitial) {
  //           context.goNamed(Routes.singIn);
  //         }
  //       },
  //       builder: (context, state) {
  //         return Center(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text('Ini Halaman Home Page'),
  //               ElevatedButton(
  //                 onPressed: () {
  //                   context.goNamed(Routes.settings);
  //                 },
  //                 child: Text('Settings Page'),
  //               ),
  //               ElevatedButton(
  //                 onPressed: () {
  //                   context.goNamed(Routes.products);
  //                 },
  //                 child: Text('Products Page'),
  //               ),
  //               ElevatedButton(
  //                 onPressed: () {
  //                   // context.goNamed(Routes.singUp);
  //                   context.read<AuthBloc>().add(AuthLogout());
  //                 },
  //                 child: Text('Log Out'),
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedListView<int, StoryModel>.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<StoryModel>(
            animateTransitions: true,
            itemBuilder: (context, item, index) => StoryListItem(
              story: item,
            ),
          ),
          separatorBuilder: (context, index) => const Divider(),
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
