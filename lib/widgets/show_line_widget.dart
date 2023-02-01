import 'package:flutter/material.dart';

Widget showLineWidget(
    {String imageURL = "", String title = "", String text = ""}) {
  //widget for result search
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
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Text(
            "Titile: $title",
            style: const TextStyle(fontSize: 15),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 60, 10),
          child: Text('Language: $text'),
        ),
        const Spacer(),
        Container(
          width: 65,
          height: 50,
          child: Center(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
