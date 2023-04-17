import 'dart:core';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/pages/navigation_drawer.dart';
import 'package:flutter_application_1/constants.dart';
import '../widgets/favorite_filter.dart';
import '../widgets/favorite_show_list.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 5, 59, 151),
          title: const Text(Constants.favoriteTitie),
        ),
        drawer: const NavigationDrawerWidget(),
        body: Stack(children: const [
          FavoriteShowListWidget(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: FavoriteFilterWidget(),
          )
        ]),
        //const FavoriteShowListWidget(),
      ),
    );
  }
}
