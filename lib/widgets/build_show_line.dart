import 'package:flutter/material.dart';

Widget buildShowLine(
    {String imageURL = "", String title = "", String text = ""}) {
  //widget for result search
  return Card(
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageURL),
            radius: 30,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 60, 10),
          child: Text(text),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.heart_broken_outlined,
            color: Colors.red,
          ),
        )
      ],
    ),
  );
}
