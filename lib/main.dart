import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:openlibrary_book_explorer/Providers/ContactProvider.dart';
import 'package:provider/provider.dart';
import 'Configuration/Routes.dart';
import 'Providers/AuthenticationProvider.dart';
import 'Providers/FavoriteProvider.dart';
import 'Providers/LibraryProvider.dart';
import 'Providers/ChangeModeProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LibraryProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => ContactProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "OpenLibrary Book Explorer",
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
