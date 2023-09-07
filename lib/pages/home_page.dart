import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_story/bloc/Auth/auth_bloc.dart';
import 'package:flutter_dicoding_story/model/response_getstory_model.dart';
import 'package:flutter_dicoding_story/model/story_model.dart';
import 'package:flutter_dicoding_story/routes/router.dart';
import 'package:flutter_dicoding_story/services/story_service.dart';
import 'package:flutter_dicoding_story/theme.dart';
import 'package:flutter_dicoding_story/widgets/LoadingOverlay.dart';
import 'package:flutter_dicoding_story/widgets/StoryListItem.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../bloc/story/story_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _pageSize = 20;
  final PagingController<int, ListStory> _pagingController =
      PagingController(firstPageKey: 0);

  final LoadingOverlay _loadingOverlay = LoadingOverlay();

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await StoryService().getAllStory(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Dicoding Story',
              style: whiteTextStyle.copyWith(fontWeight: bold),
            ),
            elevation: 0,
            actions: [
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text("My Account"),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text("Maps"),
                    ),
                    const PopupMenuItem<int>(
                      value: 2,
                      child: Text("Settings"),
                    ),
                    const PopupMenuItem<int>(
                      value: 3,
                      child: Text("Logout"),
                    ),
                  ];
                },
                onSelected: (value) async {
                  if (value == 0) {
                    context.goNamed(Routes.products);
                  } else if (value == 1) {
                    context.read<StoryBloc>().add(GetStoryLocation());
                  } else if (value == 2) {
                    context.goNamed(Routes.settings);
                  } else if (value == 3) {
                    context.read<AuthBloc>().add(AuthLogout());
                  }
                },
              )
            ],
          ),
          body: MultiBlocListener(
            listeners: [
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailed) {
                    Fluttertoast.showToast(msg: state.e);
                  }

                  if (state is AuthInitial) {
                    context.goNamed(Routes.singIn);
                  }
                },
              ),
              BlocListener<StoryBloc, StoryState>(
                listener: (context, state) {
                  if (state is StoryFailed) {
                    Fluttertoast.showToast(msg: state.e);
                  }

                  if (state is StoryLoading) {
                    _loadingOverlay.show(context);
                  } else {
                    _loadingOverlay.hide();
                  }

                  if (state is StorySuccessGet) {
                    context.goNamed(Routes.maps, extra: state.data.listStory);
                    // print(state.data.listStory!);
                  }
                },
              ),
            ],
            child: ScrollConfiguration(
              behavior: const ScrollBehavior(),
              child: PagedListView<int, ListStory>.separated(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<ListStory>(
                  animateTransitions: true,
                  transitionDuration: const Duration(milliseconds: 500),
                  itemBuilder: (context, item, index) => GestureDetector(
                    onTap: () {
                      context.goNamed(Routes.storyDetail, extra: item);
                    },
                    child: StoryListItem(
                      story: item,
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const Divider(
                  height: 5,
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            onPressed: () {
              context.goNamed(Routes.storyAdd);
            },
            backgroundColor: Colors.orange,
            child: const Icon(
              Icons.add_outlined,
              color: Colors.black,
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
