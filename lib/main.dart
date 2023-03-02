import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'package:flutter_application_1/domain/hive_model.dart';
import 'package:flutter_application_1/pages/splash_screen.dart';
import 'package:flutter_application_1/pages/main_pages.dart';
import 'package:flutter_application_1/pages/favorite_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  Hive.registerAdapter(ShowHiveAdapter());

  runApp(
    MaterialApp(
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/': (context) => const MainPage(),
        '/favorite': (context) => const FavoritePage(),
      },
    ),
  );
}
