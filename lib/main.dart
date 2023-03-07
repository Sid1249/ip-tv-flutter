import 'package:flutter/material.dart';
import 'ui/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TV App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IPTVScreen(),
    );
  }
}
