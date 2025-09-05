import 'package:flutter/material.dart';


import 'Configuration/Routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
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

