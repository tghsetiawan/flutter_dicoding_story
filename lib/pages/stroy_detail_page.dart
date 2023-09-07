import 'package:flutter/material.dart';
import 'package:flutter_dicoding_story/model/response_getstory_model.dart';
import 'package:flutter_dicoding_story/theme.dart';
import 'package:geocoding/geocoding.dart';

class StoryDetailPage extends StatefulWidget {
  final ListStory story;
  const StoryDetailPage({super.key, required this.story});

  @override
  State<StoryDetailPage> createState() => _StoryDetailPageState();
}

class _StoryDetailPageState extends State<StoryDetailPage> {
  String? _currentAddress;

  @override
  void initState() {
    super.initState();
    setState(() {
      print('========== Call InitState ==========');
      _getAddressFromLatLng();
    });
  }

  Future<void> _getAddressFromLatLng() async {
    await placemarkFromCoordinates(widget.story.lat!, widget.story.lon!)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[1];

      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
      print(
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}');
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            widget.story.id.toString(),
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
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.story.photoUrl!),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Username",
                  style: blackTextStyle.copyWith(
                    fontSize: 15,
                  ),
                ),
                Text(
                  widget.story.name.toString(),
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 20,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Description",
                  style: blackTextStyle.copyWith(
                    fontSize: 15,
                  ),
                ),
                Text(
                  widget.story.description.toString(),
                  textAlign: TextAlign.justify,
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 20,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Location",
                  style: blackTextStyle.copyWith(
                    fontSize: 15,
                  ),
                ),
                Text(
                  _currentAddress.toString(),
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 18,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Created At",
                  style: blackTextStyle.copyWith(
                    fontSize: 15,
                  ),
                ),
                Text(
                  widget.story.createdAt.toString(),
                  style: blackTextStyle.copyWith(
                    fontWeight: semiBold,
                    fontSize: 18,
                    height: 1.1,
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
