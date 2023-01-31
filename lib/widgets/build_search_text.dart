import 'package:flutter/material.dart';

Widget buildSearchTextField() {
  //widget for search text field
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
    child: TextField(
      keyboardType: TextInputType.name,
      //style: Theme.of(context).textTheme.headline6,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search),
        labelText: 'Enter show',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
      ),
    ),
  );
}
