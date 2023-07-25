import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dicoding_story/shared_methods.dart';
import 'package:flutter_dicoding_story/theme.dart';
import 'package:flutter_dicoding_story/widgets/Switch.dart';
import 'package:image_picker/image_picker.dart';

class CreateNewStoryPage extends StatefulWidget {
  const CreateNewStoryPage({super.key});

  @override
  State<CreateNewStoryPage> createState() => _CreateNewStoryPageState();
}

class _CreateNewStoryPageState extends State<CreateNewStoryPage> {
  @override
  Widget build(BuildContext context) {
    final descriptionController = TextEditingController(text: '');
    XFile? selectedImageGallery;
    XFile? selectedImageGalleryy;

    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Add Story',
          style: whiteTextStyle.copyWith(
            fontWeight: semiBold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        children: [
          const SizedBox(
            height: 25,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // showModalBottomSheet(
                    //   shape: const RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.vertical(
                    //       top: Radius.circular(10),
                    //     ),
                    //   ),
                    //   backgroundColor: Colors.white,
                    //   context: context,
                    //   builder: (context) {
                    //     return Wrap(
                    //       children: [
                    //         ListTile(
                    //           onTap: () async {
                    //             print('Klik Galery');
                    //             final image = await selectImage();
                    //             print(image);
                    //             setState(() {
                    //               selectedImageGallery = image;
                    //             });
                    //           },
                    //           leading: const Icon(Icons.image_search_rounded),
                    //           title: Text(
                    //             'Add Image from Galery',
                    //             style: blackTextStyle.copyWith(
                    //                 fontWeight: semiBold),
                    //           ),
                    //         ),
                    //         ListTile(
                    //           onTap: () {},
                    //           leading: const Icon(Icons.photo_camera_outlined),
                    //           title: Text(
                    //             'Add Photo from Camera',
                    //             style: blackTextStyle.copyWith(
                    //                 fontWeight: semiBold),
                    //           ),
                    //         ),
                    //       ],
                    //     );
                    //   },
                    // );
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                      ),
                      barrierColor: Colors.black.withOpacity(0.5),
                      builder: (context) {
                        return Wrap(
                          children: [
                            ListTile(
                              onTap: () async {
                                print('Klik Galery');
                                final image = await selectImage();
                                setState(() {
                                  selectedImageGallery = image;
                                });
                              },
                              leading: const Icon(Icons.image_search_rounded),
                              title: Text(
                                'Add Image from Galery',
                                style: blackTextStyle.copyWith(
                                    fontWeight: semiBold),
                              ),
                            ),
                            ListTile(
                              onTap: () {},
                              leading: const Icon(Icons.photo_camera_outlined),
                              title: Text(
                                'Add Photo from Camera',
                                style: blackTextStyle.copyWith(
                                    fontWeight: semiBold),
                              ),
                            ),
                          ],
                        );
                      },
                    ).then(
                      (value) {
                        setState(() {
                          selectedImageGalleryy = selectedImageGallery;
                        });
                      },
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: lightBackgroundColor,
                      image: selectedImageGallery == null
                          ? null
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(selectedImageGallery!.path),
                              ),
                            ),
                    ),
                    child: selectedImageGallery != null
                        ? null
                        : Center(
                            child: Image.asset(
                              'assets/ic_upload.png',
                              width: 32,
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Upload Image',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Share my location',
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: semiBold,
                ),
              ),
              const SwitchExample(),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: descriptionController,
            style: blackTextStyle,
            maxLines: 5, //or null
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              hintStyle: greyTextStyle,
              hintText: "Enter your description here . . .",
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            child: Text(
              'Upload Story',
              style:
                  blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
