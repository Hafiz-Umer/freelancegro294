import 'dart:io';

import 'package:demo_app_location/Services/location_services.dart';
import 'package:demo_app_location/Widgets/custom_button.dart';
import 'package:demo_app_location/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_android/geolocator_android.dart';
import 'package:geolocator_apple/geolocator_apple.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Position? position;
  bool isLoading = true;

  void _registerPlatformInstance() {
    if (Platform.isAndroid) {
      GeolocatorAndroid.registerWith();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _registerPlatformInstance();
    init();
  }

  void init() async {
    position = await LocationServices.getGeoLocationPosition();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CustomButton(
                    onPressed: () async {
                      position =
                          await LocationServices.getGeoLocationPosition();
                      setState(() {});
                    },
                    btnHeight: 50,
                    btnWidth: MediaQuery.of(context).size.width / 2,
                    btnBorderColor: Colors.blue,
                    btnBorderWidth: 2,
                    title: "Get my geolocation",
                    textColor: Colors.blue,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  title:
                      "Longitude: ${position!.longitude}, Lattitude: ${position!.latitude}",
                )
              ],
            ),
    );
  }
}
