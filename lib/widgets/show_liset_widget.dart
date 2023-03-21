import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_application_1/pages/main_pages.dart';
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

  late IconData buttonFilling;
  List<ShowHive>? data;
  final fireModel = FirecloudeEssense();
  final hiveModel = HiveWidgetModel();
  //final model = MainPage();

  @override
  void initState() {
    buttonFilling = Icons.favorite_border;
    getData();
    super.initState();
  }

  void getData() async {
    data = await fireModel.getDataFromFirestore();
    // print("object");
  }

  int checkingForFavorite(int id) {
    int counter = 0;
    int max = data?.length ?? 0;
    for (int index = 0; index < max; index++) {
      var showId = data?[index].id ?? 0;
      if (id == showId) {
        counter++;
      }
    }
    return counter;
  }

  @override
  Widget build(BuildContext context) {
    int comparasion = checkingForFavorite(id);
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
                onPressed: () {
                  if (comparasion == 0) {
                    buttonFilling = Icons.favorite;

                    hiveModel.saveShow(id, title, text, imageURL);

                    FirebaseFirestore.instance.collection('shows').add({
                      'id': id,
                      'title': title,
                      'text': text,
                      'imageURL': imageURL
                    });

                    //model.saveShow(title, text, imageURL);
                    setState(() {});
                  } else {
                    //model.deleteShow(title, text, imageURL);
                    buttonFilling = Icons.favorite_border;
                    setState(() {});
                  }

                  // setState(() {
                  //   if (buttonFilling == Icons.favorite_border) {
                  //     buttonFilling = Icons.favorite;
                  // FirebaseFirestore.instance.collection('shows').add({
                  //   'id': id,
                  //   'title': title,
                  //   'text': text,
                  //   'imageURL': imageURL
                  // });
                  //   } else {
                  //     buttonFilling = Icons.favorite_border;
                  //   }
                  // });
                },
                style: IconButton.styleFrom(
                    disabledForegroundColor: Constants.favoriteButtonColor),
                icon: Icon(
                  buttonFilling,
                  color: Constants.favoriteButtonColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
