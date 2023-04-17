import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/splash_screen.dart';
import 'package:flutter_application_1/pages/main_pages.dart';
import 'package:flutter_application_1/pages/favorite_page.dart';
import 'package:flutter_application_1/domain/hive_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'domain/favorite_model.dart';
import 'firebase_options.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  await Hive.initFlutter();
  Hive.registerAdapter(ShowHiveAdapter());
  Hive.registerAdapter(ShowNameAdapter());
  await Hive.openBox<ShowHive>('showBoxHive');
  await Hive.openBox<ShowHive>('mainScreenBox');
  await Hive.openBox<ShowHive>('favoriteScreenBox');
  await Hive.openBox<ShowHive>('filterBox');
  await Hive.openBox<ShowName>('nameBox');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final fireModel = FirecloudeEssense();
  fireModel.timeCompare();

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
