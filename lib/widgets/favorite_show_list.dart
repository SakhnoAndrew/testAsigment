import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../constants.dart';
import '../domain/favorite_model.dart';
import '../domain/hive_model.dart';

class FavoriteShowListWidget extends StatefulWidget {
  const FavoriteShowListWidget({super.key});

  @override
  State<FavoriteShowListWidget> createState() => _FavoriteShowListWidgetState();
}

class _FavoriteShowListWidgetState extends State<FavoriteShowListWidget> {
  final box = Hive.box<ShowHive>
      //('showBoxHive');
      ('favoriteScreenBox');

  //('filterBox');
  final ValueListenable<Box<ShowHive>> _valueListenable =
      Hive.box<ShowHive>('favoriteScreenBox').listenable();
  //int? length;
  final favoriteBox = Hive.box<ShowHive>('showBoxHive');
  final fireModel = FirecloudeEssense();
  final hiveModel = HiveWidgetModel();

  @override
  void initState() {
    super.initState();
    // _valueListenable = box.listenable();
    //length = box.length;
    // Future.delayed(const Duration(milliseconds: 100), () async {});
    //favoriteHiveClear();
    startShowsBilding();
  }

  // void favoriteHiveClear() async {
  //   //int lenght = favoriteResultBox.length;
  //   await box.clear();
  // }

  void startShowsBilding() async {
    //favoriteResultBox.clear();
    //favoriteHiveClear();
    //fireModel.
    //favoriteFilter.favoriteFilter(text);
    //favoriteHiveClear();
    await box.clear();
    setState(() {});
    Future.delayed(const Duration(milliseconds: 200), () async {
      for (int i = 0; i < favoriteBox.length; i++) {
        final filling = favoriteBox.getAt(i);
        final showHive = ShowHive(
            id: filling!.id,
            name: filling.name,
            language: filling.language,
            image: filling.image,
            timeNow: filling.timeNow);
        box.put(i, showHive);
      }
      setState(() {});
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _valueListenable,
        builder: (context, Box<ShowHive> boxs, _) {
          //length = box.length;
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
            child: ListView.builder(
              itemCount: box.length,
              itemBuilder: (BuildContext context, int index) {
                //Future.delayed(const Duration(milliseconds: 100), () {});
                dynamic showinfo;
                dynamic id = 0;
                dynamic linkImage = '';
                dynamic showName = '';
                dynamic showLanguage = '';

                if (index < box.length) {
                  showinfo = box.getAt(index);
                  id = showinfo?.id as int;
                  linkImage = showinfo?.image ?? '';
                  showName = showinfo?.name;
                  showLanguage = showinfo?.language;
                }
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
                              child:
                                  Text("${Constants.language} $showLanguage"),
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
                              fireModel.deleteFirestoreShow(id);
                              hiveModel.deleteShow(id);
                              startShowsBilding();

                              setState(() {
                                //length = box.length;
                              });
                            },
                            style: IconButton.styleFrom(
                                disabledForegroundColor:
                                    Constants.favoriteButtonColor),
                            icon: const Icon(
                              Icons.favorite,
                              color: Constants.favoriteButtonColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}
