import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:get_it/get_it.dart';

import '../constants.dart';
import '../domain/favorite_model.dart';
import '../domain/hive_model.dart';

class FavoriteShowListWidget extends StatefulWidget {
  const FavoriteShowListWidget({super.key});

  @override
  State<FavoriteShowListWidget> createState() => _FavoriteShowListWidgetState();
}

class _FavoriteShowListWidgetState extends State<FavoriteShowListWidget> {
  final box = Hive.box<ShowHive>('favoriteScreenBox');
  final ValueListenable<Box<ShowHive>> _valueListenable =
      Hive.box<ShowHive>('favoriteScreenBox').listenable();
  final favoriteBox = Hive.box<ShowHive>('favoriteLocalBox');

  final getIt = GetIt.instance;

  @override
  void initState() {
    super.initState();
    startShowsBilding();
  }

  void startShowsBilding() async {
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
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _valueListenable,
        builder: (context, Box<ShowHive> boxs, _) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
            child: ListView.builder(
              itemCount: box.length,
              itemBuilder: (BuildContext context, int index) {
                dynamic showInfo;
                int showId = 0;
                String showLinkImage = '';
                String showName = '';
                String showLanguage = '';
//Index out of range protection, can sometimes go beyond the loop
                if (index < box.length) {
                  showInfo = box.getAt(index);
                  showId = showInfo?.id as int;
                  showLinkImage = showInfo?.image ?? '';
                  showName = showInfo?.name;
                  showLanguage = showInfo?.language;
                }
                return Card(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(showLinkImage),
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
                                (showName),
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
                              getIt<FirecloudeModel>()
                                  .deleteFirestoreShow(showId);
                              getIt<HiveWidgetModel>().deleteShow(showId);
                              startShowsBilding();
                              setState(() {});
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
