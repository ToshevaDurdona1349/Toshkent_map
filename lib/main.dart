import 'package:flutter/material.dart';

import 'map/pages/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yandex Map',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MapScreen(),
    );
  }
}
