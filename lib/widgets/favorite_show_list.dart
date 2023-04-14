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
  final box = Hive.box<ShowHive>('showBoxHive');
  ValueListenable<Box<ShowHive>> _valueListenable =
      Hive.box<ShowHive>('showBoxHive').listenable();
  int? length;
  final fireModel = FirecloudeEssense();
  final hiveModel = HiveWidgetModel();

  @override
  void initState() {
    super.initState();
    _valueListenable = box.listenable();
    length = box.length;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _valueListenable,
        builder: (context, Box<ShowHive> box, _) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (BuildContext context, int index) {
              final showinfo = box.getAt(index);
              int id = showinfo?.id as int;
              var linkImage = showinfo?.image ?? '';
              var showName = showinfo?.name;
              var showLanguage = showinfo?.language;
              //box.
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
                            child: Text("${Constants.language} $showLanguage"),
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

                            setState(() {
                              length = box.length;
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
          );
        });
  }
}
