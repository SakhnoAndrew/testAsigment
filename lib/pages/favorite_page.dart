import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/build_show_line.dart';
import 'package:flutter_application_1/widgets/build_search_text.dart';
import 'package:flutter_application_1/domain/api_client.dart';
import 'package:flutter_application_1/pages/navigation_draver.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

// --------------------------------------------------- //
// class DataModel {
//   final String imageURL;
//   final String title;
//   final String text;

//   DataModel({required this.imageURL, required this.title, required this.text});
// }

// List<DataModel> dataShows = [
//   DataModel(
//     imageURL:
//         'https://static.tvmaze.com/uploads/images/medium_portrait/31/78286.jpg',
//     title: 'Title 1',
//     text: 'Text 1',
//   ),
//   DataModel(
//     imageURL:
//         'https://static.tvmaze.com/uploads/images/medium_portrait/31/78286.jpg',
//     title: 'Title 2',
//     text: 'Text 2',
//   ),
//   // Add more DataModel objects here
// ];
// --------------------------------------------------- //

// --------------------------------------------------- //
// var cycle = ShowCycle();

// class ShowCycle {
//   List<Widget> showCycleOne() {
//     List<Widget> widgets = [];

//     widgets.add(buildSearchTextField());

//     for (int i = 0; i < DataFetcher().show.length - 1; i++) {
//       widgets.add(buildShowLine(
//         title: DataFetcher().show[i].name,
//         text: DataFetcher().show[i].language,
//         imageURL: DataFetcher().show[i].image[1],
//       ));
//     }

//     return widgets;
//   }
// }

// --------------------------------------------------- //

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 5, 59, 151),
          // leading: IconButton(
          //     onPressed: () {
          //       Navigator.pushReplacementNamed(context, '/navigation');
          //     },
          //     icon: const Icon(Icons.dehaze_outlined)),
          title: const Text("Favorite"),
        ),
        drawer: const NavigationDrawer(),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            //children: cycle.showCycleOne(),
          ),
        ),
      ),
    );
  }
}
