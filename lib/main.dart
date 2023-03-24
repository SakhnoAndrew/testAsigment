import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/splash_screen.dart';
import 'package:flutter_application_1/pages/main_pages.dart';
import 'package:flutter_application_1/pages/favorite_page.dart';
import 'package:flutter_application_1/domain/hive_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  await Hive.initFlutter();
  Hive.registerAdapter(ShowHiveAdapter());
  await Hive.openBox<ShowHive>('showBox');

  //WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
