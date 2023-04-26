import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:get_it/get_it.dart';

import '../constants.dart';
import '../domain/favorite_model.dart';
import '../domain/hive_model.dart';

class MainShowListWidget extends StatefulWidget {
  const MainShowListWidget({super.key});

  @override
  State<MainShowListWidget> createState() => _MainShowListWidgetState();
}

class _MainShowListWidgetState extends State<MainShowListWidget> {
  final box = Hive.box<ShowHive>('mainScreenBox');
  ValueListenable<Box<ShowHive>> _valueListenable =
      Hive.box<ShowHive>('favoriteLocalBox').listenable();
  List iconsMass = [];

  final getIt = GetIt.instance;

  @override
  void initState() {
    super.initState();
    _valueListenable = box.listenable();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _valueListenable,
      builder: (context, Box<ShowHive> boxs, _) {
        iconsMass.clear();
        //favorite icons collor
        for (int i = 0; i < box.length; i++) {
          final showinfo = box.getAt(i);
          int comparasion =
              getIt<HiveWidgetModel>().checkingForFavorite(showinfo!.id);
          if (comparasion != 0) iconsMass.add(Icons.favorite);
          if (comparasion == 0) iconsMass.add(Icons.favorite_border);
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
          child: ListView.builder(
            itemCount: box.length,
            itemBuilder: (BuildContext context, int index) {
              final showinfo = box.getAt(index);
              return Card(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(showinfo?.image ?? ''),
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
                              (showinfo?.name as String),
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 60, 10),
                            child: Text(
                                "${Constants.language} ${showinfo?.language}"),
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
                            if (iconsMass[index] == Icons.favorite_border) {
                              final timeNow = DateTime.now();
                              setState(() {});
                              //add informaition in Firecloud
                              FirebaseFirestore.instance
                                  .collection('shows')
                                  .add({
                                'id': showinfo?.id as int,
                                'title': showinfo?.name,
                                'text': showinfo?.language,
                                'imageURL': showinfo?.image ?? '',
                                'time': timeNow,
                              });
                              //add information in local Database
                              getIt<HiveWidgetModel>().saveShow(
                                  showinfo?.id as int,
                                  showinfo?.name as String,
                                  showinfo?.language as String,
                                  showinfo?.image ?? '',
                                  timeNow);
                              iconsMass[index] = Icons.favorite;
                              setState(() {});
                            } else {
                              getIt<FirecloudeModel>()
                                  .deleteFirestoreShow(showinfo?.id as int);
                              getIt<HiveWidgetModel>()
                                  .deleteShow(showinfo?.id as int);
                              iconsMass[index] = Icons.favorite_border;
                              setState(() {});
                            }
                            setState(() {});
                          },
                          style: IconButton.styleFrom(
                              disabledForegroundColor:
                                  Constants.favoriteButtonColor),
                          icon: Icon(
                            iconsMass[index],
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
      },
    );
  }
}
