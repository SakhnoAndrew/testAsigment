import 'dart:core';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_application_1/domain/hive_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/navigation_drawer.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final _box = Hive.box<ShowHive>('showBox');
  int? length;
  dynamic model;

  @override
  void initState() {
    super.initState();
    // model = _box.values;
    length = _box.length;
  }

  final HiveWidgetModel hiveWidgetModel = HiveWidgetModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 5, 59, 151),
          title: const Text("Favorite"),
        ),
        drawer: const NavigationDrawerWidget(),
        body: ListView.builder(
          itemCount: length,
          itemBuilder: (BuildContext context, int index) {
            final showinfo = _box.getAt(index);
            var linkImage = showinfo?.image ?? '';
            var showName = showinfo?.name;
            var showLanguage = showinfo?.language;
            return Card(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(linkImage),
                      radius: 30,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                          child: Text(
                            ('$showName'),
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 60, 10),
                          child: Text("Language: $showLanguage"),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 65,
                    height: 50,
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          _box.deleteAt(index);
                          setState(() {
                            length = _box.length;
                          });
                        },
                        style: IconButton.styleFrom(
                            disabledForegroundColor: Colors.red),
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
