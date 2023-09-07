import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dicoding_story/model/response_getstory_model.dart';
import 'package:flutter_dicoding_story/theme.dart';

/// List item representing a single Character with its photo and name.
class StoryListItem extends StatelessWidget {
  final ListStory story;

  const StoryListItem({
    required this.story,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: CachedNetworkImageProvider(story.photoUrl!),
      ),
      title: Text(
        story.name.toString(),
        style: blackTextStyle.copyWith(
          fontWeight: bold,
        ),
      ),
      subtitle: Text(
        story.description.toString(),
        style: greyTextStyle.copyWith(fontWeight: semiBold),
      ),
    );
  }
}
