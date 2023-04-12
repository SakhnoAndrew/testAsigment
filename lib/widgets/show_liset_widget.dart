import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/domain/favorite_model.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/domain/hive_model.dart';

class ShowLisetWidget extends StatefulWidget {
  final int id;
  final String imageURL;
  final String title;
  final String text;
  const ShowLisetWidget(
      {super.key,
      required this.id,
      required this.imageURL,
      required this.title,
      required this.text});

  @override
  State<ShowLisetWidget> createState() =>
      // ignore: no_logic_in_create_state
      _ShowLisetWidgetState(id, imageURL, title, text);
}

class _ShowLisetWidgetState extends State<ShowLisetWidget> {
  final int id;
  final String imageURL;
  final String title;
  final String text;

  _ShowLisetWidgetState(
    this.id,
    this.imageURL,
    this.title,
    this.text,
  );

  late IconData buttonFilling = Icons.favorite_border;
  List<ShowHive>? data;
  final fireModel = FirecloudeEssense();
  final hiveModel = HiveWidgetModel();
  int comparasion = 0;

  @override
  void initState() {
    comparasion = hiveModel.checkingForFavorite(id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (comparasion != 0) {
      buttonFilling = Icons.favorite;
    }

    return Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageURL),
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
                    title,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 60, 10),
                  child: Text('${Constants.language} $text'),
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
                style: IconButton.styleFrom(
                    disabledForegroundColor: Constants.favoriteButtonColor),
                icon: Icon(
                  buttonFilling,
                  color: Constants.favoriteButtonColor,
                ),
                onPressed: () {
                  if (comparasion == 0) {
                    final timeNow = DateTime.now();
                    setState(() {});
                    FirebaseFirestore.instance.collection('shows').add({
                      'id': id,
                      'title': title,
                      'text': text,
                      'imageURL': imageURL,
                      'time': timeNow,
                    });
                    hiveModel.saveShow(id, title, text, imageURL, timeNow);
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
