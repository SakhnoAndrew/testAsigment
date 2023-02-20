import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main_pages.dart';
import 'package:flutter_application_1/pages/favorite_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //     apiKey: 'AIzaSyCI6523_7T2PsXS3jw5VXoT0GIXwd7P9u4',
      //     appId: '1:126427350071:android:c249473cfe857094266bb2',
      //     messagingSenderId: '126427350071',
      //     projectId: 'testassigment',
      //     storageBucket: 'testassigment.appspot.com')
      );
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/favorite': (context) => const FavoritePage(),
      },
    ),
  );
}
