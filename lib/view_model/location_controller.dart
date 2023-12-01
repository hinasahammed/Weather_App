import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model/weather_model.dart';
import 'package:weather_app/view/location.dart';

class LocationController extends GetxController {
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
  Rx<WeatherModel> model = WeatherModel().obs;
  void getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    lat.value = position.latitude;
    long.value = position.longitude;
    fetchWeather();
  }

  void fetchWeather() async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${lat.value}&lon=${long.value}&appid=65abb2441d4455f87ffbecaf6082c0b4&units=metric';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        model.value = WeatherModel.fromJson(data);
        Get.to(() => const LocationView());
      } else {
        Fluttertoast.showToast(msg: 'Failed to fetch weather data');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }
}
