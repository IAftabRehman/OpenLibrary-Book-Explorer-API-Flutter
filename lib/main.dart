import 'package:flutter/material.dart';


import 'Configuration/Routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Finder Application',
      initialRoute: AppRoutes.onBoarding,
      routes: AppRoutes.routes,
    );
  }
}

