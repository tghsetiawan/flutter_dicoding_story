import 'package:flutter/material.dart';
import 'package:flutter_dicoding_story/model/story_model.dart';
import 'package:flutter_dicoding_story/theme.dart';

class StoryDetailPage extends StatelessWidget {
  final StoryModel story;
  const StoryDetailPage({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            story!.id.toString(),
            style: whiteTextStyle.copyWith(
              fontWeight: semiBold,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          children: [
            Container(
              width: 250,
              height: 250,
              margin: const EdgeInsets.only(
                top: 5,
                bottom: 15,
              ),
              decoration: BoxDecoration(
                border: Border.all(width: 2),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(story.photoUrl!),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story.name.toString(),
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  story.description.toString(),
                  textAlign: TextAlign.justify,
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  story.createdAt.toString(),
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
              ],
            ),
          ],
        ));
  }
}
