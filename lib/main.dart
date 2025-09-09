import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Configuration/ChangeMode.dart';
import 'package:provider/provider.dart';
import 'Configuration/Routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "OpenLibrary Book Explorer",
      // home: SignUpScreen(),
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
