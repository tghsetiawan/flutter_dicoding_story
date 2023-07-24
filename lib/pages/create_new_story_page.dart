import 'package:flutter/material.dart';
import 'package:flutter_dicoding_story/theme.dart';

class CreateNewStoryPage extends StatelessWidget {
  const CreateNewStoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Add Story',
          style: whiteTextStyle.copyWith(
            fontWeight: semiBold,
          ),
        ),
      ),
    );
  }
}
