import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../constants.dart';
import '../domain/favorite_model.dart';
import '../domain/hive_model.dart';

//----------------------- unfinished widget ------------------------------//

class MainShowList extends StatefulWidget {
  const MainShowList({super.key});

  @override
  State<MainShowList> createState() => _MainShowListState();
}

class _MainShowListState extends State<MainShowList> {
  final box = Hive.box<ShowHive>('mainScreenBox');
  //final box = Hive.box<ShowHive>('showBoxHive');
  ValueListenable<Box<ShowHive>> _valueListenable =
      Hive.box<ShowHive>('showBoxHive').listenable();
  //int? length;
  final fireModel = FirecloudeEssense();
  final hiveModel = HiveWidgetModel();
  int comparasion = 0;
  late IconData buttonFilling = Icons.favorite_border;

  @override
  void initState() {
    super.initState();
    _valueListenable = box.listenable();
    //length = box.length;
  }

  @override
  Widget build(BuildContext context) {
    // ValueListenableBuilder in future
    return ValueListenableBuilder(
      valueListenable: _valueListenable,
      builder: (context, Box<ShowHive> box, _) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
          child: ListView.builder(
            itemCount: box.length,
            itemBuilder: (BuildContext context, int index) {
              final showinfo = box.getAt(index);
              int id = showinfo?.id as int;
              var linkImage = showinfo?.image ?? '';
              var showName = showinfo?.name;
              var showLanguage = showinfo?.language;
              comparasion = hiveModel.checkingForFavorite(id);
              if (comparasion != 0) {
                buttonFilling = Icons.favorite;
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
                            if (comparasion == 0) {
                              final timeNow = DateTime.now();
                              setState(() {});
                              FirebaseFirestore.instance
                                  .collection('shows')
                                  .add({
                                'id': id,
                                'title': showName,
                                'text': showLanguage,
                                'imageURL': linkImage,
                                'time': timeNow,
                              });
                              hiveModel.saveShow(id, showName!, showLanguage!,
                                  linkImage, timeNow);
                              buttonFilling = Icons.favorite;
                              comparasion++;
                              setState(() {});
                            } else {
                              fireModel.deleteFirestoreShow(id);
                              hiveModel.deleteShow(id);
                              buttonFilling = Icons.favorite_border;
                              comparasion = 0;
                              setState(() {});
                            }
                            setState(() {});
                          },
                          style: IconButton.styleFrom(
                              disabledForegroundColor:
                                  Constants.favoriteButtonColor),
                          icon: Icon(
                            //Icons.favorite,
                            buttonFilling,
                            color: Constants.favoriteButtonColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
              // );
            },
          ),
        );
      },
    );
  }
}
