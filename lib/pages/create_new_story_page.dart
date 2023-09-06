import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dicoding_story/bloc/story/story_bloc.dart';
import 'package:flutter_dicoding_story/pages/camera_page.dart';
import 'package:flutter_dicoding_story/routes/router.dart';
import 'package:flutter_dicoding_story/shared_methods.dart';
import 'package:flutter_dicoding_story/theme.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class CreateNewStoryPage extends StatefulWidget {
  const CreateNewStoryPage({super.key});

  @override
  State<CreateNewStoryPage> createState() => _CreateNewStoryPageState();
}

class _CreateNewStoryPageState extends State<CreateNewStoryPage> {
  final descriptionController = TextEditingController(text: '');
  String? _currentAddress;
  Position? _currentPosition;
  XFile? selectedImageGallery;
  bool light = false;

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool validate() {
    if (descriptionController.text.isEmpty || selectedImageGallery == null) {
      return false;
    }
    return true;
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final resultImage = await availableCameras().then((value) => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    setState(() {
      selectedImageGallery = resultImage;
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      print('${_currentPosition!.latitude}, ${_currentPosition!.longitude}');
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
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

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    // print("BACK BUTTON!"); // Do some stuff.
    context.goNamed(Routes.home);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            context.goNamed(Routes.home);
          },
          child: const Icon(Icons.arrow_back),
        ),
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
                              onTap: () async {
                                _navigateAndDisplaySelection(context);
                              },
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
                    );
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: lightBackgroundColor,
                      // image:
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
                  height: 10,
                ),
                Text(
                  'Upload Image',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: medium,
                  ),
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
              Switch(
                // This bool value toggles the switch.
                value: light,
                activeColor: Colors.blueAccent,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    light = value;
                  });
                  if (value) {
                    _getCurrentPosition();
                  } else {
                    setState(() {
                      _currentPosition = null;
                      _currentAddress = "";
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text('LAT: ${_currentPosition?.latitude ?? ""}'),
          Text('LNG: ${_currentPosition?.longitude ?? ""}'),
          Text('ADDRESS: ${_currentAddress ?? ""}'),
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
            onPressed: () {
              if (validate()) {
                context.read<StoryBloc>().add(
                      AddStory(
                        selectedImageGallery!,
                        descriptionController.text,
                        _currentPosition!.latitude,
                        _currentPosition!.longitude,
                      ),
                    );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ada yang kosong')));
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            child: BlocConsumer<StoryBloc, StoryState>(
              listener: (context, state) {
                if (state is StorySuccess) {
                  context.goNamed(Routes.home);
                }
                if (state is StoryFailed) {
                  print(state.e);
                  // Fluttertoast.showToast(msg: state.e);
                }
              },
              builder: (context, state) {
                if (state is StoryLoading) {
                  return Text(
                    'Loading . . .',
                    style: blackTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  );
                }
                return Text(
                  'Upload Story',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
