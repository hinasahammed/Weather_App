import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/uitls/weather.dart';
import 'package:weather_app/view_model/location_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final locationController = Get.put(LocationController());
  final weatherSymbols = WeatherSymbols();
  String weatherIcon = '';
  String weatherMessage = '';

  @override
  void initState() {
    super.initState();
    weatherIcon = weatherSymbols
        .getWeatherIcon(locationController.model.value.weather?[0].id ?? 300);
    weatherMessage = weatherSymbols
        .getMessage(locationController.model.value.main?.temp?.toInt() ?? 20);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final model = locationController.model.value;
    return Scaffold(
      appBar: AppBar(
        title: Text(model.name == null ? '' : model.name!.toUpperCase()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Column(
          children: [
            Image.asset('images/weather.png'),
            Expanded(
              child: Text(
                '${model.main?.temp?.round().toString()}°C',
                style: theme.textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 80,
                ),
              ),
            ),
            Expanded(
              child: Text(
                model.weather?[0].main ?? "",
                style: theme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Minimum Temperature',
                          style: theme.textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          model.main?.tempMin?.round().toString() ?? "",
                          style: theme.textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Maximum Temperature',
                          style: theme.textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          model.main?.tempMax?.round().toString() ?? "",
                          style: theme.textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
