import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/splash_screen.dart';
import 'package:flutter_application_1/pages/main_pages.dart';
import 'package:flutter_application_1/pages/favorite_page.dart';
import 'package:flutter_application_1/domain/hive_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'domain/favorite_model.dart';
import 'domain/main_model.dart';
import 'firebase_options.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ShowHiveAdapter());
  Hive.registerAdapter(ShowNameAdapter());
  await Hive.openBox<ShowHive>('favoriteLocalBox');
  await Hive.openBox<ShowHive>('mainScreenBox');
  await Hive.openBox<ShowHive>('favoriteScreenBox');
  await Hive.openBox<ShowHive>('filterBox');
  await Hive.openBox<ShowName>('nameBox');

  //get_it initialization
  final getIt = GetIt.instance;
  getIt.registerSingleton<HiveWidgetModel>(HiveWidgetModel());
  getIt.registerSingleton<FirecloudeModel>(FirecloudeModel());
  getIt.registerSingleton<MainScreenModel>(MainScreenModel());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  getIt<FirecloudeModel>().timeCompare();

  runApp(
    ProviderScope(
      child: MaterialApp(
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/': (context) => const MainPage(),
          '/favorite': (context) => const FavoritePage(),
        },
      ),
    ),
  );
}
