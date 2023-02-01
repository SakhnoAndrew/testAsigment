import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/navigation_drawer.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 5, 59, 151),
          title: const Text("Favorite"),
        ),
        drawer: const NavigationDrawerWidget(),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(8.0),
          ),
        ),
      ),
    );
  }
}
