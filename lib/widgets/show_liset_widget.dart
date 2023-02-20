import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
      _ShowLisetWidgetState(this.imageURL, this.title, this.text);
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

  @override
  Widget build(BuildContext context) {
    //   return showLisetWidget();
    // }

    // Widget showLisetWidget(
    //     {String imageURL = "", String title = "", String text = ""}) {
    //   dynamic buttonFilling = Icons.favorite_border;
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
                  setState(() {
                    if (buttonFilling == Icons.favorite_border) {
                      buttonFilling = Icons.favorite;
                      FirebaseFirestore.instance.collection('shows').add(
                          {'title': title, 'text': text, 'imageURL': imageURL});
                    } else {
                      buttonFilling = Icons.favorite_border;
                      //FirebaseFirestore.instance.collection('shows').doc(snapshot.doc.)
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
