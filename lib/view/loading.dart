import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/view_model/location_controller.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  final locationController = Get.put(LocationController());

  @override
  void initState() {
    super.initState();
    locationController.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
