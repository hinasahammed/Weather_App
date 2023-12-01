import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/view/loading.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xff2F58CD),
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather app',
      theme: theme,
      home: const LoadingView(),
    );
  }
}
