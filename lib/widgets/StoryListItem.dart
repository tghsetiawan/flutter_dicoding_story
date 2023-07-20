import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dicoding_story/model/story_model.dart';

/// List item representing a single Character with its photo and name.
class StoryListItem extends StatelessWidget {
  const StoryListItem({
    required this.story,
    Key? key,
  }) : super(key: key);

  final StoryModel story;

  @override
  Widget build(BuildContext context) => Material(
        child: ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: CachedNetworkImageProvider(story.photoUrl!),
          ),
          title: Text(story.name.toString()),
        ),
      );
}
