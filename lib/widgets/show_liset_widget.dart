//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/domain/hive_model.dart';

class ShowLisetWidget extends StatefulWidget {
  final String imageURL;
  final String title;
  final String text;
  const ShowLisetWidget(
      {super.key,
      required this.imageURL,
      required this.title,
      required this.text});

  @override
  State<ShowLisetWidget> createState() =>
      _ShowLisetWidgetState(imageURL, title, text);
}

class _ShowLisetWidgetState extends State<ShowLisetWidget> {
  final String imageURL;
  final String title;
  final String text;
  _ShowLisetWidgetState(this.imageURL, this.title, this.text);

  late IconData buttonFilling;

  @override
  void initState() {
    buttonFilling = Icons.favorite_border;
    super.initState();
  }

  final model = HiveWidgetModel();

  @override
  Widget build(BuildContext context) {
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
                  child: Text('Language: $text'),
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
                  //dynamic ret = await model.nameReturn(0);
                  setState(() {
                    if (buttonFilling == Icons.favorite_border) {
                      buttonFilling = Icons.favorite;
                      model.saveShow(title, text, imageURL);

                      // print(ret);
                    } else {
                      buttonFilling = Icons.favorite_border;
                    }
                  });
                },
                style:
                    IconButton.styleFrom(disabledForegroundColor: Colors.red),
                icon: Icon(
                  buttonFilling,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
