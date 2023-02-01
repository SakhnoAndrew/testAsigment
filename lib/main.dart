import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main_pages.dart';
import 'package:flutter_application_1/pages/favorite_page.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => MainPage(),
          '/favorite': (context) => FavoritePage(),
        },
      ),
    );
